FROM alpine:latest

COPY ./content /workdir/

RUN apk add --no-cache runit curl redis gcompat \
    && chmod +x /workdir/*.sh /workdir/service/*/run \
    && /workdir/install.sh \
    && rm /workdir/install.sh \
    && ln -s /workdir/service/* /etc/service/

ENV PORT=3000

EXPOSE 3000

ENTRYPOINT ["runsvdir","-P","/etc/service"]
