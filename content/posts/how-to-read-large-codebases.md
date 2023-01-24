+++
title = "How to read large codebases"
date = "2022-03-19"
description = "When you start in a new project, sometimes is hard to start to contribute to it, check here some tips and tricks that can help you to read and understand large codebases."
tags = [
    "Code",
    "Reading"
]
draft = false
showtoc = true
share = true
+++

{{<audio src="https://s3.eu-west-1.amazonaws.com/jaswdr.dev-tts/posts/how-to-read-large-codebases.31f8850a-64de-49b3-8518-dbee5116927f.mp3">}}

## Waste more time reading than writing

As developers, we should spend more time reading than writing code. Mostly because we will try to change code, and to change it, we need to understand how our changes affect other parts of the system.

## Understand the design intentions

Instead of trying to read line by line, understanding the behaviors, try to understand the intentions. Think of some questions to drive your thoughts:

- “What was the author's intention?”

- “Why is it done this way?”

- “How does it connect with the rest of the system?”

## Join the community

Join email lists, Slack channels or any other tools that the community uses to communicate. Is that community that can help you in situations where you are stuck.


## Use the software

The simplest way to understand the software is by using it. Do experiments, try the relevant features and understand the behavior of the system.


## Follow step-by-step executions

Another good way to understand a software is running it step-by-step to watch the execution flow, what are the path and branches, functions, classes, methods and variables used, etc.

## Read tests

Today, any relevant software has tests. Reading them is a good way to study how the software works. Especially unit tests, who can simulate happy path scenarios and exceptions.

## Refactor

Last way to understand the code is to refactor it. Identifying things to improve, improving the reading and the writing of the new code.

## Conclusion

I hope these tips help you read large codebases and make easier to contribute to your work, study or open source project.
