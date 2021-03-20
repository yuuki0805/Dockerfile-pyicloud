FROM python:alpine3.12 AS builder
RUN apk add gcc musl-dev python3-dev libffi-dev openssl-dev cargo
RUN pip install pyicloud

FROM python:alpine AS runner
COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
RUN mkdir /docker
COPY docker-entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
VOLUME ["/docker"]
ENTRYPOINT ["docker-entrypoint.sh"]
