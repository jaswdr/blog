+++
title = "Infra as Code using AWS CDK"
date = "2021-04-06"
description = ""
tags = [
    "aws",
    "cdk",
    "infrastructure"
]
draft = false
toc = true
share = true
+++

When working at any software, as a developer, you need to know what is going to be delivered to production, for our source code base we use things like `git` to track changes, keep a history, review and revert when needed. But when we talk about resources in our cloud provider, this task is not easy, sometimes because we are lazy and don't want to use tool X or Y, because it is to much complicated and we are trying to solve something simple as quickly as possible, so we do it manually, and when we take notice our account is a mess, with a lot of resources that we don't use anymore and the only time that we notice that they exist is when your boss complains about the cost.

For problems like that that the AWS Cloudformation was created, a single interface that can be used for any developer to describe the desired state of your resources. But even that sometimes is too complicate, to much verbose, or even limited by been static, making us copy and pasting a lot of sections of the bigger definition file.

Now thats why **CDK** was created, a collection of libraries in different languages that can been used to define your infrastructure as code, taking all the advantages of imperative programming languages, with the existing workflows that were already defined for applications softwares. Let see in this tutorial how you can use the **CDK** to create a Webcrawler Python application.

## TL;DR

See the final result at https://github.com/jaswdr/aws-cdk-crawler-backend-example

## Architecture

What we will built in this tutorial is a webcrawler application for apartment rent prices in Dublin city, using different services from the AWS cloud provider, see the full picture of the architecture below:

![Rent Price Webcrawler](https://raw.githubusercontent.com/jaswdr/diagrams/master/rent-price-webcrawler.jpg)

In the example above I'm using a bunch of different AWS services, everything starts with the `Cron`, who is a Eventbridge cron event that will determine the frequency which we collect the page. This item will trigger the `Crawler` lambda function, who will collect the page, extract the data and save it to `DynamoDB`, then send it to a SQS queue. The SQS queue will have at this point one listener, our `Enrichment` lambda, this lambda is responsabile to add more specialized data, like distance to know points in the map.

Now considering that someone will use this solution, the user will access a webpage that in this case will be hosted by our `Frontend` in Amplify, it will be a simple page that will list all the offers and have some filters, like number of bedrooms and number of bathrooms. This frontend application will make requests to our backend, that in this case has it entrypoint mapped in APIGateway to send the request to our `Search` lambda function, this function will then have the logic to get the data from our DynamoDB table.

## Installing dependencies

The `cdk` CLI tool is required in all subsequent steps below, you can install it using `npm`:

```bash
$ npm install -g aws-cdk
```

Check if the version you have installed:

```bash
$ cdk --version
1.94.0 (build 2c1c0eb)
```

## Setup the project

In any folder execute the command below:

```bash
$ cdk init app --language=python
...
✅ All done!
```

The output of this command also give us the commands available to synthesize our application, the synthesis process is similar to a compilation, by doing it we are generating a file that describes our CloudFormation stack, the synthesis also will check if the related code is correct. Finally, after the synthesis we will be able to deploy our application, we can do it right now but first we need to install our Python dependencies, lets do it inside a Python virtual environment.

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

After finished, you can access your AWS account and go to stacks `CloudFormation` page, there you will see a new `AppStack`, opening this stack page and looking at the resources you will see that the only resource that this stack is managing is the metadata from our previous synthesis.

Now that we are able to synthesize our application and deploy it to our account lets see how we can add some AWS services.

## Adding our first item to our stack

If you have followed the previous section you probably have a directory like this:

```
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

The `cdk` CLI will generate a bunch of files for us, the most important ones are the `./cdk.json` who will be read by cdk to configure some aspects of our application, like telling cdk what is the file that he needs to load to synthesis everything, by default this file is `./app.py`, if we check the content of that file we see:

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

There is not much here yet, but we can see the name of our stack `AppStack` in this file, it is creating a new instance from the AppStack class, and this class is imported from the `app.app_stack` module, lets check this module and file to see what we can find:

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

This file, as the name suggest, is our application stack, here is where we defined our resources, like S3 buckets, EC2 instances, DynamoDB tables, etc. Lets add our statis data bucket.

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

By doing the synthesis and deploying it again you will see a new S3 bucket with the name you defined plus some random string, this is something that is default, if you don't explicitly define a name you will see this random generated string everywhere. To fix it you just need to pass the `bucket_name` to the constructor.

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

Once we change the file we can check a `diff`, the same way we do in `git`:

```bash
$ cdk diff
Stack AppStack
Resources
[~] AWS::S3::Bucket static_data_bucket staticdatabucketC0B68EAE replace
 └─ [+] BucketName (requires replacement)
     └─ jaswdr-webcrawler-static-data
```

As we can see we are replacing the bucket with another bucket with the name that we have now specified, check all the attributes that are available at the [reference manual](https://docs.aws.amazon.com/cdk/api/latest/).

> Notice that in this example the previous bucket was not deleted, this is done by default for most resources, it you want you can manually delete it or run `cdk destroy` to delete all resources.

## Adding example resources

Going back to our architecture, to add all the resources the process is basicaly the same, the final `app_stack.py` would be something like:

```python
import os
from pathlib import Path

from aws_cdk import core as cdk
import aws_cdk.aws_amplify as amplify
import aws_cdk.aws_apigatewayv2 as gateway
import aws_cdk.aws_apigatewayv2_integrations as gateway_integrations
import aws_cdk.aws_codecommit as code
import aws_cdk.aws_ecr as ecr
import aws_cdk.aws_ecr_assets as ecr_assets
import aws_cdk.aws_events as events
import aws_cdk.aws_events_targets as targets
import aws_cdk.aws_lambda as _lambda
import aws_cdk.aws_lambda_event_sources as lambda_event_sources
import aws_cdk.aws_sqs as sqs
import aws_cdk.aws_logs as logs
import aws_cdk.aws_dynamodb as ddb

from database_stack import DatabaseStack


class AppStack(cdk.Stack):
    def _lambda_function_from_asset(self,
            lambda_asset, function_name, function_cmd, environment,
            *,
            reserved_concurrent_executions=2,
            timeout_minutes=15,
            memory_size=128,
            max_event_age_minutes=60
            ):
        return _lambda.DockerImageFunction(self,
            function_name,
            function_name=function_name,
            environment=environment,
            log_retention=logs.RetentionDays.ONE_WEEK,
            memory_size=memory_size,
            reserved_concurrent_executions=reserved_concurrent_executions,
            timeout=cdk.Duration.minutes(timeout_minutes),
            tracing=_lambda.Tracing.ACTIVE,
            max_event_age=cdk.Duration.minutes(max_event_age_minutes),
            code=_lambda.DockerImageCode.from_ecr(
                lambda_asset.repository,
                cmd=[function_cmd],
                tag=lambda_asset.image_uri.split(':')[1]))

    def __init__(self, scope: cdk.Construct, construct_id: str, db_stack: DatabaseStack, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)
        # Enrichment Queue
        enrichment_queue = sqs.Queue(self,
                "CrawlerEnrichmentQueue",
                queue_name='CrawlerEnrichmentQueue',
                retention_period=cdk.Duration.days(1),
                visibility_timeout=cdk.Duration.minutes(15))

        # Environment
        env_default = {'APP_LOGGING_LEVEL': 'ERROR'}
        env_table = {'APP_OFFERS_TABLE': db_stack.offers_table.table_name}
        env_queue_url = {'APP_OFFERS_QUEUE_URL': enrichment_queue.queue_url}


        # Base Lambda ECR image asset
        lambda_asset = ecr_assets.DockerImageAsset(self,
                'CrawlerLambdaImage',
                directory=os.path.join(os.getcwd(), 'src', 'crawler'),
                repository_name='crawler')

        # Crawler Lambda
        lambda_crawler = self._lambda_function_from_asset(
                lambda_asset,
                'LambdaCrawler',
                'lambda_handler.crawler',
                {**env_default, **env_table, **env_queue_url})
        rule = events.Rule(self,
                'CrawlerCallingRule',
                rule_name='CrawlerCallingRule',
                schedule=events.Schedule.rate(cdk.Duration.hours(1)))
        rule.add_target(targets.LambdaFunction(lambda_crawler))
        db_stack.offers_table.grant_write_data(lambda_crawler)
        enrichment_queue.grant_send_messages(lambda_crawler)

        # Enrichment Lambda
        lambda_enrichment    = self._lambda_function_from_asset(
                lambda_asset,
                'LambdaEnrichment',
                'lambda_handler.enrichment',
                {**env_default, **env_table})
        lambda_enrichment.add_event_source(
            lambda_event_sources.SqsEventSource(enrichment_queue))
        db_stack.offers_table.grant_write_data(lambda_enrichment)

        lambda_search   = self._lambda_function_from_asset(
                lambda_asset,
                'LambdaSearch',
                'lambda_handler.search',
                {**env_default, **env_table},
                reserved_concurrent_executions=10,
                timeout_minutes=1,
                memory_size=128,
                max_event_age_minutes=1)
        db_stack.offers_table.grant_read_data(lambda_search)

        personal_token = open(os.path.join(str(Path.home()), '.github/personal_token.txt'), 'r').read()

        # Frontend entrypoin
        amplify_app =  amplify.App(self,
                'CrawlerFrontend',
                app_name='CrawlerFrontend',
                auto_branch_creation=amplify.AutoBranchCreation(
                    auto_build=True),
                source_code_provider=amplify.GitHubSourceCodeProvider(
                    owner='jaswdr',
                    repository='aws-cdk-crawler-frontend-example',
                    oauth_token=cdk.SecretValue(personal_token)))

        # Backend entrypoint
        search_entrypoint = gateway.HttpApi(self,
                'CrawlerSearchApiEntrypoint',
                api_name='CrawlerSearchApiEntrypoint',
                cors_preflight=gateway.CorsPreflightOptions(
                    allow_headers=['*'],
                    allow_methods=[gateway.HttpMethod.GET],
                    allow_origins=['*'],
                    max_age=cdk.Duration.hours(2)),
                description='Crawler Search API Entrypoint')
        search_entrypoint.add_routes(
                path='/search',
                methods=[gateway.HttpMethod.GET],
                integration=gateway_integrations.LambdaProxyIntegration(
                        handler=lambda_search,
                        payload_format_version=gateway.PayloadFormatVersion.VERSION_2_0))
```

Important to notice that there are a lot of recommendations when using `cdk`, one of those is that you separate your data stack from your application stack, in the file above you can see a `db_stack` parameter of type `DatabaseStack`, this stack is showed below:

```python
import os

from aws_cdk import core as cdk
import aws_cdk.aws_s3 as s3
import aws_cdk.aws_dynamodb as ddb


class DatabaseStack(cdk.Stack):
    def _create_ddb_table(self, table_name):
        return ddb.Table(self,
            table_name,
            table_name=table_name,
            partition_key=ddb.Attribute(
                name="PK",
                type=ddb.AttributeType.STRING),
            sort_key=ddb.Attribute(
                name="SK",
                type=ddb.AttributeType.STRING),
            billing_mode=ddb.BillingMode.PAY_PER_REQUEST,
            removal_policy=cdk.RemovalPolicy.RETAIN,
            time_to_live_attribute="TTL",
            stream=ddb.StreamViewType.NEW_AND_OLD_IMAGES)

    def __init__(self, scope: cdk.Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)
        self.offers_table = self._create_ddb_table('Offers')
```

Now that we have multiple stacks, we need to specify wich stack we want to synthesise and deploy.

```bash
$ cdk synth DatabaseStack
$ cdk synth CrawlerAppStack
```

## Final result

The final result collects the webpage every hour, you can see the frontend at https://master.dty3vkmmal3tp.amplifyapp.com/.

## Conclusion

Something that all developers do is versioning your code, for obvious reasons like keeping track of changes, revert if needed, and to see what will be deployed to production, this is not something easy when we talk about infraestructure, where you have so many different components. Thats where you can apply `cdk`, by writing all your components, their connections and permissions, everything in one place, where you can change it and review it, reverting bad changes, and if we start to talk about the benefits of the cloud, we are finally able to replicate your entirely application stack in a different region for fast recovery.
