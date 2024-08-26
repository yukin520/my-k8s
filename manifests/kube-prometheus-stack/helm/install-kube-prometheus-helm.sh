helm install  kube-prometheus-stack prometheus-community/kube-prometheus-stack \
    -n kube-prometheus \
    -f my-values.yml \
    -f my-values-secret.yml