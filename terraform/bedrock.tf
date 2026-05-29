resource "aws_s3_bucket" "knowledge_base" {
  bucket = "${local.name_prefix}-knowledge-base"
  tags   = var.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "knowledge_base" {
  bucket = aws_s3_bucket.knowledge_base.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "knowledge_base" {
  bucket = aws_s3_bucket.knowledge_base.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_secretsmanager_secret" "agent_config" {
  name        = "${local.name_prefix}-agent-config"
  description = "Agent configuration and API keys"
  tags        = var.tags
}
