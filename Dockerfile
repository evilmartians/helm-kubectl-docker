FROM alpine:3.8

# Metadata
LABEL maintainer="Evil Martians <admin@evilmartians.com>"

ARG KUBE_LATEST_VERSION="v1.13.3"
ARG HELM_VERSION="v2.12.3"
ARG HELM_ARCHIVE="helm-${HELM_VERSION}-linux-amd64.tar.gz"

RUN apk add --update ca-certificates \
    && apk add --update -t deps curl \
    && apk add bash \
    && curl -L https://storage.googleapis.com/kubernetes-release/release/$KUBE_LATEST_VERSION/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && echo "f3be209a48394e0e649b30ea376ce5093205fd6769c12e62c7ab39a0827c26fb  /usr/local/bin/kubectl" | sha256sum -c \
    && chmod +x /usr/local/bin/kubectl \
    && curl -L "https://storage.googleapis.com/kubernetes-helm/${HELM_ARCHIVE}" -o "/tmp/${HELM_ARCHIVE}" \
    && echo "3425a1b37954dabdf2ba37d5d8a0bd24a225bb8454a06f12b115c55907809107  /tmp/${HELM_ARCHIVE}" | sha256sum -c \
    && tar -zxvf /tmp/${HELM_ARCHIVE} -C /tmp \
    && mv /tmp/linux-amd64/helm /usr/local/bin/helm \
    && apk del --purge deps \
    && rm /var/cache/apk/* \
    && rm -rf /tmp/*

WORKDIR /root

CMD ["/bin/sh"]
