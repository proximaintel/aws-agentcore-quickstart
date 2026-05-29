output "vpc_id" {
  value = aws_vpc.agents.id
}

output "guardrail_id" {
  value = aws_bedrock_guardrail.agent.guardrail_id
}

output "knowledge_base_bucket" {
  value = aws_s3_bucket.knowledge_base.bucket
}

output "session_logs_bucket" {
  value = aws_s3_bucket.session_logs.bucket
}

output "agent_execution_role_arn" {
  value = aws_iam_role.agent_execution.arn
}
