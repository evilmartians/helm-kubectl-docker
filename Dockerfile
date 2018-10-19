FROM alpine:3.8

# Metadata
LABEL maintainer="Evil Martians <admin@evilmartians.com>"

ARG KUBE_LATEST_VERSION="v1.12.1"
ARG HELM_VERSION="v2.11.0"
ARG HELM_ARCHIVE="helm-${HELM_VERSION}-linux-amd64.tar.gz"

RUN apk add --update ca-certificates \
    && apk add --update -t deps curl \
    && apk add bash \
    && curl -L https://storage.googleapis.com/kubernetes-release/release/$KUBE_LATEST_VERSION/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && echo "abba8834d6bce74cacf4edcdf73b30075f89545ec3ca5a0594061e6cebe13975  /usr/local/bin/kubectl" | sha256sum -c \
    && chmod +x /usr/local/bin/kubectl \
    && curl -L "https://storage.googleapis.com/kubernetes-helm/${HELM_ARCHIVE}" -o "/tmp/${HELM_ARCHIVE}" \
    && echo "02a4751586d6a80f6848b58e7f6bd6c973ffffadc52b4c06652db7def02773a1  /tmp/${HELM_ARCHIVE}" | sha256sum -c \
    && tar -zxvf /tmp/${HELM_ARCHIVE} -C /tmp \
    && mv /tmp/linux-amd64/helm /usr/local/bin/helm \
    && apk del --purge deps \
    && rm /var/cache/apk/* \
    && rm -rf /tmp/*

WORKDIR /root

CMD ["/bin/sh"]
