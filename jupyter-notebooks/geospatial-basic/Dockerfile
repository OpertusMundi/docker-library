FROM jupyter/minimal-notebook:python-3.8.8

USER root

RUN apt-get update && apt-get install -y --no-install-recommends libproj-dev proj-bin \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

USER $NB_USER

RUN pip install --no-cache-dir geopandas==0.9.0 matplotlib==3.4.1
