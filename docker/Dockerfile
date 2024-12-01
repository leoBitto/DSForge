FROM python:3.10-slim-buster

# Previene la scrittura di file .pyc
ENV PYTHONDONTWRITEBYTECODE 1
# Previene il buffering dell'output Python
ENV PYTHONUNBUFFERED 1

# Crea un utente non-root
RUN addgroup --system appuser && adduser --system --group appuser

# Imposta la directory di lavoro
WORKDIR /app

# Copia e installa dipendenze
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia il codice dell'applicazione
COPY --chown=appuser:appuser . .

# Cambia all'utente non-root
USER appuser

# Porta Streamlit
EXPOSE 8501

# Comando di avvio
CMD ["streamlit", "run", "app/app.py", "--server.port=8501", "--server.address=0.0.0.0"]