#!/usr/bin/env python
# encoding: utf-8

from fastapi.testclient import TestClient
from main import app

client = TestClient(app)


def test_some_endpoint():
    response = client.get(url="/classify?text=Testing+Here")
    assert response.status_code == 200
