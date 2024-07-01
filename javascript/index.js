const express = require('express');
const AWS = require('aws-sdk');
const app = express();
const port = 3000;

AWS.config.update({region: 'us-west-2'});

const dynamodb = new AWS.DynamoDB.DocumentClient();
const sqs = new AWS.SQS();

const DYNAMODB_TABLE = 'syllables';
const GO_QUEUE_URL = 'https://sqs.us-west-2.amazonaws.com/your-account-id/go_to_python';

app.get('/getSyllable', (req, res) => {
    const params = {
        TableName: DYNAMODB_TABLE,
        Key: {
            'id': 'la'
        }
    };

    dynamodb.get(params, (err, data) => {
        if (err) {
            res.status(500).send(err);
        } else {
            const syllable = data.Item.syllable;
            const sqsParams = {
                MessageBody: syllable,
                QueueUrl: GO_QUEUE_URL
            };
            sqs.sendMessage(sqsParams, (err, data) => {
                if (err) {
                    res.status(500).send(err);
                } else {
                    res.send(syllable);
                }
            });
        }
    });
});

app.listen(port, () => {
    console.log(`Node.js server listening on port ${port}`);
});