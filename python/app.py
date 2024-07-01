from fastapi import FastAPI
import boto3
import json

app = FastAPI()

# Configura el cliente de SQS
sqs_client = boto3.client('sqs', region_name='us-west-2')

# URLs de las colas SQS
NODEJS_TO_GO_QUEUE_URL = 'https://sqs.us-west-2.amazonaws.com/your-account-id/nodejs_to_go'
GO_TO_PYTHON_QUEUE_URL = 'https://sqs.us-west-2.amazonaws.com/your-account-id/go_to_python'

def get_message_from_sqs(queue_url):
    response = sqs_client.receive_message(
        QueueUrl=queue_url,
        MaxNumberOfMessages=1,
        WaitTimeSeconds=5
    )
    messages = response.get('Messages', [])
    if messages:
        message = messages[0]
        sqs_client.delete_message(
            QueueUrl=queue_url,
            ReceiptHandle=message['ReceiptHandle']
        )
        return message['Body']
    return None

@app.get("/")
async def read_root():
    ho = "Ho"
    la = get_message_from_sqs(NODEJS_TO_GO_QUEUE_URL)
    if la:
        la_mundo = get_message_from_sqs(GO_TO_PYTHON_QUEUE_URL)
        if la_mundo:
            return {"message": f"{ho}{la} {la_mundo}"}
    return {"message": "Ho Mundo"}