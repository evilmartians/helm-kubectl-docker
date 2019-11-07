FROM alpine:3.10.3

# Metadata
LABEL maintainer="Evil Martians <admin@evilmartians.com>"

ARG HELM_VERSION="v2.15.1"
ARG KUBECTL_VERSION="v1.16.2"
ARG KUBECTL_CHECKSUM="3ff48e12f9c768ad548e4221d805281ea28dfcda5c18b3cd1797fe37aee3012e"
ARG KUBECTL_URL="https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"

ARG HELM_ARCHIVE="helm-${HELM_VERSION}-linux-amd64.tar.gz"

WORKDIR /root

RUN apk -U --no-cache upgrade \
    && apk add --no-cache ca-certificates bash
RUN apk add --no-cache -t deps curl \
    && curl -L $KUBECTL_URL -o /usr/local/bin/kubectl \
    && echo "${KUBECTL_CHECKSUM}  /usr/local/bin/kubectl" | sha256sum -c \
    && chmod +x /usr/local/bin/kubectl \
    && curl -L "https://storage.googleapis.com/kubernetes-helm/${HELM_ARCHIVE}" -o "/tmp/${HELM_ARCHIVE}" \
    && echo "b4d366bd6625477b2954941aeb7b601946aa4226af6728e3a84eac4e62a84042  /tmp/${HELM_ARCHIVE}" | sha256sum -c \
    && tar -zxvf /tmp/${HELM_ARCHIVE} -C /tmp \
    && mv /tmp/linux-amd64/helm /usr/local/bin/helm \
    && apk del --purge deps \
    && rm -rf /tmp/*

CMD ["/bin/sh"]
