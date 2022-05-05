FROM cloudreve/cloudreve:latest

COPY ./content /workdir/

RUN apk add --no-cache runit curl aria2 redis \
    && chmod +x /workdir/*.sh /workdir/service/*/run \
    && ln -s /workdir/service/* /etc/service/

ENTRYPOINT ["runsvdir","-P","/etc/service"]
