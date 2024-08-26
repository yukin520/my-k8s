
export GRAFANA_CLOUD_ACCESS_KEY="XXXXXXXXXX"
export GRAFANA_CLOUD_USER_ID="1627409"

kubectl create secret generic kubepromsecret \
    --from-literal=username=$GRAFANA_CLOUD_USER_ID \
    --from-literal=password=$GRAFANA_CLOUD_ACCESS_KEY \
    -n kube-prometheus --dry-run  -o yaml > grafana-cloud-secret.yml