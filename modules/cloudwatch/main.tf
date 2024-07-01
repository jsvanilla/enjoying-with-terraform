resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/eks/cluster"
  retention_in_days = 30
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "HighCPUUsage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EKS"
  period              = "300"
  statistic           = "Average"
  threshold           = "70"

  dimensions = {
    ClusterName = var.cluster_name
  }

  alarm_actions = [var.alarm_action]
}