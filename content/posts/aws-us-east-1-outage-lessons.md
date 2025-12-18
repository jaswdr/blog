---
title: "What Can We Learn from the October 20, 2025 AWS us-east-1 Outage?"
subtitle: "Lessons in building resilient cloud infrastructure"
date: 2025-10-22T09:00:00-08:00
lastmod: 2025-10-22T09:00:00-08:00
draft: false
author: "Jonathan Schweder"
description: "Analyzing the AWS us-east-1 outage and lessons learned about cloud resilience, multi-region architecture, and chaos engineering practices."

tags:
  [
    "AWS",
    "Cloud",
    "DevOps",
    "Resilience",
    "Chaos Engineering",
    "Infrastructure",
  ]
categories: ["Cloud", "DevOps"]
series: []

hiddenFromHomePage: false
hiddenFromSearch: false

featuredImage: "/posts/aws-us-east-1-outage/featured.jpg"
featuredImagePreview: "/posts/aws-us-east-1-outage/preview.jpg"

toc:
  enable: true
math:
  enable: false
lightgallery: false
license: ""
---

On October 20, an outage in the US East (us-east-1) AWS region disrupted operations for numerous companies, including Apple, Epic Games, Netflix, and Canva. Having worked as a software engineer on projects with diverse requirements, capacities, budgets, and scopes, I'd like to offer my perspective on the event and its implications.

<!--more-->

## Understanding AWS Regions

To understand the outage, it's helpful to first understand how AWS organizes its cloud infrastructure.

### The AWS Hierarchy

When people say "AWS," they're usually referring to the **partition**—the highest level of abstraction in the AWS network. A partition contains multiple regions that can communicate with each other. The most commonly used partition is (surprise, surprise) the "aws" partition.

Ever noticed that every ARN starts with `arn:aws`? That "aws" refers to this partition, which serves all AWS customers globally. Other partitions exist too, like "aws-us-gov," used exclusively by the U.S. government for storing and processing U.S. citizen data, accessible only by authorized U.S. entities.

### Regions and Availability Zones

Inside each partition are **regions**—collections of Availability Zones (AZs) distributed geographically around the world. Regions are typically located near densely populated areas or high-traffic network hubs. When designing your application, selecting regions geographically close to your users is crucial for reducing both latency and costs.

**Availability Zones** contain multiple data centers distributed geographically to minimize the risk of climate-related disasters affecting multiple zones simultaneously—floods, tornadoes, earthquakes, and similar events. Each data center has redundant:

- Electricity supply
- Water supply
- Network connectivity to AWS's global backbone

### Inside a Data Center

AWS data centers are heavily fortified, both digitally and physically. Teams work on-site 24/7 ensuring everything runs smoothly—network engineers keeping systems operational so you can launch your Minecraft server on EC2 or store your (totally legal) Star Trek collection in S3.

I once visited a data center in Dublin, Ireland (eu-west-1) as an AWS employee, and the security measures were genuinely impressive.

## Why us-east-1 Dominates

Here’s why us-east-1 remains so popular, despite the risks:

### 1. Location, Location, Location

The us-east-1 region sits near major metropolitan areas: New York, Boston, and Washington D.C. These densely populated cities represent enormous customer bases with significant network traffic.

### 2. Hardware and Software Availability

Us-east-1 often receives:

- **Newest EC2 instance types** with better cost-to-performance ratios
- **GPU instances** (increasingly critical for AI workloads)
- **Earliest access to new AWS services** (like Amazon Bedrock, initially us-east-1 only)

### 3. Legacy Infrastructure

As AWS's first region, us-east-1 hosts many early adopters who:

- Had no alternative options initially
- Haven't found migration worthwhile
- Face competing business priorities

### 4. Default Selection

Us-east-1 is the default region when creating an AWS account. Many users never bother changing it. Additionally, AWS documentation examples predominantly use us-east-1, reinforcing this default behavior.

## Key Lessons from the Outage

While the concentration in us-east-1 is understandable, the outage drew some oversimplified criticisms like, "AWS customers are lazy" or "they should have planned for a region outage." The reality is more complex.

### The Business Reality

While revenue-critical systems should ideally have multi-region or even multi-cloud redundancy, building such architectures isn't trivial:

- Many applications weren't designed for distributed deployment
- Migration requires substantial time and effort
- These projects compete with other business priorities

> **It's hard to convince people to prioritize resilience over features and bug fixes**

Companies naturally prioritize:

1. **New features** that drive revenue growth
2. **Bug fixes** that reduce customer churn
3. **Cost management** over speculative disaster preparation

### AWS's Internal Structure

If you're unfamiliar, AWS operates internally like a collection of mini-startups. Each team is independent with its own standards and working methods.

**The Advantages:**

- **Velocity**: Despite 143,000+ employees, AWS moves fast with strong time-to-market
- **Freedom**: Employees can experiment and try new approaches easily
- **Reusability**: Teams leverage each other's work when valuable solutions exist

**The Drawbacks:**

- **Duplication**: Multiple internal services often solve the same problem differently
- **Inconsistent standards**: Systems vary in operational excellence (code and architecture)
- **Risk accumulation**: Teams may unknowingly depend on poorly-built systems

> **Resilience can only happen with end-to-end visibility**

### The Visibility Problem

In a company as large as AWS, teams lack complete visibility into their dependency chains. They know their direct dependencies and dependents, but not the full upstream and downstream picture. This creates risks—teams may unknowingly depend on single points of failure.

The challenge intensifies because AWS services are "live entities" that constantly evolve. New dependencies appear regularly, and services get created without years of battle-testing. This is natural as the company grows.

> **Your system is as resilient as its weakest component**

## What AWS Customers Can Do

Region-wide outages are unavoidable. It’s critical to remember that **anything can break at any time**. No software is perfect. The question isn't _if_ something will break, but _when_—and you need to be prepared.

### Embrace Chaos Engineering

The best disaster preparation? **Test it.**

Netflix popularized Chaos Engineering: treat your system as a box and dependencies as switches, then toggle those switches to observe reactions. For example:

- What happens if you shut down an entire Availability Zone?
- What about an entire region?
- Does your system survive?

If not, document failures, logs, metrics, and traces. Apply fixes. Test again.

**Important principles:**

- **Don't fix everything at once**: Address problems iteratively
- **Why?** Complete overhauls take too long while your system continues evolving
- **Regular cadence**: Run tests quarterly to weekly, depending on your system's scale and change velocity
- **AWS-specific tool**: Use AWS Fault Injection Service to simulate these scenarios without code changes

### Replication Strategies

Use replication wherever feasible, combining data and compute replication across multiple regions and clouds. There's no other way to fully mitigate these risks.

**Think of cloud deployment like stock investing: never put all your money in one company.**

Balance risk against cost intelligently:

- **Low-stakes systems**: A $5/month DigitalOcean VPS might suffice for non-critical applications
- **Revenue-critical systems**: Multi-region/multi-cloud setups are essential if downtime halts your business

### Practical Implementation

**Terraform** is an excellent tool for managing multi-cloud environments, with a large ecosystem of providers:

- Cloud platforms: AWS, GCP, Azure
- Infrastructure services: Cloudflare, Hetzner, DigitalOcean
- DevOps tools: GitHub, GitLab

I use Terraform extensively (personally and professionally) for managing infrastructure at any scale. AI agents are now making the HCL learning curve even smoother.

## Conclusion

The us-east-1 outage is a reminder that resilience requires intentional design, ongoing testing, and a clear understanding of the trade-offs between cost and redundancy. We can't prevent all failures, but we can prepare for them.

Build systems expecting failure. Test regularly. Replicate strategically.

Thank you for reading.
