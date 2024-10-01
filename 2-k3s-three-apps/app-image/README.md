# Overview

### [**This image is deployed to dockerhub**](https://hub.docker.com/repository/docker/osmoussao/hello-kubernetes/general)

## ENVIRONMENT:

- APP_MESSAGE: message to show from the app
- HOSTNAME: takes pod name by default
- NODE_INFO: any host node info you want to display, like machine name and/or its operating system
- PORT: port on which the server listens to (defaults to 3000)

## Example

```shell
docker run -d \
--name my-k8s-app \
-p 3000:3000 \
-e APP_MESSAGE="Hello From App 1" \
-e NODE_INFO="master-node, Ubuntu 24.04 LTS" \
osmoussao/hello-kubernetes:0.0.1
```
