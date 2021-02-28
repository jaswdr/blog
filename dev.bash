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
    --noTimes
