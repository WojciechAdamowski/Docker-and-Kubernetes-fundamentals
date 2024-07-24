# Kubernetes workloads
![My Skills](https://skillicons.dev/icons?i=kubernetes,powershell,bash)

In this section we will tak a closer look at the:
1. [How to create a Deployment and update it](#step-1---how-to-create-a-deployment-and-update-it)
2. [Creating a ReplicaSet for multiple Pods instantions](#step-2---creating-a-replicaset-for-multiple-pods-instantions)
3. [How to store application state by creating StatefulSet](#step-3---how-to-store-application-state-by-creating-statefulset)
4. [Creating a Job for one application run](#step-4---creating-a-job-for-one-application-run)
5. [Creating a CronJob for scheduled application run](#step-5---creating-a-cronjob-for-scheduled-application-run)

## Info 
### Order 

In this section we will focus on how to use the services to expose pods to each other and to the outside. 
* If you are intresting in Powershell only, look at this [file](KubernetesWorkloads.ps1)
* I only show necessary informations about the Kubernetes services because there are plenty of articles on the web

### Kubernetes Workloads
* **What is Workload?** It is application running on one or set of Kubernetes Pods. More information in the [official documentation](https://kubernetes.io/docs/concepts/workloads/)
* **What are the types of Workloads?** There are few types of Workloads, but we will focus on the following: 
    * Deployment - this is the way how you describe a desired state of the Pods. This type of Workload is used to tell the Deployment Controller what set of Pods we want to get. More information in the [official documentation](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
    * ReplicaSet - we can use it to maintain set of identical Pods. More information in the [official documentation](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/)
    * StatefulSet - this workload is created to store the State of the Pod in Persistent Volumes Claims created for each Pod. More information in the [official documentation](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)
    * Job - using this you can make a single or multiple run your Pod. More information in the [official documentation](https://kubernetes.io/docs/concepts/workloads/controllers/job/)
    * CronJob - you can use it to make a scheduled Pod which will run on a specific schedule. More information in the [official documentation](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/)

<details>
<summary> Kubernetes commands - official documentation for every command used in this section </summary>

* [kubectl apply](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_apply/)
* [kubectl get](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_get/)
* [kubectl delete](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_delete/)
* [kubectl describe](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_describe/)
* [kubectl set](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_set/)
* [kubectl rollout](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_rollout/)
* [kubectl exec](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_exec/)

</details>

## Steps
### Step 1 - How to create a Deployment and update it

1. Open the directory where is the repository

```powershell
Set-Location "your\repository\path"

# RETURNS: null
```

2. Create two Docker images which Pod will use to create containers

```powershell
docker image build --rm --pull --tag docker-run-app:v1 --file dockerfile .
docker image build --rm --pull --tag docker-run-app:v1.1 --file dockerfile .

# RETURNS: Informations about building process
```

3. Check if our image exists

```powershell
docker image ls docker-run-app

# RETURNS:
# REPOSITORY       TAG       IMAGE ID       CREATED      SIZE
# docker-run-app   v1        9e9debb3d1e9   2 days ago   166MB

# INFO: Image properties
```

4. Let's create a Deployment
```powershell
kubectl apply --filename .\KubernetesWorkloads\Yamls\workload-deployment.yaml

# RETURNS: Informations about creating
```

5. Check informations about deployment, notice that there are 5 created Pods
```powershell
kubectl get deployments

# RETURNS:
# NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
# web-workload-deployment   5/5     5            5           81s
```

6. Show deployment details
```powershell
kubectl describe deployments

# RETURNS: Deployment details
```

7. Get pods informations, as you can see there is 5 Pods
```powershell
kubectl get pods -o wide

# RETURNS: 
# NAME                                       READY   STATUS    RESTARTS   AGE     IP          NODE             NOMINATED NODE   READINESS GATES
# web-workload-deployment-6c76fb89c6-4n99x   1/1     Running   0          2m56s   10.1.1.92   docker-desktop   <none>           <none>
# web-workload-deployment-6c76fb89c6-chchr   1/1     Running   0          2m56s   10.1.1.94   docker-desktop   <none>           <none>
# web-workload-deployment-6c76fb89c6-m7h62   1/1     Running   0          2m56s   10.1.1.95   docker-desktop   <none>           <none>
# web-workload-deployment-6c76fb89c6-s4lxq   1/1     Running   0          2m56s   10.1.1.91   docker-desktop   <none>           <none>
# web-workload-deployment-6c76fb89c6-wtq2x   1/1     Running   0          2m56s   10.1.1.93   docker-desktop   <none>           <none>
```

8. Use service to check if web app is available
```powershell
kubectl apply --filename .\KubernetesWorkloads\Yamls\service-node-port-for-deployment.yaml
Start-Process "http://localhost:32410/"

# RETURNS: null
```

9. Update Deployment. Run this two commands simultaneously to see how Deployment is updating
```powershell
kubectl set image deployment/web-workload-deployment docker-run-app=docker-run-app:v1.1
kubectl rollout status --filename .\KubernetesWorkloads\Yamls\workload-deployment.yaml

# RETURNS: 
# Waiting for deployment "web-workload-deployment" rollout to finish: 1 old replicas are pending termination...
# Waiting for deployment "web-workload-deployment" rollout to finish: 1 old replicas are pending termination...
# Waiting for deployment "web-workload-deployment" rollout to finish: 1 old replicas are pending termination...
# Waiting for deployment "web-workload-deployment" rollout to finish: 2 of 5 updated replicas are available...
# Waiting for deployment "web-workload-deployment" rollout to finish: 3 of 5 updated replicas are available...
# Waiting for deployment "web-workload-deployment" rollout to finish: 4 of 5 updated replicas are available...
# deployment "web-workload-deployment" successfully rolled out
```

10. Let's rollback it to previous version
```powershell
kubectl set image deployment/web-workload-deployment docker-run-app=docker-run-app:v1
kubectl rollout status --filename .\KubernetesWorkloads\Yamls\workload-deployment.yaml

# RETURNS: 
# Waiting for deployment "web-workload-deployment" rollout to finish: 1 old replicas are pending termination...
# Waiting for deployment "web-workload-deployment" rollout to finish: 1 old replicas are pending termination...
# Waiting for deployment "web-workload-deployment" rollout to finish: 1 old replicas are pending termination...
# Waiting for deployment "web-workload-deployment" rollout to finish: 2 of 5 updated replicas are available...
# Waiting for deployment "web-workload-deployment" rollout to finish: 3 of 5 updated replicas are available...
# Waiting for deployment "web-workload-deployment" rollout to finish: 4 of 5 updated replicas are available...
# deployment "web-workload-deployment" successfully rolled out
```

11. Cleanup
```powershell
kubectl delete --filename .\KubernetesWorkloads\Yamls\workload-deployment.yaml
kubectl delete --filename .\KubernetesWorkloads\Yamls\service-node-port-for-deployment.yaml

docker image rm docker-run-app:v1.1

# RETURNS: Information about deleting process
```

### Step 2 - Creating a ReplicaSet for multiple Pods instantions

1. Create ReplicaSet 
```powershell
kubectl apply --filename .\KubernetesWorkloads\Yamls\workload-replicaset.yaml

# RETURNS: replicaset.apps/web-workload-replicaset created
```

2. Check number of the Pods, there should be 3 of them
```powershell
kubectl get pods -o wide

# RETURNS: 
# NAME                            READY   STATUS    RESTARTS   AGE   IP           NODE             NOMINATED NODE   READINESS GATES
# web-workload-replicaset-cs2s5   1/1     Running   0          32s   10.1.1.106   docker-desktop   <none>           <none>
# web-workload-replicaset-g4p5g   1/1     Running   0          32s   10.1.1.107   docker-desktop   <none>           <none>
# web-workload-replicaset-gm6ln   1/1     Running   0          32s   10.1.1.105   docker-desktop   <none>           <none>
```

3. Check ReplicaSet, here you can see status of the Pods
```powershell
kubectl get rs

# RETURNS: 
# NAME                      DESIRED   CURRENT   READY   AGE  
# web-workload-replicaset   3         3         3       4m28s
```

4. Additionally you can show some ReplicaSet details
```powershell
kubectl describe rs

# RETURNS: ReplicaSet details
```

5. Cleanup
```powershell
kubectl delete --filename .\KubernetesWorkloads\Yamls\workload-replicaset.yaml

# RETURNS: replicaset.apps "web-workload-replicaset" deleted
```

### Step 3 - How to store application state by creating StatefulSet

1. Prepare Service for StatefulSet 
```powershell
kubectl apply --filename .\KubernetesWorkloads\Yamls\service-node-port-for-statefulset.yaml

# RETURNS: service/web-service-node-port-for-statefulset created
```

2. Create StatefulSet
```powershell
kubectl apply --filename .\KubernetesWorkloads\Yamls\workload-statefulset.yaml

# RETURNS: statefulset.apps/web-workload-statefulset created
```

3. Check available Pods, you can see lower count than you expected because StatefulSet creates Persistant Volume Claims for each Pod and it is takes time
```powershell
kubectl get pods -o wide

# RETURNS: 
# NAME                         READY   STATUS    RESTARTS   AGE     IP           NODE             NOMINATED NODE   READINESS GATES
# web-workload-statefulset-0   1/1     Running   0          2m46s   10.1.1.108   docker-desktop   <none>           <none>
# web-workload-statefulset-1   1/1     Running   0          2m26s   10.1.1.109   docker-desktop   <none>           <none>
# web-workload-statefulset-2   1/1     Running   0          2m6s    10.1.1.110   docker-desktop   <none>           <none>
```

4. Here are Volume Claims created for each Pod 
```powershell
kubectl get pvc

# RETURNS: 
# NAME                               STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
# stats-web-workload-statefulset-0   Bound    pvc-147f9edb-44f7-40bd-90e4-271c34865bce   5Mi        RWO            hostpath       <unset>                 3m20s
# stats-web-workload-statefulset-1   Bound    pvc-d6888c7d-ce4d-43ae-ad24-03b04c75c5a6   5Mi        RWO            hostpath       <unset>                 3m
# stats-web-workload-statefulset-2   Bound    pvc-95cc61d4-4c45-425a-9d79-c5aa1fe8c640   5Mi        RWO            hostpath       <unset>                 2m40s
```

5. Check status of the StatefulSet
```powershell
kubectl get statefulset

# RETURNS: 
# NAME                       READY   AGE
# web-workload-statefulset   3/3     3m32s
```

6. Check that is application available
```powershell
Start-Process "http://localhost:32410/"

# RETURNS: Open browser
```

7. Run shell inside one of the Pod
```powershell
kubectl exec web-workload-statefulset-0 -it -- /bin/sh

# RETURNS: Open shell inside Pod
```

8. List all files and folders. Notice that there is our "stats" folder created by Persistent Volume Claim

```bash
ls
exit

# RETURNS: app.py  data  requirements.txt  stats  venv
```

9. Cleanup
```powershell
kubectl delete --filename .\KubernetesWorkloads\Yamls\workload-statefulset.yaml
kubectl delete --filename .\KubernetesWorkloads\Yamls\service-node-port-for-statefulset.yaml

kubectl delete pvc/stats-web-workload-statefulset-0
kubectl delete pvc/stats-web-workload-statefulset-1
kubectl delete pvc/stats-web-workload-statefulset-2

# RETURNS: Informations about deleting process
```

### Step 4 - Creating a Job for one application run

1. Create Job
```powershell
kubectl apply --filename .\KubernetesWorkloads\Yamls\workload-job.yaml

# RETURNS: job.batch/web-workload-job created
```

2. Check Job status
```powershell
kubectl get jobs

# RETURNS:
# NAME               COMPLETIONS   DURATION   AGE
# web-workload-job   1/1           5s         52s
```

3. Check status of the Pods

```powershell
kubectl get pods -o wide

# RETURNS:
# NAME                     READY   STATUS      RESTARTS   AGE   IP           NODE             NOMINATED NODE   READINESS GATES
# web-workload-job-bqqfp   0/1     Completed   0          71s   10.1.1.111   docker-desktop   <none>           <none>
```

4. Show message from busybox in Job

```powershell
kubectl logs jobs/web-workload-job

# RETURNS: Hello from the job
```

5. Cleanup

```powershell
kubectl delete --filename .\KubernetesWorkloads\Yamls\workload-job.yaml

# RETURNS: job.batch "web-workload-job" deleted
```

### Step 5 - Creating a CronJob for scheduled application run

1. Create CronJob that run every minute

```powershell
kubectl apply --filename .\KubernetesWorkloads\Yamls\workload-cronjob.yaml

# RETURNS: cronjob.batch/web-workload-cronjob created
```

2. Check if the CronJob exist and details
```powershell
kubectl get cronjobs

# RETURNS:
# NAME                   SCHEDULE    SUSPEND   ACTIVE   LAST SCHEDULE   AGE
# web-workload-cronjob   * * * * *   False     0        16s             98s
```

3. Get all the Pods created by the CronJob and them status 
```powershell
kubectl get pods -o wide

# RETURNS: 
# NAME                                  READY   STATUS      RESTARTS   AGE     IP           NODE             NOMINATED NODE   READINESS GATES
# web-workload-cronjob-28695258-286d7   0/1     Completed   0          2m11s   10.1.1.112   docker-desktop   <none>           <none>
# web-workload-cronjob-28695259-7578k   0/1     Completed   0          71s     10.1.1.113   docker-desktop   <none>           <none>
# web-workload-cronjob-28695260-cjf4d   0/1     Completed   0          11s     10.1.1.114   docker-desktop   <none>           <none>
```

4. Show logs from last CronJob execution
```powershell
kubectl logs $(kubectl get pods --no-headers --output name).Split([Environment]::NewLine)[-1]

# RETURNS: Hello from the cronjob
```

5. Cleanup
```powershell
kubectl delete --filename .\KubernetesWorkloads\Yamls\workload-cronjob.yaml

# RETURNS: cronjob.batch "web-workload-cronjob" deleted
```






