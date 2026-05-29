variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "agentcore"
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the agents VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "bedrock_model_id" {
  description = "Bedrock model ID for agent inference"
  type        = string
  default     = "anthropic.claude-3-5-sonnet-20241022-v2:0"
}

variable "guardrail_content_filters" {
  description = "Enable content filtering guardrails"
  type        = bool
  default     = true
}

variable "guardrail_pii_detection" {
  description = "Enable PII detection and redaction"
  type        = bool
  default     = true
}

variable "session_log_retention_days" {
  description = "Days to retain agent session logs in S3"
  type        = number
  default     = 90
}

variable "max_tokens_per_session" {
  description = "Maximum tokens allowed per agent session"
  type        = number
  default     = 4096
}

variable "tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default = {
    managed_by  = "terraform"
    accelerator = "aws-agentcore-quickstart"
  }
}
