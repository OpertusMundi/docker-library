FROM jupyter/minimal-notebook:python-3.8.8

USER $NB_USER

RUN pip install --no-cache-dir numpy pandas jupyterlab_daisy
RUN mkdir -v -p $HOME/.jupyter/lab/user-settings/jupyterlab_daisy && \
  echo '{"daisy_address": "discovery-api.default.svc.cluster.local:8080"}' > $HOME/.jupyter/lab/user-settings/jupyterlab_daisy/plugin.jupyterlab-settings
  
RUN jupyter labextension enable jupyterlab_daisy
