#/bin/sh

# Install Cloudreve
VERSION="$(curl --retry 10 --retry-max-time 60 https://api.github.com/repos/cloudreve/Cloudreve/releases/latest | jq .tag_name | sed 's/\"//g')"
wget -qO - https://github.com/cloudreve/Cloudreve/releases/download/${VERSION}/cloudreve_${VERSION}_linux_amd64.tar.gz | tar -zxf - -C /usr/bin

# Install Aria2
wget -qO - https://github.com/P3TERX/Aria2-Pro-Core/releases/download/1.36.0_2021.08.22/aria2-1.36.0-static-linux-amd64.tar.gz | tar -zxf - -C /usr/bin