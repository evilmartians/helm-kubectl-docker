FROM alpine:3.10

# Metadata
LABEL maintainer="Evil Martians <admin@evilmartians.com>"

ARG KUBE_LATEST_VERSION="v1.15.5"
ARG HELM_VERSION="v2.15.1"
ARG HELM_ARCHIVE="helm-${HELM_VERSION}-linux-amd64.tar.gz"

RUN apk add --update ca-certificates \
    && apk add --update -t deps curl \
    && apk add bash \
    && curl -L https://storage.googleapis.com/kubernetes-release/release/$KUBE_LATEST_VERSION/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && echo "be84cf088241f29eca6221430f8fdb3788bc80eccb79b839d721c0daa6b46244  /usr/local/bin/kubectl" | sha256sum -c \
    && chmod +x /usr/local/bin/kubectl \
    && curl -L "https://storage.googleapis.com/kubernetes-helm/${HELM_ARCHIVE}" -o "/tmp/${HELM_ARCHIVE}" \
    && echo "b4d366bd6625477b2954941aeb7b601946aa4226af6728e3a84eac4e62a84042  /tmp/${HELM_ARCHIVE}" | sha256sum -c \
    && tar -zxvf /tmp/${HELM_ARCHIVE} -C /tmp \
    && mv /tmp/linux-amd64/helm /usr/local/bin/helm \
    && apk del --purge deps \
    && rm /var/cache/apk/* \
    && rm -rf /tmp/*

WORKDIR /root

CMD ["/bin/sh"]
