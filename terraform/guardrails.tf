resource "aws_bedrock_guardrail" "agent" {
  name        = "${local.name_prefix}-guardrail"
  description = "Content safety guardrails for production AI agents"

  blocked_input_messaging  = "I'm unable to process this request due to content policy restrictions."
  blocked_outputs_messaging = "The response was blocked due to content policy restrictions."

  dynamic "content_policy_config" {
    for_each = var.guardrail_content_filters ? [1] : []
    content {
      filters_config {
        type            = "HATE"
        input_strength  = "HIGH"
        output_strength = "HIGH"
      }
      filters_config {
        type            = "VIOLENCE"
        input_strength  = "HIGH"
        output_strength = "HIGH"
      }
      filters_config {
        type            = "SEXUAL"
        input_strength  = "HIGH"
        output_strength = "HIGH"
      }
      filters_config {
        type            = "MISCONDUCT"
        input_strength  = "HIGH"
        output_strength = "HIGH"
      }
    }
  }

  dynamic "sensitive_information_policy_config" {
    for_each = var.guardrail_pii_detection ? [1] : []
    content {
      pii_entities_config {
        type   = "EMAIL"
        action = "ANONYMIZE"
      }
      pii_entities_config {
        type   = "PHONE"
        action = "ANONYMIZE"
      }
      pii_entities_config {
        type   = "US_SOCIAL_SECURITY_NUMBER"
        action = "BLOCK"
      }
      pii_entities_config {
        type   = "CREDIT_DEBIT_CARD_NUMBER"
        action = "BLOCK"
      }
    }
  }

  tags = var.tags
}
