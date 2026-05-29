resource "aws_cloudwatch_log_group" "agent_sessions" {
  name              = "/aws/agentcore/${local.name_prefix}"
  retention_in_days = var.session_log_retention_days
  tags              = var.tags
}

resource "aws_s3_bucket" "session_logs" {
  bucket = "${local.name_prefix}-session-logs"
  tags   = var.tags
}

resource "aws_s3_bucket_lifecycle_configuration" "session_logs" {
  bucket = aws_s3_bucket.session_logs.id

  rule {
    id     = "expire-old-logs"
    status = "Enabled"

    expiration {
      days = var.session_log_retention_days
    }

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "session_logs" {
  bucket = aws_s3_bucket.session_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "session_logs" {
  bucket = aws_s3_bucket.session_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_cloudwatch_metric_alarm" "agent_errors" {
  alarm_name          = "${local.name_prefix}-agent-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "Errors"
  namespace           = "AWS/AgentCore"
  period              = 300
  statistic           = "Sum"
  threshold           = 5
  alarm_description   = "Agent error rate exceeded threshold"

  tags = var.tags
}
