+++
title = "How to read large codebases"
date = "2022-03-19"
description = "When you start in a new project, sometimes is hard to start to contribute to it, check here some tips and tricks that can help you to read and understand large codebases."
tags = [
    "code",
    "reading"
]
draft = false
showtoc = true
share = true
+++

## Spend more time reading then writting

As developers, we should spend more time reading than writting code. Mostly because the majority of the time we will try to change code, and to change it we need to understand how our changes affect other parts of the systems. For that is common to read a lot.

## Understand the design intentions

Instead of trying to read line by line, understanding the behaviors, try to understand the intentions. Try to answer questions like "What was the author intention in this part of the code?", "Why is he doing this?", "How this connects with the rest of the system?". This way you can focus on what matters.

## Join the community

Go and join email lists, Slack channels or any other tools that the community uses to communicate. Is that community that can help you in cases where you are stuck.

## Use the software

The simplest way to understand the software is using it. Do experiments, try the relevant features and see the behavior of the system.

## Folow step-by-step executions

Another good way to understand a software is running it step-by-step to see what it is doing, what are the path and possible branches, what it checks, classes, methods and variables used in the execution, etc.

## Reading tests

Today any professional software has tests, reading them are a good way to see how the software is intended to be used. Specially unit tests, that can simulate scenarios of happy paths and exceptions.

## Refactoring

Last way to understand the code is to refactor it. Finding things to improve, improving the reading and consequently the writing of new code.
