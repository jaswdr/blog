#!/bin/bash

hugo serve \
    --baseUrl http://$(hostname) \
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
