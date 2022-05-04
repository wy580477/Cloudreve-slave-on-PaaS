FROM redis:alpine

COPY ./content /workdir/

ARG MODE=build

RUN apk add --no-cache runit curl gcompat tzdata \
    && chmod +x /workdir/*.sh /workdir/service/*/run \
    && apk add --no-cache --virtual .build-deps jq \
    && /workdir/install.sh \
    && apk del .build-deps \
    && ln -s /workdir/service/* /etc/service/

ENTRYPOINT ["runsvdir","-P","/etc/service"]
