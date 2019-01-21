# Helmer: a dogsbody for Helm deployments on GKE

This simple image is meant to be executed in CI/CD environments 
in the grand finale when you want to deploy your Helm chart to GKE.

It does not aim to be an universal tool to solve all the misery 
of this universe. It just makes one very specific scenario happen.

[![](https://images.microbadger.com/badges/image/ackee/helmer-gke.svg)](https://microbadger.com/images/ackee/helmer-gke 
"Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/ackee/helmer-gke.svg)](https://microbadger.com/images/ackee/helmer-gke 
"Get your own version badge on microbadger.com")

## Gitlab CI example

```yaml
deploy:gke:
  image: ackee/helmer-gke
  environment: production
  variables:
    # GCLOUD_SA_KEY: this one should be defined under Settings > CI/CD > Environment variables
    # you can even interpolate different variables for different environments:
    # GCLOUD_SA_KEY: $GCLOUD_SA_KEY_PRODUCTION
    GCLOUD_PROJECT_ID: my-project-12345
    GCLOUD_GKE_CLUSTER_NAME: production
    GCLOUD_GKE_ZONE: europe-west3-c
  script:
    - gke-init
    # optional step, check https://github.com/vranystepan/vaultier/
    - vaultier
    - helm upgrade release-name -i -f /path/to/values.yaml -f /path/to/secrets /path/to/chart
```
