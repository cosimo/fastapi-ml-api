# encoding: utf-8

"""
Classifier
==========

Explain here what this code and this model are doing
"""

import os
from typing import List, Optional

from log import logger


DEFAULT_MODEL = 'xyz'


def get_model():
    model_name = os.environ.get('NLP_MODEL', DEFAULT_MODEL)
    model = None

    # model = load_model(model_name)
    # model.eval()
    # model.share_memory()

    return model


def get_categories(text: str, model) -> List[str]:
    """
    Given a text, classify it returning a list of categories.

    Blah blah blah
    """

    # TODO use the model to do something here

    categories = ["cat1", "cat2"]

    return categories
