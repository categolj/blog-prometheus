#!/bin/bash
VERSION=5.1.2

`dirname $0`/grafana/${VERSION}/bin/grafana-server \
  -homepath=`dirname $0`/grafana/${VERSION}/share/grafana