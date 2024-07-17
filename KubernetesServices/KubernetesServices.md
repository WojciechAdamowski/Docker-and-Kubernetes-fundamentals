# Kubernetes services
![My Skills](https://skillicons.dev/icons?i=kubernetes,powershell)

In this section we will tak a closer look at the:
1. [Run the service to provide communication between pods](#step-1---run-the-service-to-provide-communication-between-pods)
2. [Run the service to expose the pod](#step-2---run-the-service-to-expose-the-pod)

## Info 
### Order 

In this section we will focus on how to use the services to expose pods to each other and to the outside. 
* If you are intresting in Powershell only, look at this [file](KubernetesServices.ps1)
* I only show necessary informations about the Kubernetes services because there are plenty of articles on the web

### Kubernetes services
* **What is Kubernetes service?** Services are objects used to expose network communication to cluster pods. More information in the [official documentation](https://kubernetes.io/docs/concepts/services-networking/service/)
* **What is ClusterIP service?** ClusterIP is a type of service which expose communication between pods in the cluster. More information in the [official documentation](https://kubernetes.io/docs/concepts/services-networking/service/#type-clusterip)
* **What is NodePort service?** NodePort is a type of service that exposes a pod to the outside. More information in the [official documentation](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport)

<details>
<summary> Kubernetes commands - official documentation for every command used in this section </summary>

* [kubectl exec](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_exec/)
* [kubectl apply](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_apply/)
* [kubectl get](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_get/)
* [kubectl delete](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_delete/)

</details>

## Steps

### Step 1 - Run the service to provide communication between pods

1. Open the directory where is the repository

```powershell
Set-Location "your\repository\path"

# RETURNS: null
```

2. Create the Docker image which Pod will use to create containers

```powershell
docker image build --rm --pull --tag docker-run-app:v1 --file dockerfile .

# RETURNS: Informations about building process
```

3. Check if our image exists

```powershell
docker image ls docker-run-app

# RETURNS:
# REPOSITORY       TAG       IMAGE ID       CREATED        SIZE
# docker-run-app   v1        4cc7737f1883   15 hours ago   167MB

# INFO: Image properties
```

4. Create major web app pod

```powershell
kubectl apply --filename .\KubernetesServices\Yamls\pod.yaml

# RETURNS: Information about creating a Pod
```

5. Create a pod used to check if communication between pods exist. To check the communication we will use the busybox image.

```powershell
kubectl apply --filename .\KubernetesServices\Yamls\pod-busybox.yaml

# RETURNS: Information about creating a Pod
```

6. Check that are our pods exist

```powershell
kubectl get pods -o wide 

# RETURNS:
# NAME                           READY   STATUS    RESTARTS   AGE   IP          NODE             NOMINATED NODE   READINESS GATES
# web-app-for-services           1/1     Running   0          40s   10.1.0.77   docker-desktop   <none>           <none>
# web-app-for-services-busybox   1/1     Running   0          21s   10.1.0.78   docker-desktop   <none>           <none>
```

7. Create ClusterIP service
```powershell
kubectl apply --filename .\KubernetesServices\Yamls\service-cluster-ip.yaml

# RETURNS: Information about creating a Service
```

8. Check that is service exist. As you can notice there is another service provided by kubernetes
```powershell
kubectl get svc -o wide

# RETURNS:
# NAME                     TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)   AGE   SELECTOR
# kubernetes               ClusterIP   10.96.0.1        <none>        443/TCP   25d   <none>
# web-service-cluster-ip   ClusterIP   10.101.123.229   <none>        80/TCP    58s   name=web-app-for-services
```

9. Let's run shell inside busybox pod
```powershell
kubectl exec web-app-for-services-busybox -it -- /bin/sh

# RETURN: / # 
# INFO: Now we are in shell
```

10. Now using busybox pod check connection to web app pod and exit pod shell
```powershell
wget -qO- http://web-service-cluster-ip:80
exit

# RETURNS: Flask project ver. 1
```

11. Delete the unnecessary objects
```powershell
kubectl delete --filename .\KubernetesServices\Yamls\service-cluster-ip.yaml
kubectl delete --filename .\KubernetesServices\Yamls\pod-busybox.yaml

# RETURNS: Informations about deleting pod and service
```

### Step 2 - Run the service to expose the pod

1. Create NodePort service
```powershell
kubectl apply --filename .\KubernetesServices\Yamls\service-node-port.yaml

# RETURNS: Information about creating a Service
```

2. Check that is service exist
```powershell
kubectl get svc -o wide

# RETURNS:
# NAME                    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE   SELECTOR
# kubernetes              ClusterIP   10.96.0.1       <none>        443/TCP        25d   <none>
# web-service-node-port   NodePort    10.99.140.181   <none>        80:32410/TCP   4s    name=web-app-for-services
```

3. Check if appliaction is available
```powershell
Start-Process "http://localhost:32410/"

# RETURNS: Open browser
```

4. Delete the unnecessary objects
```powershell
kubectl delete --filename .\KubernetesServices\Yamls\service-node-port.yaml
kubectl delete --filename .\KubernetesServices\Yamls\pod.yaml
docker image rm docker-run-app:v1

# RETURNS: Informations about deleting pod, service and image
```