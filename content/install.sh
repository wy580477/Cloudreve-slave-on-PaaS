#!/bin/sh

# Install Cloudreve
if [ -f /workdir/*.tar.gz ]; then
    tar -zxf /workdir/*.tar.gz -C /workdir
    rm -f /workdir/*.tar.gz
else
    VERSION="$(curl -IkLs -o /tmp/NUL -w %{url_effective} https://github.com/cloudreve/cloudreve/releases/latest | grep -o "[^/]*$")"
    wget -qO - https://github.com/cloudreve/Cloudreve/releases/download/${VERSION}/cloudreve_${VERSION}_linux_amd64.tar.gz | tar -zxf - -C /workdir
fi

# Install Aria2
wget -qO - https://github.com/P3TERX/Aria2-Pro-Core/releases/download/1.36.0_2021.08.22/aria2-1.36.0-static-linux-amd64.tar.gz | tar -zxf - -C /usr/bin
