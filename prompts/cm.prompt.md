---
agent: 'agent'
description: 'Write a commit message based on code changes.'
---
Your goal is to write a commit message that accurately reflects changes made to a codebase.

If not already provided, ask where the code changes are located, e.g.:
- uncommitted - the uncommitted changes in git
- staged - the staged changes in git
- branch - the current branch compared to the default branch

Requirements:
* The first paragraph should provide a high level description of the changes
* The second paragraph should describe the approach and detailed breakdown of changes
