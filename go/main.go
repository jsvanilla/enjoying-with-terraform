package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/sqs"
	_ "github.com/go-sql-driver/mysql"
)

const (
	region      = "us-west-2"
	sqsQueueURL = "https://sqs.us-west-2.amazonaws.com/your-account-id/nodejs_to_go"
	rdsUser     = "admin"
	rdsPassword = "password"
	rdsHost     = "your-rds-endpoint"
	rdsDatabase = "your-database-name"
)

func main() {
	http.HandleFunc("/getString", func(w http.ResponseWriter, r *http.Request) {
		// Conectar a la base de datos RDS
		dsn := fmt.Sprintf("%s:%s@tcp(%s)/%s", rdsUser, rdsPassword, rdsHost, rdsDatabase)
		db, err := sql.Open("mysql", dsn)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		defer db.Close()

		// Ejecutar la consulta
		var part string
		err = db.QueryRow("SELECT part FROM parts WHERE id = 'mundo'").Scan(&part)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		// Configurar SQS
		sess := session.Must(session.NewSession(&aws.Config{
			Region: aws.String(region),
		}))
		svc := sqs.New(sess)

		// Enviar el mensaje a la cola SQS
		result, err := svc.SendMessage(&sqs.SendMessageInput{
			MessageBody: aws.String(part),
			QueueUrl:    aws.String(sqsQueueURL),
		})
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		fmt.Fprintf(w, "Sent message to SQS: %s", *result.MessageId)
	})

	log.Fatal(http.ListenAndServe(":8080", nil))
}
