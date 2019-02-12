FROM alpine:3.8
MAINTAINER stepan.vrany@ackee.cz

# Copy GKE initialization script
COPY gke-init.sh /usr/local/bin/gke-init

# install:
#   - gcloud SDK version 230
#   - kubectl
#   - Helm 2.11.0
#   - Vaultier v1.0.02
# ensure files have correct permissions:
#   - /usr/local/bin/gke-init
RUN echo installing gcloud SDK ... && \
  wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-230.0.0-linux-x86_64.tar.gz -O g.tar.gz > /dev/null 2>&1 && \
  tar -xvf g.tar.gz > /dev/null 2>&1 && \
  rm -rf g.tar.gz && \
  mkdir -p /opt && \
  mv google-cloud-sdk /opt/google-cloud-sdk && \
  apk add python > /dev/null 2>&1 && \
  /opt/google-cloud-sdk/install.sh -q > /dev/null 2>&1 && \
  /opt/google-cloud-sdk/bin/gcloud config set component_manager/disable_update_check true > /dev/null 2>&1 && \
  echo installing Kubectl ... && \
  /opt/google-cloud-sdk/bin/gcloud components install kubectl -q > /dev/null 2>&1 && \
  echo installing Helm ... && \
  wget https://storage.googleapis.com/kubernetes-helm/helm-v2.11.0-linux-amd64.tar.gz -O h.tar.gz > /dev/null 2>&1 && \
  tar -xvf h.tar.gz > /dev/null 2>&1 && \
  rm -rf h.tar.gz && \
  mv linux-amd64/helm /usr/local/bin && \
  rm -rf linux-amd64 && \
  echo installing Vaultier ... && \
  wget https://github.com/AckeeDevOps/vaultier/releases/download/v1.0.2/vaultier-v1.0.2 -O /usr/local/bin/vaultier > /dev/null 2>&1 && \
  chmod +x /usr/local/bin/vaultier && \
  chmod +x /usr/local/bin/gke-init && \
  echo installing ca-certificates ... && \
  apk add ca-certificates > /dev/null 2>&1 && \
  apk add openssl > /dev/null 2>&1

ENV PATH="${PATH}:/opt/google-cloud-sdk/bin/"

