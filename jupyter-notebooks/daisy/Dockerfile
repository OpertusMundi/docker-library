FROM jupyter/minimal-notebook:python-3.8.8

USER $NB_USER

RUN pip install --no-cache-dir notebook_shim==0.2.2 numpy pandas jupyterlab_daisy==1.0.6

#COPY jupyter_server_config-for-daisy.py /etc/jupyter/
#RUN cat /etc/jupyter/jupyter_server_config-for-daisy.py >>/etc/jupyter/jupyter_server_config.py 
#RUN cat /etc/jupyter/jupyter_server_config-for-daisy.py >>/etc/jupyter/jupyter_notebook_config.py 

#RUN jupyter labextension enable jupyterlab_daisy
