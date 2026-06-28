FROM python:3.12-slim

WORKDIR /app

COPY app.py .

RUN pip install flask pika

EXPOSE 5000

CMD ["python", "app.py"]