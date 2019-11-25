FROM alpine:3.10.3

# Metadata
LABEL maintainer="Evil Martians <admin@evilmartians.com>"

ARG KUBECTL_VERSION="v1.16.2"
ARG KUBECTL_CHECKSUM="3ff48e12f9c768ad548e4221d805281ea28dfcda5c18b3cd1797fe37aee3012e"
ARG KUBECTL_URL="https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"

ARG HELM_VERSION="v2.16.1"
ARG HELM_CHECKSUM="7eebaaa2da4734242bbcdced62cc32ba8c7164a18792c8acdf16c77abffce202"
ARG HELM_ARCHIVE="helm-${HELM_VERSION}-linux-amd64.tar.gz"
ARG HELM_URL="https://storage.googleapis.com/kubernetes-helm/${HELM_ARCHIVE}"

WORKDIR /root

RUN apk -U --no-cache upgrade \
    && apk add --no-cache ca-certificates bash git
RUN apk add --no-cache -t deps curl \
    && curl -L $KUBECTL_URL -o /usr/local/bin/kubectl \
    && echo "${KUBECTL_CHECKSUM}  /usr/local/bin/kubectl" | sha256sum -c \
    && chmod +x /usr/local/bin/kubectl \
    && curl -L $HELM_URL -o $HELM_ARCHIVE \
    && echo "${HELM_CHECKSUM}  ${HELM_ARCHIVE}" | sha256sum -c \
    && tar xf ${HELM_ARCHIVE} \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && apk del --purge deps \
    && rm -rf linux-amd64 $HELM_ARCHIVE

CMD ["/bin/sh"]
