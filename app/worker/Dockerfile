FROM python:3.12-slim

WORKDIR /app

COPY worker.py .

RUN pip install pika requests

CMD ["python", "worker.py"]