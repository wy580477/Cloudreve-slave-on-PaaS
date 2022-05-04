#!/bin/sh

# Install aria2
curl -s --retry 10 --retry-max-time 60 -H "Cache-Control: no-cache" -fsSL github.com/P3TERX/Aria2-Pro-Core/releases/download/1.36.0_2021.08.22/aria2-1.36.0-static-linux-amd64.tar.gz -o - | tar -zxf - -C /usr/bin

# Install Cloudreve
VERSION="$(curl --retry 10 --retry-max-time 60 https://api.github.com/repos/cloudreve/Cloudreve/releases/latest | jq .tag_name | sed 's/\"//g')"
curl -s --retry 10 --retry-max-time 20 -H "Cache-Control: no-cache" -fsSL github.com/cloudreve/Cloudreve/releases/download/${VERSION}/cloudreve_${VERSION}_linux_amd64.tar.gz -o - | tar -zxf - -C /usr/bin
