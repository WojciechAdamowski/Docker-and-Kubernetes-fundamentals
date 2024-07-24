# Kubernetes pods
![My Skills](https://skillicons.dev/icons?i=kubernetes,powershell)

In this section we will take a closer look at the:
1. [How to run web application using simple pod](#step-1---how-to-run-web-application-using-simple-pod)
2. [Pod with configured resources](#step-2---pod-with-configured-resources)
3. [Pod with configured liveness](#step-3---pod-with-configured-liveness)
4. [Pod with configured security context](#step-4---pod-with-configured-security-context)
5. [Pod with configured init container](#step-5---pod-with-configured-init-container)
6. [Checking and cleaning](#step-6---checking-and-cleaning)

## Info
### Order 
In this section, we will focus on how to run our web application using a kubernetes pods in different configurations. The configurations are as follows:
1. Simple pod with no special settings only a basic ones, including pod name, image name and port
2. Pod with resource constraints set
3. Pod with configured liveness 

At the end we will check all the pods and remove them to avoid cluttering

* If you are intresting in Powershell only, look at this [file](KubernetesPods.ps1)
* I only show necessary informations about the Kubernetes pods because there are plenty of articles on the web

### Kubernetes 
* **What is Kubernetes?** Kubernetes is an open source system for automating deployment, scaling and management of containerized applications. Using Kubernetes you can deploy, rollback and scale you applications in organized environment. More information in the [official documentation](https://kubernetes.io/)  
* **What is Kubernetes Node?** Node is a virtual or physical machine. Kubernetes use nodes to run workload by placing containers into Pods. Each node is manageded by the control panel and contains the srvices to necessary to run Pods. More information in the [official documentation](https://kubernetes.io/docs/concepts/architecture/nodes/)   
* **What is Kubernetes Pod?** Pod is smallest object in Kubernetes that you can create and manage. It is a group of one or more containers, with shared storage and network resources, and a specification for how to run the containers. More information in the [official documentation](https://kubernetes.io/docs/concepts/workloads/pods/)

<details>
<summary> Kubernetes commands - official documentation for every command used in this section </summary>

* [kubectl apply](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_apply/)
* [kubectl describe](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_describe/)
* [kubectl logs](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_logs/)
* [kubectl get](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_get/)
* [kubectl delete](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_delete/)

</details>

## Steps

### Step 1 - How to run web application using simple pod

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

4. Now let's create a Pod

```powershell
kubectl apply --filename .\KubernetesPods\Yamls\pod.yaml

# RETURNS: Information about creating a Pod
```

5. Show some details of the Pod

```powershell
kubectl describe pod web-app 

# RETURNS: Information about the Pod
```

### Step 2 - Pod with configured resources

1. Create Pod with defined resources from the same image

```powershell
kubectl apply --filename .\KubernetesPods\Yamls\pod-with-resources.yaml

# RETURNS: Information about creating a Pod
```

2. Check if there is created Pod

```powershell
kubectl describe pod web-app-with-resources

# RETURNS: Information about the Pod
```

### Step 3 - Pod with configured liveness

1. Create Pod with defined liveness from the same image

```powershell
kubectl apply --filename .\KubernetesPods\Yamls\pod-with-liveness.yaml

# RETURNS: Information about creating a Pod
```

2. Check if there is created Pod

```powershell
kubectl describe pod web-app-with-liveness

# RETURNS: Information about the Pod
```

### Step 4 - Pod with configured security context

1. Create Pod with defined security context from the same image

```powershell
kubectl apply --filename .\KubernetesPods\Yamls\pod-with-security-context.yaml

# RETURNS: pod/web-app-with-security-context created
```

2. Check if there is created Pod

```powershell
kubectl describe pod web-app-with-security-context

# RETURNS: Information about the Pod
```

### Step 5 - Pod with configured init container

1. Create Pod with defined init container from the same image

```powershell
kubectl apply --filename .\KubernetesPods\Yamls\pod-with-init-container.yaml

# RETURNS: pod/web-app-with-init-container created
```

2. Check if there is created Pod

```powershell
kubectl describe pod web-app-with-init-container

# RETURNS: Information about the Pod
```

### Step 6 - Checking and cleaning

1. Check if there are all the previous created Pods

```powershell
kubectl get pods -o wide 

# RETURNS: 
# NAME                     READY   STATUS    RESTARTS   AGE     IP          NODE             NOMINATED NODE   READINESS GATES
# web-app                  1/1     Running   0          30m     10.1.0.66   docker-desktop   <none>           <none>
# web-app-with-liveness    1/1     Running   0          5s      10.1.0.68   docker-desktop   <none>           <none>
# web-app-with-resources   1/1     Running   0          9m32s   10.1.0.67   docker-desktop   <none>           <none>
```

2. You can also check logs of the Pod

```powershell
kubectl logs web-app-with-liveness

# RETURNS: Logs of the Pod
```

3. Remove all objects to keep clarity

```powershell
kubectl delete --filename .\KubernetesPods\Yamls\pod.yaml
kubectl delete --filename .\KubernetesPods\Yamls\pod-with-resources.yaml
kubectl delete --filename .\KubernetesPods\Yamls\pod-with-liveness.yaml
kubectl delete --filename .\KubernetesPods\Yamls\pod-with-security-context.yaml
kubectl delete --filename .\KubernetesPods\Yamls\pod-with-init-container.yaml

docker image rm docker-run-app:v1

# RETURNS: Informations about deleting pods and image
```
