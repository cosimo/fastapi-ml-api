# encoding: utf-8

"""
Simple FastAPI application to demonstrate a ML-based API

https://github.com/cosimo/fastapi-ml-api
"""

import os
from typing import Optional

from fastapi import FastAPI, Depends, Request, Header
from fastapi.responses import FileResponse
from fastapi.staticfiles import StaticFiles
from fastapi.openapi.utils import get_openapi

import classifier
from models import SomeRequest, SomeResponse, SoftwareMetadata
from log import logger


VERSION = os.environ.get("APP_VERSION", "dev")
SHA = os.environ.get("GITHUB_SHA", "HEAD")[0:8]

# We need to ensure that the model is loaded when the application is first
# initialized by the application server
model = None


def create_app():
    global model

    myapp = FastAPI()
    myapp.mount("/assets", StaticFiles(directory="assets"), name="assets")

    model = classifier.get_model()
    return myapp


app: FastAPI = create_app()


def provide_model(request: Request):
    return model


@app.get("/")
def index():
    """
    Serves a mostly empty index page
    """
    return FileResponse("index.html")


@app.get("/classify", response_model=SomeResponse)
def classify(text: str,
             authorization: Optional[str] = Header(None),
             language_model=Depends(provide_model)):
    """
    Classify a text sentences
    """
    categories = classifier.get_categories(text=text, model=language_model)

    return SomeResponse(categories=categories,
                        meta=SoftwareMetadata(rev=SHA, version=VERSION))


@app.get("/healthcheck", response_model=dict)
def health_check():
    """
    Basic service health check endpoint.

    Responds with `{"status": "alive", "rev": <version>}`. When the workers
    are starting up, the health check endpoint will hang and not work.
    That is the way the orchestrator will detect when the ML model is loaded.
    """
    return {"status": "alive",
            "version": VERSION,
            "rev": SHA}


def custom_openapi():
    if app.openapi_schema:
        return app.openapi_schema

    openapi_schema = get_openapi(
        title="myproject",
        version="1",
        description="Your project description goes here",
        routes=app.routes,)

    openapi_schema["info"]["x-logo"] = {"url": "/assets/logo.svg"}
    app.openapi_schema = openapi_schema

    return app.openapi_schema


app.openapi = custom_openapi
