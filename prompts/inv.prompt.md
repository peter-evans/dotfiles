---
agent: 'agent'
description: 'Start or continue an existing investigation, documented in markdown.'
---
Your goal is to start or continue an existing investigation, and document findings in markdown format.

If not clear from context, ask where the document should be created or continued from.

Whenever performing an investigation, ensure to follow these guidelines:
* Never guess or assume, always document aspects of the investigation as unknowns in need of further investigation
* Use GitHub MCP to search for relevant code, issues, PRs, and documentation
* Use DataDog MCP to fetch telemetry in order to understand access patterns, latency, query performance, etc.

Whenever modifying the investigation document, ensure to follow these guidelines:
* Always maintain an up-to-date table of contents at the top of the document
* Always maintain a list of questions for stakeholders that would clarify direction
* Always maintain a list of technical aspects that require further investigation in order to make progress
* Always maintain a list of references at the bottom of the document
