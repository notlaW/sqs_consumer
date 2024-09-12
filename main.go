package main

import (
	"context"

	log "github.com/sirupsen/logrus"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

type Response struct {
	Message string `json:"message"`
}

func handler(ctx context.Context, sqsEvent events.SQSEvent) (Response, error) {
	for _, message := range sqsEvent.Records {
		log.WithFields(log.Fields{
			"messageId":   message.MessageId,
			"eventSource": message.EventSource,
		}).Info("SQS Message Received")
	}

	response := Response{
		Message: "Response from Lambda",
	}

	return response, nil // nil is important here, otherwise the lambda will be considered as failed
}

func main() {
	lambda.Start(handler)
}
