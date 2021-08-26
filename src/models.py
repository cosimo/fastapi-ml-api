# encoding: utf-8

from pydantic import BaseModel, Field
from typing import List


class SomeRequest(BaseModel):
    text: str = Field(None, description='Text to be classified',
                      example='The Horse Raced Past the Barn Fell')


class SoftwareMetadata(BaseModel):
    version: str
    rev: str


class SomeResponse(BaseModel):
    categories: List[str] = Field(None, description='List of categories')
    meta: SoftwareMetadata
