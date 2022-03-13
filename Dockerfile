ARG IMAGE
ARG UID
ARG GID

FROM ${IMAGE}

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential \
    && apt-get autoremove -yqq --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER ${UID}:${GID}

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir --user -r requirements.txt
