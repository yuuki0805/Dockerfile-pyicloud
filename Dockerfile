FROM python:alpine
RUN apk --no-cache add --virtual build-dependencies gcc musl-dev python3-dev libffi-dev openssl-dev cargo && \
    python -m pip install -U pip && \
    pip install --no-cache-dir pyicloud && \
    rm -rf /root/.cache && \
    rm -rf /root/.cargo/git && \
    rm -rf /root/.cargo/registry && \
    apk del --purge build-dependencies
RUN mkdir /docker
COPY docker-entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
VOLUME ["/docker"]
ENTRYPOINT ["docker-entrypoint.sh"]
