kubectl delete svc traefik -n kube-system
istioctl install --set profile=demo --skip-confirmation
kubectl apply -f https://github.com/knative/serving/releases/download/v0.22.0/serving-crds.yaml
kubectl apply -f https://github.com/knative/serving/releases/download/v0.22.0/serving-core.yaml
kubectl apply -f https://github.com/knative/net-istio/releases/download/v0.22.0/net-istio.yaml
kubectl create ns demo
kubectl label namespace demo istio-injection=enabled
kubectl label namespace knative-serving istio-injection=enabled
ipaddress=$(kubectl get svc  istio-ingressgateway -n istio-system | awk 'NR==2 {print $4}')
cat <<EOF > domain-config.yaml 
apiVersion: v1
kind: ConfigMap
metadata:
  name: config-domain
  namespace: knative-serving
data:
  ${ipaddress}.sslip.io: ""
EOF
kubectl apply -f domain-config.yaml
