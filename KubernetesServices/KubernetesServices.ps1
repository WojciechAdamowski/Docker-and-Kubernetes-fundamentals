$repoPath = "your\repository\path"

# Set repo path
Set-Location $repoPath

# Create an image for the pod 
docker image build --rm --pull --tag docker-run-app:v1 --file dockerfile .
docker image ls docker-run-app

# Create the pod for the services
kubectl apply --filename .\KubernetesServices\Yamls\pod.yaml
kubectl apply --filename .\KubernetesServices\Yamls\pod-busybox.yaml

# Check that are every pod exist
kubectl get pods -o wide 

# Create the ClusterIP service
kubectl apply --filename .\KubernetesServices\Yamls\service-cluster-ip.yaml

# Check that is the ClusterIP service exist
kubectl get svc -o wide

# Check the connection between web-app and busybox pod
kubectl exec web-app-for-services-busybox -it -- /bin/sh
wget -qO- http://web-service-cluster-ip:80
exit

# Delete objects related to ClusterIP
kubectl delete --filename .\KubernetesServices\Yamls\service-cluster-ip.yaml
kubectl delete --filename .\KubernetesServices\Yamls\pod-busybox.yaml

# Create the NodePort service
kubectl apply --filename .\KubernetesServices\Yamls\service-node-port.yaml

# Check that is the NodePort service exist
kubectl get svc -o wide

# Check that is web app available
Start-Process "http://localhost:32410/"

kubectl delete --filename .\KubernetesServices\Yamls\service-node-port.yaml
kubectl delete --filename .\KubernetesServices\Yamls\pod.yaml

# Delete rest objects for clarity
docker image rm docker-run-app:v1