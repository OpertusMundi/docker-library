FROM jupyter/minimal-notebook:python-3.8.8

USER root

RUN apt-get update && apt-get install -y --no-install-recommends libproj-dev proj-bin \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

USER $NB_USER

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
