#!/bin/bash
VERSION=2.2.1

`dirname $0`/prometheus/${VERSION}/bin/prometheus \
  --config.file=`dirname $0`/prometheus.yml