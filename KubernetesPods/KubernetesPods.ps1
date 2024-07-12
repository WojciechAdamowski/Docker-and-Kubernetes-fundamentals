$repoPath = 'your\repo\path'

# Run app using pod
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

# Check that are every pod exist
kubectl logs web-app-with-liveness
kubectl get pods -o wide 

# Delete all created objects for clarity
kubectl delete --filename .\KubernetesPods\Yamls\pod.yaml
kubectl delete --filename .\KubernetesPods\Yamls\pod-with-resources.yaml
kubectl delete --filename .\KubernetesPods\Yamls\pod-with-liveness.yaml

docker image rm docker-run-app:v1