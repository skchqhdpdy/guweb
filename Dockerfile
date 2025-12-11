FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1

WORKDIR /srv/root

RUN apt update && apt install --no-install-recommends -y \
    git curl build-essential=12.12 \
    && rm -rf /var/lib/apt/lists/*

RUN apt update && \
    apt install -y default-mysql-client redis-tools

COPY ext/requirements.txt ./ext/requirements.txt

RUN pip install --upgrade pip && \
    pip install -r ./ext/requirements.txt

# NOTE: done last to avoid re-run of previous steps
COPY . .

ENTRYPOINT ["python3", "main.py"]