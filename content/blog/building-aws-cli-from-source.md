+++
title = "Building AWS CLI from Source"
date = "2021-02-28"
description = "AWS CLI is the terminal tool used to interact with AWS services, if you want the latest available version the best option is built from source."
tags = [
    "aws",
    "cli"
]
draft = false
toc = false
share = true
+++

Installing `aws` CLI tool from source:

```bash
git clone --depth=1 https://github.com/aws/aws-cli.git
cd ./aws-cli
pip install .
```

Configuring access keys:

```bash
$ aws configure
AWS Access Key ID: your-access-key-id
AWS Secret Access Key: your-secret-access-key
Default region name: eu-west-1
Default output format: json
```
