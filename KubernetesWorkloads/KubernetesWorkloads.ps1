$repoPath = "your\repository\path"

# Set repo path
Set-Location $repoPath

# Create an image for the pod 
docker image build --rm --pull --tag docker-run-app:v1 --file dockerfile .
# Create the same image as before but with newer version 
docker image build --rm --pull --tag docker-run-app:v1.1 --file dockerfile .
docker image ls docker-run-app

# Create Deployment
kubectl apply --filename .\KubernetesWorkloads\Yamls\workload-deployment.yaml
# Check informations about pods, replicasets and deployments
kubectl get pods -o wide
kubectl get deployments
kubectl describe deployments
#Use service to check if web app is available
kubectl apply --filename .\KubernetesWorkloads\Yamls\service-node-port-for-deployment.yaml
Start-Process "http://localhost:32410/"


# Update Deployment
kubectl set image deployment/web-workload-deployment docker-run-app=docker-run-app:v1.1
# Check rollout status immediately to see updating status
kubectl rollout status --filename .\KubernetesWorkloads\Yamls\workload-deployment.yaml
# Update Deployment to previous version
kubectl set image deployment/web-workload-deployment docker-run-app=docker-run-app:v1
# Check rollout status immediately to see updating status
kubectl rollout status --filename .\KubernetesWorkloads\Yamls\workload-deployment.yaml

# Delete Deployment and Service
kubectl delete --filename .\KubernetesWorkloads\Yamls\workload-deployment.yaml
kubectl delete --filename .\KubernetesWorkloads\Yamls\service-node-port-for-deployment.yaml


# Create ReplicaSet
kubectl apply --filename .\KubernetesWorkloads\Yamls\workload-replicaset.yaml
# Look at informations about ReplicaSet
kubectl get pods -o wide
kubectl get rs
kubectl describe rs
# Delete ReplicaSet
kubectl delete --filename .\KubernetesWorkloads\Yamls\workload-replicaset.yaml


# Prepare service for Statefulset 
kubectl apply --filename .\KubernetesWorkloads\Yamls\service-node-port-for-statefulset.yaml
# Create Statefulset
kubectl apply --filename .\KubernetesWorkloads\Yamls\workload-statefulset.yaml
# Check that is Pod available 
kubectl get pods -o wide
# Here are Volume Claims created for each Pod 
kubectl get pvc
kubectl get statefulset 
kubectl get svc -o wide
# Check if application is available
Start-Process "http://localhost:32410/"
# As you can see there is new folder 'stats' provided by Volume Claim attached to StatefulSet
kubectl exec web-workload-statefulset-0 -it -- /bin/sh
ls
exit

# Delete Stateful
kubectl delete --filename .\KubernetesWorkloads\Yamls\workload-statefulset.yaml
kubectl delete --filename .\KubernetesWorkloads\Yamls\service-node-port-for-statefulset.yaml
# Deleting PVCs
kubectl delete pvc/stats-web-workload-statefulset-0
kubectl delete pvc/stats-web-workload-statefulset-1
kubectl delete pvc/stats-web-workload-statefulset-2


# Create Job  
kubectl apply --filename .\KubernetesWorkloads\Yamls\workload-job.yaml
# Check if Job exist
kubectl get jobs
# Check is Job completed
kubectl get pods -o wide
# Show message from busybox in job
kubectl logs jobs/web-workload-job
# Delete workload
kubectl delete --filename .\KubernetesWorkloads\Yamls\workload-job.yaml


# Create CronJob  
kubectl apply --filename .\KubernetesWorkloads\Yamls\workload-cronjob.yaml
# Check if the Cronjob exist
kubectl get cronjobs
# Check is job completed after 1 minute
kubectl get pods -o wide
# Show message from last runned pod from cronjob
kubectl logs $(kubectl get pods --no-headers --output name).Split([Environment]::NewLine)[-1]
# Delete workload
kubectl delete --filename .\KubernetesWorkloads\Yamls\workload-cronjob.yaml
