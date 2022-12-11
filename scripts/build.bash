#!/bin/bash

hugo \
    --baseURL https://jaswdr.dev \
    --cleanDestinationDir \
    --enableGitInfo \
    --minify \
    --noChmod \
    --noTimes
