import os

environment = os.environ["ENVIRONMENT"]

bind = "0.0.0.0:8000"
worker_class = "uvicorn.workers.UvicornWorker"
timeout = 30
accesslog = "-"
access_log_format = (
    '{'
    '"date": "%(t)s",'
    '"status_line": "%(r)s",'
    '"remote_address": "%(h)s",'
    '"status": "%(s)s",'
    '"response_length": "%(b)s",'
    '"request_time": "%(L)s",'
    '"referer": "%(f)s",'
    '}'
)
if environment == "production":
    workers = 4
    preload_app = True
    loglevel = "INFO"
else:
    workers = 2
    reload = True
    loglevel = "DEBUG"
