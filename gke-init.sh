#!/bin/sh

# Required variables:
#   GCLOUD_SA_KEY: base64 encoded string with service account key (cat /pat/to/key | base64 -w0)
#   GCLOUD_PROJECT_ID: gcloud project ID in plain text e.g. 'my-project-12345'
#   GCLOUD_GKE_CLUSTER_NAME: your GKE cluster name in plain text e.g. 'production'
#   GCLOUD_GKE_ZONE: GCP zone where your GKE cluster is running e.g. 'europe-west3-c'

# Check required variables
[ -z "$GCLOUD_SA_KEY" ] && { echo "GCLOUD_SA_KEY is required"; exit 1; }
[ -z "$GCLOUD_PROJECT_ID" ] && { echo "GCLOUD_PROJECT_ID is required"; exit 1; }
[ -z "$GCLOUD_GKE_CLUSTER_NAME" ] && { echo "GCLOUD_GKE_CLUSTER_NAME is required"; exit 1; }
[ -z "$GCLOUD_GKE_ZONE" ] && { echo "GCLOUD_GKE_ZONE is required"; exit 1; }

echo "Initializing gcloud auth"
echo $GCLOUD_SA_KEY | base64 -d > /tmp/key.json
gcloud auth activate-service-account --key-file=/tmp/key.json

echo "Initializing GKE cluster"
gcloud container clusters get-credentials ${GCLOUD_GKE_CLUSTER_NAME} && \
  --zone=${GCLOUD_GKE_ZONE} && \
  --project=${GCLOUD_PROJECT_ID}

