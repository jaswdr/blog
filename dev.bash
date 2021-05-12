#!/bin/bash

hugo serve \
    --watch \
    --ignoreCache \
    --cleanDestinationDir \
    --forceSyncStatic \
    --noChmod \
    --noHTTPCache \
    --navigateToChanged \
    --noChmod \
    --noTimes \
    --bind 0.0.0.0 \
    --baseUrl http://oss
