import os
import json
import time

import pika
import requests
import certifi
import urllib3


urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)


RABBITMQ_HOST = os.getenv("RABBITMQ_HOST", "skywatch-rabbitmq")
RABBITMQ_PORT = int(os.getenv("RABBITMQ_PORT", "5672"))
RABBITMQ_USER = os.getenv("RABBITMQ_USER")
RABBITMQ_PASSWORD = os.getenv("RABBITMQ_PASSWORD")


def get_weather(city):
    url = (
        "https://geocoding-api.open-meteo.com/v1/search"
        f"?name={city}&count=1"
    )

    response = requests.get(
        url,
        verify=certifi.where(),
        timeout=10
    )

    data = response.json()

    if "results" not in data:
        return {
            "city": city,
            "error": "City not found"
        }

    location = data["results"][0]

    latitude = location["latitude"]
    longitude = location["longitude"]

    forecast_url = (
        "https://api.open-meteo.com/v1/forecast"
        f"?latitude={latitude}"
        f"&longitude={longitude}"
        "&current_weather=true"
    )

    forecast = requests.get(
        forecast_url,
        verify=certifi.where(),
        timeout=10
    ).json()

    return {
        "city": city,
        "temperature": forecast["current_weather"]["temperature"],
        "wind_speed": forecast["current_weather"]["windspeed"]
    }


def process_message(ch, method, properties, body):

    city = body.decode()

    print(f"Received request for: {city}")

    result = get_weather(city)

    response = json.dumps(result)

    print(f"Result: {response}")

    ch.basic_ack(
        delivery_tag=method.delivery_tag
    )


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


channel.basic_qos(
    prefetch_count=1
)


channel.basic_consume(
    queue="weather",
    on_message_callback=process_message
)


print("Worker started. Waiting for messages...")


channel.start_consuming()