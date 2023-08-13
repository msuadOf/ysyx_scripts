#!/bin/sh
t1=`date`

git add .
git commit -m "script commit: ${t1}"
git push