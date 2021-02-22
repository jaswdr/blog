#!/bin/bash

hugo -b https://jaswdr.dev \
    --cleanDestinationDir \
    --enableGitInfo \
    --forceSyncStatic \
    --ignoreCache \
    --minify \
    --noChmod \
    --noTimes

hugo deploy
