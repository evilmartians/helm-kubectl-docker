FROM alpine:3.12.0

# Metadata
LABEL maintainer="Evil Martians <admin@evilmartians.com>"

ARG KUBECTL_VERSION="v1.18.3"
ARG KUBECTL_URL="https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
ARG KUBECTL_SHA256
ARG KUBECTL_SHA256_URL="https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl.sha256"

ARG HELM_VERSION="v3.2.1"
ARG HELM_CHECKSUM="98c57f2b86493dd36ebaab98990e6d5117510f5efbf21c3344c3bdc91a4f947c"
ARG HELM_ARCHIVE="helm-${HELM_VERSION}-linux-amd64.tar.gz"
ARG HELM_URL="https://get.helm.sh/${HELM_ARCHIVE}"

ARG FLUXCTL_VERSION="1.19.0"
ARG FLUXCTL_CHECKSUM="0e5855ec75eb64340967ea893127a794f0473509c123c16fb251cc6410cfcb7f"
ARG FLUXCTL_URL="https://github.com/fluxcd/flux/releases/download/${FLUXCTL_VERSION}/fluxctl_linux_amd64"

WORKDIR /root

RUN apk -U --no-cache upgrade \
    && apk add --no-cache ca-certificates bash git openssh-client
RUN apk add --no-cache -t deps curl \
    && curl -L $KUBECTL_URL -o /usr/local/bin/kubectl \
    && echo "${KUBECTL_SHA256:-$(curl -sSL $KUBECTL_SHA256_URL)}  /usr/local/bin/kubectl" | sha256sum -c \
    && chmod +x /usr/local/bin/kubectl \
    && curl -L $HELM_URL -o $HELM_ARCHIVE \
    && tar -zxf ${HELM_ARCHIVE} \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && echo "${HELM_CHECKSUM}  /usr/local/bin/helm" | sha256sum -c \
    && curl -L ${FLUXCTL_URL} -o /usr/local/bin/fluxctl \
    && echo "${FLUXCTL_CHECKSUM}  /usr/local/bin/fluxctl" | sha256sum -c \
    && chmod +x /usr/local/bin/fluxctl \
    && apk del --purge deps \
    && rm -rf linux-amd64 $HELM_ARCHIVE

CMD ["/bin/sh"]
