# AWS AgentCore Quickstart

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)
[![Terraform](https://img.shields.io/badge/Terraform-%3E%3D1.5-purple.svg)](https://www.terraform.io/)

**Production-ready Terraform for deploying AWS AgentCore infrastructure — managed AI agent runtime, guardrails, observability, and deployment pipelines for regulated enterprises.**

Built by [Proxima Intelligence](https://proximaintel.com) — Enterprise Cloud & AI Consulting.

---

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    AWS Account (AI Agents)                    │
│                                                             │
│  ┌──────────────┐   ┌──────────────┐   ┌──────────────┐   │
│  │ AgentCore    │   │ Amazon       │   │ Guardrails   │   │
│  │ Runtime      │   │ Bedrock      │   │ (Content     │   │
│  │ (Managed)    │   │ (Models)     │   │  Filtering)  │   │
│  └──────┬───────┘   └──────┬───────┘   └──────────────┘   │
│         │                  │                                │
│  ┌──────┴──────────────────┴───────┐                       │
│  │      VPC Endpoints              │                       │
│  │  (bedrock, s3, secretsmanager,  │                       │
│  │   logs, xray)                   │                       │
│  └──────────────┬──────────────────┘                       │
│                 │                                           │
│  ┌──────────────┴──────────────────┐                       │
│  │   Observability                 │                       │
│  │   (CloudWatch, X-Ray,           │                       │
│  │    Session Logs → S3)           │                       │
│  └─────────────────────────────────┘                       │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## Modules

| Directory | Description |
|-----------|-------------|
| [terraform/](terraform/) | Infrastructure — AgentCore, IAM, VPC, Bedrock, guardrails, observability |
| [agents/](agents/) | Example agent configurations (document Q&A, data analyst) |
| [pipelines/](pipelines/) | CI/CD for agent deployment (GitHub Actions + CodePipeline) |
| [docs/](docs/) | Architecture, deployment guide, guardrails reference, compliance |

## Quick Start

```bash
git clone https://github.com/proximaintel/aws-agentcore-quickstart.git
cd aws-agentcore-quickstart/terraform

cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values

terraform init
terraform plan
terraform apply
```

## Prerequisites

- Terraform >= 1.5
- AWS CLI authenticated with appropriate permissions
- Amazon Bedrock model access approved (Claude, Titan, or Llama)
- AWS AgentCore access enabled for your account

## Agent Examples

| Agent | Description | Model |
|-------|-------------|-------|
| [document-qa](agents/document-qa/) | RAG-based document Q&A with knowledge base | Claude 3.5 Sonnet |
| [data-analyst](agents/data-analyst/) | SQL-generating agent with Redshift/Athena access | Claude 3.5 Sonnet |

## Guardrails

Built-in safety controls for regulated environments:

- Content filtering (hate, violence, sexual, misconduct)
- PII detection and redaction
- Token budget limits per session
- Custom word filters (industry-specific)
- Human-in-the-loop escalation gates

## Documentation

- [Architecture](docs/architecture.md) — design decisions and data flow
- [Deployment Guide](docs/deployment-guide.md) — step-by-step instructions
- [Guardrails Reference](docs/guardrails-reference.md) — all safety controls explained
- [Observability](docs/observability.md) — monitoring, tracing, alerting
- [Compliance](docs/compliance.md) — data residency, encryption, audit

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## About Proxima Intelligence

[Proxima Intelligence](https://proximaintel.com) delivers the AWS AgentCore Quickstart as a [fixed-scope accelerator](https://proximaintel.com/accelerators/aws-agentcore) — deployed in 3 weeks for regulated enterprises.

Senior architects on every engagement. No bait-and-switch.

---

*© Proxima Intelligence LLC. Licensed under Apache 2.0.*
