#/bin/sh

VERSION="$(curl --retry 10 --retry-max-time 60 https://api.github.com/repos/cloudreve/Cloudreve/releases/latest | jq .tag_name | sed 's/\"//g')"
wget -qO - https://github.com/cloudreve/Cloudreve/releases/download/${VERSION}/cloudreve_${VERSION}_linux_amd64.tar.gz | tar -zxf - -C /usr/bin