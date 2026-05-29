resource "aws_iam_role" "agent_execution" {
  name = "${local.name_prefix}-agent-execution"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "bedrock.amazonaws.com"
      }
    }]
  })

  tags = var.tags
}

resource "aws_iam_role_policy" "agent_bedrock" {
  name = "bedrock-invoke"
  role = aws_iam_role.agent_execution.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "bedrock:InvokeModel",
        "bedrock:InvokeModelWithResponseStream",
      ]
      Resource = "arn:aws:bedrock:${var.region}::foundation-model/${var.bedrock_model_id}"
    }]
  })
}

resource "aws_iam_role_policy" "agent_s3" {
  name = "s3-knowledge-base"
  role = aws_iam_role.agent_execution.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "s3:GetObject",
        "s3:ListBucket",
      ]
      Resource = [
        aws_s3_bucket.knowledge_base.arn,
        "${aws_s3_bucket.knowledge_base.arn}/*",
      ]
    }]
  })
}

resource "aws_iam_role_policy" "agent_secrets" {
  name = "secrets-access"
  role = aws_iam_role.agent_execution.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["secretsmanager:GetSecretValue"]
      Resource = aws_secretsmanager_secret.agent_config.arn
    }]
  })
}
