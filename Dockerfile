FROM alpine:3.11.3

# Metadata
LABEL maintainer="Evil Martians <admin@evilmartians.com>"

ARG KUBECTL_VERSION="v1.17.2"
ARG KUBECTL_CHECKSUM="7732548b9c353114b0dfa173bc7bcdedd58a607a5b4ca49d867bdb4c05dc25a1"
ARG KUBECTL_URL="https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"

ARG HELM_VERSION="v3.1.1"
ARG HELM_CHECKSUM="c90bb022af05db17f9b3ea4898b0ffd6e903039933c07f0d5c45746018f6b677"
ARG HELM_ARCHIVE="helm-${HELM_VERSION}-linux-amd64.tar.gz"
ARG HELM_URL="https://get.helm.sh/${HELM_ARCHIVE}"

WORKDIR /root

RUN apk -U --no-cache upgrade \
    && apk add --no-cache ca-certificates bash git openssh-client
RUN apk add --no-cache -t deps curl \
    && curl -L $KUBECTL_URL -o /usr/local/bin/kubectl \
    && echo "${KUBECTL_CHECKSUM}  /usr/local/bin/kubectl" | sha256sum -c \
    && chmod +x /usr/local/bin/kubectl \
    && curl -L $HELM_URL -o $HELM_ARCHIVE \
    && tar -zxf ${HELM_ARCHIVE} \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && echo "${HELM_CHECKSUM}  /usr/local/bin/helm" | sha256sum -c \
    && apk del --purge deps \
    && rm -rf linux-amd64 $HELM_ARCHIVE

CMD ["/bin/sh"]
