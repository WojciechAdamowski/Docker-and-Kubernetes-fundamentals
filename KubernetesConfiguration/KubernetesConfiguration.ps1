$repoPath = "your\repository\path"

# Set repo path
Set-Location $repoPath

# Create an image for the Pod
docker image build --rm --pull --tag docker-run-app:v1 --file dockerfile .
docker image ls docker-run-app

# Create ConfigMap in propertylike style  
kubectl apply --filename .\KubernetesConfiguration\Yamls\configuration-configmap-propertylike.yaml
# Create Pod using propertylike style ConfigMap
kubectl apply --filename .\KubernetesConfiguration\Yamls\pod-with-configmap-propertylike.yaml
# Show environment variables
kubectl logs pods/web-app-configmap-propertylike
# Cleanup
kubectl delete --filename .\KubernetesConfiguration\Yamls\pod-with-configmap-propertylike.yaml
kubectl delete --filename .\KubernetesConfiguration\Yamls\configuration-configmap-propertylike.yaml

# Create ConfigMap in filelike style 
kubectl apply --filename .\KubernetesConfiguration\Yamls\configuration-configmap-filelike.yaml
# Create Pod using filelike style ConfigMap
kubectl apply --filename .\KubernetesConfiguration\Yamls\pod-with-configmap-filelike.yaml
# Show environment variables
kubectl logs pods/web-app-configmap-filelike
# Cleanup
kubectl delete --filename .\KubernetesConfiguration\Yamls\pod-with-configmap-filelike.yaml
kubectl delete --filename .\KubernetesConfiguration\Yamls\configuration-configmap-filelike.yaml

# Create Secret
kubectl apply --filename .\KubernetesConfiguration\Yamls\configuration-secret.yaml
# Create Pod using Secret
kubectl apply --filename .\KubernetesConfiguration\Yamls\pod-with-secret.yaml
# Show environment variables
kubectl logs pods/web-app-secret
# Cleanup
kubectl delete --filename .\KubernetesConfiguration\Yamls\pod-with-secret.yaml
kubectl delete --filename .\KubernetesConfiguration\Yamls\configuration-secret.yaml
