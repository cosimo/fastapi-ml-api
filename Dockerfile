FROM your.docker.registry/myproject:stage1

ARG GITHUB_SHA=dev
ARG GITHUB_REF=main
ENV APP_VERSION=dev
ENV NLP_MODEL=some-model-name-here

# Gunicorn configuration env variables
ENV LOG_LEVEL=info
ENV MAX_WORKERS=3
ENV PORT=8000

# Give the workers enough time to load the language model (30s is not enough)
ENV TIMEOUT=60

# Install all the other required python dependencies
COPY ./requirements.txt /app
RUN pip3 install -r /app/requirements.txt

#
# Extra setup steps can be carried out here
# f.ex. provision NLTK data files that your app will use.
#

#ENV NLTK_DATA=/app/nltk_data
#RUN python -c 'import os; import nltk; nltk.download("stopwords", download_dir=os.environ.get("NLTK_DATA"))'
#COPY ./nltk_data/corpora/stopwords/* $NLTK_DATA/corpora/stopwords/

COPY ./config/gunicorn_conf.py /gunicorn_conf.py
COPY ./src /app
COPY ./tests /tests
