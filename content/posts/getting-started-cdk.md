+++
title = "Getting started with CDK"
date = "2021-04-06"
description = ""
tags = [
    "AWS",
    "CDK",
    "Infrastructure as Code"
]
draft = false
showtoc = true
share = true
+++


Installing the **cdk** CLI tool with **npm**

```bash
$ npm install -g aws-cdk
```

Checking if you have installed it correctly:

```bash
$ cdk --version
1.94.0 (build 2c1c0eb)
```

> Remember that the version number could be different.

## Setup project

In any folder execute the command below:

```bash
$ cdk init app --language=python
...
✅ All done!
```

This command creates the initial structure of our CDK project, it also outputs others commands, including the one to synthesize our application. The synthesis process is like a "compilation" of our code, but instead of the output been a binary it will generate a CloudFormation definition file. The synthesis also will do some checks to validate if our code is correct, but keep in mind that it won't get everything, sometimes you will see the errors just when creating or updating your stack.

After we do the synthesis we will be able to deploy our application, we can't do it right now because first we need to install the dependencies. Let's do it inside a Python virtual environment.

```bash
$ python3 -m venv .venv
$ source .venv/bin/activate
(.venv) $ pip install -r requirements.txt
...
Successfully installed app attrs-20.3.0 aws-cdk.cloud-assembly-schema-1.94.0 aws-cdk.core-1.94.0 aws-cdk.cx-api-1.94.0 aws-cdk.region-info-1.94.0 cattrs-1.3.0 constructs-3.3.65 jsii-1.25.0 publication-0.0.3 python-dateutil-2.8.1 six-1.15.0 typing-extensions-3.7.4.3
```

Now that we have a virtual environment with all required dependencies we can do the synthesis.

```bash
$ cdk synth
Resources:
  CDKMetadata:
    Type: AWS::CDK::Metadata
    Properties:
      Analytics: v2:deflate64:H4sIAAAAAAAAAzPUszTRM1B...Z+Xn6xnoWeqaKWcWZmbpFpXklmbmpekEQGgDnOi9bYQAAAA==
    Metadata:
      aws:cdk:path: AppStack/CDKMetadata/Default
    Condition: CDKMetadataAvailable
Conditions:
  CDKMetadataAvailable:
    Fn::Or:
      - Fn::Or:
          - Fn::Equals:
              - Ref: AWS::Region
              - af-south-1
...
```

In this initial version we have not defined anything yet, but the output shows us that there is some metadata that is generated, you don't need to be worry about this metadata now, but let's deploy this version to our AWS account.

```bash
$ cdk deploy
AppStack: deploying...
AppStack: creating CloudFormation changeset...
[██████████████████████████████████████████████████████████] (2/2)



 ✅  AppStack
```

> If you haven't configured the access to your AWS account yet, please check my [tutorial]({{< ref "/building-aws-cli-from-source" >}}) showing how to do it and how to install the **aws** CLI tool.


After finished, you can access your AWS account and check your stacks in the **CloudFormation** console page, there you will see a new **AppStack** By opening the stack page and looking at the resources you will see that the only resource that this stack is managing right now is the metadata from our previous synthesis.

Now that we are able to synthesize our application and deploy it to our account, we can add our resources.

## First synthesize

If you have followed the previous section you probably have a directory like this:

```bash
.
|-- README.md
|-- app
|   |-- __init__.py
|   |-- __pycache__
|   |   |-- __init__.cpython-38.pyc
|   |   `-- app_stack.cpython-38.pyc
|   |-- app.egg-info
|   |   |-- PKG-INFO
|   |   |-- SOURCES.txt
|   |   |-- dependency_links.txt
|   |   |-- requires.txt
|   |   `-- top_level.txt
|   `-- app_stack.py
|-- app.py
|-- cdk.json
|-- cdk.out
|   |-- AppStack.template.json
|   |-- cdk.out
|   |-- manifest.json
|   `-- tree.json
|-- output
|-- requirements.txt
|-- setup.py
`-- source.bat
```

The **cdk** CLI will generate a bunch of files for us, one of the most important is the **cdk.json** who will be read by cdk to know where is our main file where we define our stacks, in this default structure it is **app.py** if we check the content of that file we see something like this:

```python
#!/usr/bin/env python3

from aws_cdk import core as cdk

# For consistency with TypeScript code, `cdk` is the preferred import name for
# the CDK's core module.  The following line also imports it as `core` for use
# with examples from the CDK Developer's Guide, which are in the process of
# being updated to use `cdk`.  You may delete this import if you don't need it.
from aws_cdk import core

from app.app_stack import AppStack


app = core.App()
AppStack(app, "AppStack")

app.synth()
```

> As you can see, there is not much here yet, but we can see the name of our stack in this file.

Here we are creating a new instance from the AppStack class, and this class is imported from the **app.app_stack** module, lets check this module and file to see what we can find:

```python
from aws_cdk import core as cdk

# For consistency with other languages, `cdk` is the preferred import name for
# the CDK's core module.  The following line also imports it as `core` for use
# with examples from the CDK Developer's Guide, which are in the process of
# being updated to use `cdk`.  You may delete this import if you don't need it.
from aws_cdk import core


class AppStack(cdk.Stack):

    def __init__(self, scope: cdk.Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        # The code that defines your stack goes here
```

This file, as the name suggest, is our application stack, here is where we defined our resources, like S3 buckets, EC2 instances, DynamoDB tables, etc.

## Adding a S3 bucket

As an example, we can add a S3 bucket to the CDK stack.

```python
from aws_cdk import core as cdk
from aws_cdk.aws_s3 import Bucket

# For consistency with other languages, `cdk` is the preferred import name for
# the CDK's core module.  The following line also imports it as `core` for use
# with examples from the CDK Developer's Guide, which are in the process of
# being updated to use `cdk`.  You may delete this import if you don't need it.
from aws_cdk import core


class AppStack(cdk.Stack):

    def __init__(self, scope: cdk.Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        static_data_bucket = Bucket(self, "static_data_bucket")
```

By doing the synthesis and deploying it you will see a new S3 bucket with the name you defined plus some random string, this happens by default with most of the resources that we don't explicitly define a name. In this example, we can change the bucket name by passing the **bucket_name** attribute to the constructor.

```python
from aws_cdk import core as cdk
from aws_cdk.aws_s3 import Bucket

# For consistency with other languages, `cdk` is the preferred import name for
# the CDK's core module.  The following line also imports it as `core` for use
# with examples from the CDK Developer's Guide, which are in the process of
# being updated to use `cdk`.  You may delete this import if you don't need it.
from aws_cdk import core


class AppStack(cdk.Stack):

    def __init__(self, scope: cdk.Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        static_data_bucket = Bucket(self, "static_data_bucket",
                                    bucket_name="jaswdr-webcrawler-static-data")
```

To check which changes we made, or that will be deployed, we can use the **diff** command, the same way we do in **git**

```bash
$ cdk diff
Stack AppStack
Resources
[~] AWS::S3::Bucket static_data_bucket staticdatabucketC0B68EAE replace
 └─ [+] BucketName (requires replacement)
     └─ jaswdr-webcrawler-static-data
```

The diff confirms our intention of replacing the bucket name that we have now specified.

> Check all the available attributes at the official [reference manual](https://docs.aws.amazon.com/cdk/api/latest/).

## Conclusion

As you can see is not so hard to start to use **cdk** it is probably the best tool to keep track of your infrastructure in the AWS cloud, check more about it in the official [website](https://aws.amazon.com/cdk/).
