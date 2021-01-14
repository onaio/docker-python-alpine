ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION}-alpine as final

USER root
WORKDIR /code
ADD requirements.txt requirements.txt
RUN apk add --no-cache postgresql-libs && \
    apk add --no-cache --virtual .build-deps gcc musl-dev postgresql-dev && \
    pip install --no-cache-dir --upgrade pip virtualenv && \
    virtualenv /root/.venv && \
    /root/.venv/bin/pip install --no-cache-dir -r requirements.txt && \
    apk --purge del .build-deps && \
    ls -a && \
    rm -rf ./* && \
    rm -rf /root/.cache
