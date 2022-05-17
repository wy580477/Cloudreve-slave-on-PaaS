FROM alpine:latest

COPY ./content /workdir/

RUN apk add --no-cache runit curl jq redis gcompat \
    && chmod +x /workdir/*.sh /workdir/service/*/run \
    && /workdir/install.sh \
    && ln -s /workdir/service/* /etc/service/

ENTRYPOINT ["runsvdir","-P","/etc/service"]
