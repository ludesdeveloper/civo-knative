ipaddress=$(kubectl get svc  istio-ingressgateway -n istio-system | awk 'NR==2 {print $4}')
hey -z 30s -c 100 \
  "http://autoscale-go.default.${ipaddress}.sslip.io?sleep=100&prime=10000&bloat=5" \
  && kubectl get pods

