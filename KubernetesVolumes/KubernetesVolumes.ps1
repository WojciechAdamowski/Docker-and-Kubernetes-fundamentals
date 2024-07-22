$repoPath = "your\repository\path"

# Set repo path
Set-Location $repoPath

# Create an image for the pod 
docker image build --rm --pull --tag docker-run-app:v1 --file dockerfile .
docker image ls docker-run-app

# Create Volume
kubectl apply --filename .\KubernetesVolumes\Yamls\volume-persistent.yaml
# Create Volume Claim
kubectl apply --filename .\KubernetesVolumes\Yamls\volume-persistent-claim.yaml
# Create Service for entering Pod
kubectl apply --filename .\KubernetesVolumes\Yamls\service-node-port.yaml
# Create Pod connected to Volume Claim
kubectl apply --filename .\KubernetesVolumes\Yamls\pod-with-volume.yaml

# Wait few seconds
# Check that is web app available
Start-Process "http://localhost:32410/"
Start-Process "http://localhost:32410/read"
Start-Process "http://localhost:32410/append"
Start-Process "http://localhost:32410/read"

# Check Pod
kubectl get pods -o wide
# Check Volume is bounded
kubectl get pv
# Check Volume Claim is bounded and claimed to web-app-volume
kubectl get pvc

# Recreate the Pod for testing that is volume storing the data
kubectl delete --filename .\KubernetesVolumes\Yamls\pod-with-volume.yaml
kubectl apply --filename .\KubernetesVolumes\Yamls\pod-with-volume.yaml
# Wait few seconds
Start-Process "http://localhost:32410/read"

# Delete all previous created obejcts starting from pod
kubectl delete --filename .\KubernetesVolumes\Yamls\pod-with-volume.yaml
kubectl delete --filename .\KubernetesVolumes\Yamls\service-node-port.yaml
kubectl delete --filename .\KubernetesVolumes\Yamls\volume-persistent-claim.yaml
kubectl delete --filename .\KubernetesVolumes\Yamls\volume-persistent.yaml

docker image rm docker-run-app:v1