# encoding: utf-8
"""
Simple logging wrapper to generate JSON logs for kubernetes

JSON logging is enabled by default.
To disable it, run gunicorn with the environment variable:

   JSON_LOGS=False

"""

import os
import sys
from loguru import logger

json_logging = os.environ.get("JSON_LOGS", "true") == "true"

logger.configure(
     handlers=[{"sink": sys.stdout, "serialize": json_logging}])

__all__ = ['logger']
