FROM alpine:3.10.3

# Metadata
LABEL maintainer="Evil Martians <admin@evilmartians.com>"

ARG KUBECTL_VERSION="v1.16.2"
ARG KUBECTL_CHECKSUM="3ff48e12f9c768ad548e4221d805281ea28dfcda5c18b3cd1797fe37aee3012e"
ARG KUBECTL_URL="https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"

ARG HELM_VERSION="v2.15.2"
ARG HELM_CHECKSUM="a9d2db920bd4b3d824729bbe1ff3fa57ad27760487581af6e5d3156d1b3c2511"
ARG HELM_ARCHIVE="helm-${HELM_VERSION}-linux-amd64.tar.gz"
ARG HELM_URL="https://storage.googleapis.com/kubernetes-helm/${HELM_ARCHIVE}"

WORKDIR /root

RUN apk -U --no-cache upgrade \
    && apk add --no-cache ca-certificates bash
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
