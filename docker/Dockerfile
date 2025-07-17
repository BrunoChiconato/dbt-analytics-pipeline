FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

COPY . /app

WORKDIR /app/northwind

RUN pip install --no-cache-dir -r ../requirements.txt

CMD ["dbt", "run"]