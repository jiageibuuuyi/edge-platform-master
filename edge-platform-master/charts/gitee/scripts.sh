Error: 2 errors occurred:
        * Service "gitee-minio" is invalid: spec.ports[0].nodePort: Invalid value: 35112: provided port is not in the valid range. The range of valid ports is 30000-32767
        * Service "gitee-kibana" is invalid: spec.ports[0].nodePort: Invalid value: 35601: provided port is not in the valid range. The range of valid ports is 30000-32767



helm upgrade --install --create-namespace gitee-database ./gitee-database -n gitee-middleware -f values.standalone.yaml
helm upgrade --install --create-namespace gitee-middleware ./gitee-middleware -n gitee-middleware -f values.standalone.yaml

helm upgrade --install --create-namespace premium ./premium -n gitee -f values.standalone.yaml --debug  --set premium.init.enabled=true

apiVersion: v1
kind: Service
metadata:
  name: gitee-kibana
  labels:
    app.kubernetes.io/name: kibana
    helm.sh/chart: kibana-7.2.4
    app.kubernetes.io/instance: middleware
    app.kubernetes.io/managed-by: Helm
    app.kubernetes.io/version: "7.10.2"

spec:
  type: NodePort
  externalTrafficPolicy: "Cluster"
  ports:
    - name: http
      port: 5601
      targetPort: http
      nodePort: 35601
  selector:
    app.kubernetes.io/name: kibana
    app.kubernetes.io/instance: middleware

apiVersion: v1
kind: Service
metadata:
  name: gitee-minio
  namespace: "default"
  labels:
    app.kubernetes.io/instance: middleware
    app.kubernetes.io/managed-by: Helm
    app.kubernetes.io/name: minio
    app.kubernetes.io/version: 2023.10.25
    helm.sh/chart: minio-12.8.18
spec:
  type: NodePort
  externalTrafficPolicy: "Cluster"
  ports:
    - name: minio-api
      port: 9000
      targetPort: minio-api
      nodePort: 32112
    - name: minio-console
      port: 9001
      targetPort: minio-console
      nodePort: 32113
  selector:
    app.kubernetes.io/instance: middleware
    app.kubernetes.io/name: minio


curl -k -u 'admin:P@88w0rd' -XPOST -H "Content-Type:application/json" -d '{"project_name":"bitnami", "public": true}' "https://harbor.joiningos.com/api/v2.0/projects"
curl -k -u 'admin:P@88w0rd' -XPOST -H "Content-Type:application/json" -d '{"project_name":"elastic", "public": true}' "https://harbor.joiningos.com/api/v2.0/projects"


* Service "premium2-ssh-pilot" is invalid: spec.ports[0].nodePort: Invalid value: 223: provided port is not in the valid range. The range of valid ports is 30000-32767
* Service "premium2-frontend" is invalid: spec.ports[0].nodePort: Invalid value: 80: provided port is not in the valid range. The range of valid ports is 30000-32767

