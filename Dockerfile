FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONPATH=/EROS4NRG

WORKDIR /EROS4NRG

RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install --no-cache-dir -r requirements.txt

COPY config ./config
COPY clients ./clients
COPY import_data.py start_importer.sh ./

RUN chmod +x start_importer.sh

ENTRYPOINT ["bash", "./start_importer.sh"]