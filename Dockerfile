FROM alpine:3.7

# Metadata
LABEL maintainer="Evil Martians <admin@evilmartians.com>"

ENV KUBE_LATEST_VERSION="v1.10.1"
ENV HELM_VERSION="v2.8.2"
ENV HELM_ARCHIVE="helm-${HELM_VERSION}-linux-amd64.tar.gz"

RUN apk add --update ca-certificates \
    && apk add --update -t deps curl \
    && apk add bash \
    && curl -L https://storage.googleapis.com/kubernetes-release/release/$KUBE_LATEST_VERSION/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && echo "1bb4d3793fb0f9e1cfee86599e0f43ae5f15578a01b61011fe7c9488e114a00b  /usr/local/bin/kubectl" | sha256sum -c \
    && chmod +x /usr/local/bin/kubectl \
    && curl -L http://storage.googleapis.com/kubernetes-helm/${HELM_ARCHIVE} -o /tmp/${HELM_ARCHIVE} \
    && echo "614b5ac79de4336b37c9b26d528c6f2b94ee6ccacb94b0f4b8d9583a8dd122d3  /tmp/${HELM_ARCHIVE}" | sha256sum -c \ 
    && tar -zxvf /tmp/${HELM_ARCHIVE} -C /tmp \
    && mv /tmp/linux-amd64/helm /bin/helm \
    && apk del --purge deps \
    && rm /var/cache/apk/* \
    && rm -rf /tmp/*

WORKDIR /root

CMD ["/bin/sh"]