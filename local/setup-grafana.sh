#!/bin/bash
VERSION=5.1.2
cd `dirname $0`
if [ ! -d grafana ];then
    wget https://homebrew.bintray.com/bottles/grafana-${VERSION}.high_sierra.bottle.tar.gz
    tar xzf grafana-${VERSION}.high_sierra.bottle.tar.gz
    rm -f grafana-${VERSION}.high_sierra.bottle.tar.gz
fi

cat <<EOF > grafana/${VERSION}/share/grafana/conf/provisioning/datasources/prometheus.yml
apiVersion: 1
datasources:
- name: prometheus
  type: prometheus
  access: proxy
  orgId: 1
  url: http://localhost:9090
  password:
  basicAuth: false
  isDefault: true
  version: 1
  editable: true
EOF

cat <<EOF > grafana/${VERSION}/share/grafana/conf/provisioning/dashboards/micrometer.yml
apiVersion: 1
providers:
- name: 'micrometer'
  orgId: 1
  folder: ''
  type: file
  options:
    path: $(cd .. && pwd)/dashboards
EOF

if [ ! -d ../dashboards ];then
    mkdir -p ../dashboards
    curl -Ls https://github.com/making/demo-micrometer/raw/master/grafana/micrometer-summary-k8s.json | sed 's/\${DS_PROMETHEUS-K8S}/prometheus/g' > ../dashboards/micrometer-summary-k8s.json
    curl -Ls https://github.com/making/demo-micrometer/raw/master/grafana/micrometer-ux-k8s.json | sed 's/\${DS_PROMETHEUS-K8S}/prometheus/g' > ../dashboards/micrometer-ux-k8s.json
    curl -Ls https://github.com/making/demo-micrometer/raw/master/grafana/micrometer-hystrix-k8s.json | sed 's/\${DS_PROMETHEUS-K8S}/prometheus/g' > ../dashboards/micrometer-hystrix-k8s.json
fi