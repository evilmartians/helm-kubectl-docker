# Docker image with helm & kubectl cli tools

This is yet another docker image with helm & kubectl command line tools made for automated deployments.

The idea is that you should own an image which you use in your CI for deployment, so we have our own copy too.

Use this one at your own risk!

## Details

Tags:

* `2.16.1-1` - helm `2.16.1`; kubectl `1.16.2`; git `2.22.0-r0`;  alpine `3.10.3`
* `2.16.1` - helm `2.16.1`; kubectl `1.16.2`; alpine `3.10.3`
* `2.16.0` - helm `2.16.0`; kubectl `1.16.2`; alpine `3.10.3`
* `2.13.0` - helm `2.13.0`; kubectl `1.13.3`; alpine `3.9`
* `2.12.3` - helm `2.12.3`; kubectl `1.13.3`; alpine `3.8`
* `2.12.0` - helm `2.12.0`; kubectl `1.13.0`; alpine `3.8`

## Docker pull

```shell
docker pull quay.io/evl.ms/helm-kubectl:2.16.1-1
```
