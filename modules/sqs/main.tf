resource "aws_sqs_queue" "default" {
  count = length(var.queue_names)

  name = element(var.queue_names, count.index)
}