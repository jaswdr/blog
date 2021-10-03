#!/bin/bash

hugo serve \
    --baseUrl http://$(hostname):1313 \
    --bind 0.0.0.0 \
    --buildDrafts \
    --cleanDestinationDir \
    --forceSyncStatic \
    --ignoreCache \
    --navigateToChanged \
    --noChmod \
    --noHTTPCache \
    --noTimes \
    --watch
