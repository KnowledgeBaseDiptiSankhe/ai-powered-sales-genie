# NOTICE

This file lists third-party products, services, and data referenced by this
repository. It is provided for transparency and attribution; it does not
grant any rights beyond what this repository's `LICENSE` file states, and it
does not modify the license terms of the third-party items listed below \u2014
each remains governed by its own owner's license or terms of service.

## Third-Party Products & Services Referenced

| Component | Owner | Notes |
|---|---|---|
| Claude / Anthropic API | Anthropic, PBC | Used as the LLM reasoning engine for the Router, Ingestion, Qualifier, Recommender, Response Drafter, FAQ, and Weekly Aggregator agents. Subject to OpenAI / Anthropic's API Terms of Service. No API keys, credentials, or OpenAI /Anthropic proprietary material are included in this repository. |
| n8n | n8n GmbH | Workflow/orchestration platform used to run the SalesGenie agent pipelines. The `.json` files in this repo are workflow *definitions* authored by the project creator for use within n8n; they do not include or redistribute n8n's own source code. |
| Google Sheets / Gmail APIs | Google LLC | Used for the lead store (CRM), HITL review queue, and weekly report delivery. Subject to Google's API Terms of Service. No Google credentials are included in this repository. |
| Langfuse | Langfuse GmbH | Used as the observability/tracing tool for logging agent inputs, outputs, and evaluation data. Subject to Langfuse's terms. No Langfuse credentials are included in this repository. |

All trademarks, product names, and company names mentioned above are the
property of their respective owners. Their inclusion here is for descriptive
and interoperability purposes only and does not imply any endorsement,
sponsorship, or affiliation with this project.

## Fictional Company & Data Disclaimer

"Oak & Ember Interiors," its product catalog, sample inquiry emails, and
sample CRM export data referenced throughout this repository (PRD, Technical
Design Document, workflow files) are **fictional**, created solely for the
purposes of this academic capstone project. Any resemblance to a real
company, product, or individual is coincidental. No real customer data is
used or stored anywhere in this repository.

## No Credentials Included

This repository intentionally contains no API keys, OAuth tokens, or other
secrets. All workflow files reference credentials via environment variables
or placeholder credential names (see `README.md` for the list of required
environment variables) that must be configured by whoever runs the
workflows.
