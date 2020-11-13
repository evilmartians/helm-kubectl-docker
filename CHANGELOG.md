# UNRELEASED

# 3.4.1 (13.11.2020)
- Alpine: 3.12.1
- Helm: 3.4.1
- Kubectl: 1.19.4
- Fluxctl: 1.21.0
- Dockerfile: make helm shasum fetchable
- Dockerfile: make kubectl shasum fetchable

# 2.16.1-2 (25.11.2019)
- Added `openssh-client` executable to allow `git clone`.

# 2.16.1-1 (25.11.2019)
- Added `git` executable to allow speed up `git clone` on certain CI platforms.

# 2.16.1 (13.11.2019)
- Helm version set to [2.16.1](https://github.com/helm/helm/releases/tag/v2.16.1)

# 2.16.0 (07.11.2019)
- Helm version set to 2.16.0
- Kubectl version set to 1.16.2
- Dockerfile: make base installation as separate layer
- Dockerfile: set WORKDIR before RUN
- Dockerfile: add --no-cache to apk args
- Baseimage set to alpine-3.10.3
