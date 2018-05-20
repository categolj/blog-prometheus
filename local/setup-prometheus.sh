#!/bin/bash
VERSION=2.2.1
cd `dirname $0`
if [ ! -d prometheus ];then
    wget https://homebrew.bintray.com/bottles/prometheus-${VERSION}.high_sierra.bottle.tar.gz
    tar xzf prometheus-${VERSION}.high_sierra.bottle.tar.gz
    rm -f prometheus-${VERSION}.high_sierra.bottle.tar.gz
fi