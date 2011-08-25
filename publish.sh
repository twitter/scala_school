#!/bin/bash

dir=$1
out=/tmp/school.$$

trap "rm -fr $out" 0 1 2
git clone -b gh-pages git@github.com:twitter/scala_school.git $out
cp -r $dir/* $out/
cd $out
git add .
git commit -am"publish by $USER"
git push origin gh-pages
