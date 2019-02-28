#!/bin/bash

# For Linux-based official distribution install
export SWI_HOME_DIR=/usr/lib/swi-prolog
export LD_LIBRARY_PATH=$SWI_HOME_DIR/lib/x86_64-linux/:$SWI_HOME_DIR/lib/amd64/:$LD_LIBRARY_PATH

# For a local install under /usr/local/swipl-git
# Uncomment and adapt the path if you have compiled and installed SWI manually from repo
#export SWI_HOME_DIR=/usr/local/swipl-git/lib/swipl/
#export LD_LIBRARY_PATH=$SWI_HOME_DIR/lib/x86_64-linux/:$SWI_HOME_DIR/lib/amd64/:$LD_LIBRARY_PATH


# This is actually only needed if your execution complains because it has to be pre-loaded
# Check https://answers.ros.org/question/132411/unable-to-load-existing-owl-in-semantic-map-editor/
export LD_PRELOAD=libswipl.so:$LD_PRELOAD

# Set SARL VERSION
export SARL_VERSION=0.8.6
