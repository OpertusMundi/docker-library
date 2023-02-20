FROM jupyter/minimal-notebook:python-3.8.8

USER $NB_USER

RUN pip install --no-cache-dir notebook_shim==0.2.2 numpy pandas jupyterlab_daisy==1.0.5
  
#RUN jupyter labextension enable jupyterlab_daisy
