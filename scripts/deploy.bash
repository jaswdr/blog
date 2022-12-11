#!/bin/bash

set -e

aws --profile=blog-publisher s3 sync ./public/ s3://jaswdr.dev/ \
    --storage-class ONEZONE_IA \
    --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers
