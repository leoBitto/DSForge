# Usa un'immagine di base per Jupyter Notebook
FROM jupyter/base-notebook:latest

# Imposta la directory di lavoro nel container
WORKDIR /home/jovyan/work

# Installa pacchetti Python aggiuntivi
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Espone la porta per Jupyter
EXPOSE 8888

# Configura Jupyter per non usare token o password
CMD ["start-notebook.sh", "--NotebookApp.token=''", "--NotebookApp.password=''"]
