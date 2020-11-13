FROM alpine:3.12.1

# Metadata
LABEL maintainer="Evil Martians <admin@evilmartians.com>"

ARG KUBECTL_VERSION="v1.19.4"
ARG KUBECTL_URL="https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
ARG KUBECTL_SHA256
ARG KUBECTL_SHA256_URL="https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl.sha256"

ARG HELM_VERSION="v3.4.1"
ARG HELM_SHA256
ARG HELM_SHA256_URL="https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz.sha256sum"
ARG HELM_ARCHIVE="helm-${HELM_VERSION}-linux-amd64.tar.gz"
ARG HELM_URL="https://get.helm.sh/${HELM_ARCHIVE}"

ARG FLUXCTL_VERSION="1.21.0"
ARG FLUXCTL_CHECKSUM="b429f7bf20703fa2ebbd4b7b2955fb787545e0dc424c17c1d654caea24910653"
ARG FLUXCTL_URL="https://github.com/fluxcd/flux/releases/download/${FLUXCTL_VERSION}/fluxctl_linux_amd64"

WORKDIR /root

RUN apk -U --no-cache upgrade \
    && apk add --no-cache ca-certificates bash git openssh-client
RUN apk add --no-cache -t deps curl \
    && curl -L $KUBECTL_URL -o /usr/local/bin/kubectl \
    && echo "${KUBECTL_SHA256:-$(curl -sSL $KUBECTL_SHA256_URL)}  /usr/local/bin/kubectl" | sha256sum -c \
    && chmod +x /usr/local/bin/kubectl \
    && curl -L $HELM_URL -o $HELM_ARCHIVE \
    && echo "${HELM_SHA256:-$(curl -sSL $HELM_SHA256_URL | grep -Eo '^[^ ]+')}  ${HELM_ARCHIVE}" | sha256sum -c \
    && tar -zxf ${HELM_ARCHIVE} \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && curl -L ${FLUXCTL_URL} -o /usr/local/bin/fluxctl \
    && echo "${FLUXCTL_CHECKSUM}  /usr/local/bin/fluxctl" | sha256sum -c \
    && chmod +x /usr/local/bin/fluxctl \
    && apk del --purge deps \
    && rm -rf linux-amd64 $HELM_ARCHIVE

CMD ["/bin/sh"]
