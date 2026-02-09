---
agent: 'agent'
description: 'Write a commit message based on code changes'
---
Your goal is to write a commit message that accurately reflects changes made to a codebase.

The location of the code changes may be specified by the user. If not provided, default to 'uncommitted'.
- uncommitted - the uncommitted changes in git
- staged - the staged changes in git
- branch - the current branch compared to the default branch

Requirements:
* The top line commit message should be within 72 characters
* The first paragraph of the description should provide a high level overview of the changes
* The second paragraph of the description should provide a detailed breakdown of the changes and the approach taken. Tend towards using bullet points for readability.
* Output as plain text, wrapped in triple backticks
* Only use conventional commit style if it is used in the repository already
* After the commit description, add a blank line and then add `[ci-full]`
