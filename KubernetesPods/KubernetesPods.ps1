$repoPath = "your\repository\path"

# Set repo path
Set-Location $repoPath

# Create image for pods 
docker image build --rm --pull --tag docker-run-app:v1 --file dockerfile .
docker image ls docker-run-app

# Create basic pod
kubectl apply --filename .\KubernetesPods\Yamls\pod.yaml
kubectl describe pod web-app 

# Create the pod with configured resources
kubectl apply --filename .\KubernetesPods\Yamls\pod-with-resources.yaml
kubectl describe pod web-app-with-resources

# Create the pod with configured liveness
kubectl apply --filename .\KubernetesPods\Yamls\pod-with-liveness.yaml
kubectl describe pod web-app-with-liveness

# Create the pod with configured security context
kubectl apply --filename .\KubernetesPods\Yamls\pod-with-security-context.yaml
kubectl describe pod web-app-with-security-context

# Create the pod with configured init container
kubectl apply --filename .\KubernetesPods\Yamls\pod-with-init-container.yaml
kubectl describe pod web-app-with-init-container

# Check that are every pod exist
kubectl get pods -o wide 
kubectl logs web-app-with-liveness
kubectl logs web-app-with-init-container --container init-my-container

# Delete all created objects for clarity
kubectl delete --filename .\KubernetesPods\Yamls\pod.yaml
kubectl delete --filename .\KubernetesPods\Yamls\pod-with-resources.yaml
kubectl delete --filename .\KubernetesPods\Yamls\pod-with-liveness.yaml
kubectl delete --filename .\KubernetesPods\Yamls\pod-with-security-context.yaml
kubectl delete --filename .\KubernetesPods\Yamls\pod-with-init-container.yaml

docker image rm docker-run-app:v1