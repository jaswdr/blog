#!/bin/bash

hugo serve \
    --baseUrl http://desktop.jaswdr.dev \
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
