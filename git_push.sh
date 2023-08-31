#!/bin/bash
ysyx_stage="PA0"
PROXY_SRC=./utils/util_proxy_env.sh

t=`date`
# COMMIT_INFO="script commit: ${t}"
# COMMIT_INFO="first commit"
COMMIT_INFO="feat<${ysyx_stage}>:完成“接入NVBoard” (${t})"
# COMMIT_INFO="docs<${ysyx_stage}>:"
# COMMIT_INFO="test<${ysyx_stage}>:"
# COMMIT_INFO="fix<${ysyx_stage}>:"


sh ${PROXY_SRC}

git add ./*
git commit -m "${COMMIT_INFO}"
git push
