FROM jupyter/minimal-notebook:2343e33dec46

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends libproj-dev=4.9.3-2 proj-bin=4.9.3-2 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

USER $NB_USER

RUN pip install --no-cache-dir pyproj==2.2.0 geopandas==0.9.0 matplotlib==3.4.1
RUN python -c "import matplotlib.pyplot" 
