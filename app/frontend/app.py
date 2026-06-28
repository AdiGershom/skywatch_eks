from flask import Flask, request
import pika
import os

app = Flask(__name__)


RABBITMQ_HOST = os.getenv("RABBITMQ_HOST", "skywatch-rabbitmq")
RABBITMQ_PORT = int(os.getenv("RABBITMQ_PORT", "5672"))
RABBITMQ_USER = os.getenv("RABBITMQ_USER")
RABBITMQ_PASSWORD = os.getenv("RABBITMQ_PASSWORD")


@app.route("/")
def home():
    return "SkyWatch Frontend Running"


@app.route("/weather", methods=["POST"])
def weather():

    city = request.json["city"]


    credentials = pika.PlainCredentials(
        RABBITMQ_USER,
        RABBITMQ_PASSWORD
    )


    connection = pika.BlockingConnection(
        pika.ConnectionParameters(
            host=RABBITMQ_HOST,
            port=RABBITMQ_PORT,
            credentials=credentials
        )
    )


    channel = connection.channel()


    channel.queue_declare(
        queue="weather"
    )


    channel.basic_publish(
        exchange="",
        routing_key="weather",
        body=city
    )


    connection.close()


    return {
        "status": "sent",
        "city": city
    }


if __name__ == "__main__":

    app.run(
        host="0.0.0.0",
        port=5000
    )