# Kubernetes volumes
![My Skills](https://skillicons.dev/icons?i=kubernetes,powershell)

In this section we will tak a closer look at the:
1. [Create Volume from file and attach Pod to it](#step-1---create-volume-from-file-and-attach-pod-to-it)
2. [Recreate Pod and check storing data](#step-2---recreate-pod-and-check-storing-data)

## Info 
### Order 

In this section we will focus on how to use the Volumes to store data for Pods. 
* If you are intresting in Powershell only, look at this [file](KubernetesVolumes.ps1)
* I only show necessary informations about the Kubernetes services because there are plenty of articles on the web

### Kubernetes volumes
* **What is Kubernetes volume?** A volume is a place where we can store data from running containers, because containers only save their data for their lifetime, after that all of it is lost. More information in the [official documentation](https://kubernetes.io/docs/concepts/storage/volumes/)
* **Which Volume we will focus on?** In this section we focus on the Persistent Volume, because it is piece of the storage in the cluster. It provide storing space in Pods by creating folders which we can use. There are other types of Volumes like: Projected Volumes and Ephemeral Volumes. More information in the [official documentation](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
* **What we need to attach Persistent Volume to Pod?** To attach Volume to Pod we will need Persistent Volume Claim. It is request for storage by a user running the Pod. More information in the [official documentation](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims)

<details>
<summary> Kubernetes commands - official documentation for every command used in this section </summary>

* [kubectl apply](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_apply/)
* [kubectl get](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_get/)
* [kubectl delete](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_delete/)

</details>

## Steps
### Step 1 - Create Volume from file and attach Pod to it

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
# REPOSITORY       TAG       IMAGE ID       CREATED      SIZE
# docker-run-app   v1        9e9debb3d1e9   2 days ago   166MB

# INFO: Image properties
```

4. Create Volume 
```powershell
kubectl apply --filename .\KubernetesVolumes\Yamls\volume-persistent.yaml

# RETURNS: persistentvolume/web-app-volume created
```

5. Create Volume Claim
```powershell
kubectl apply --filename .\KubernetesVolumes\Yamls\volume-persistent-claim.yaml

# RETURNS: persistentvolumeclaim/web-app-volume-claim created
```

6. Create Service for entering Pod
```powershell
kubectl apply --filename .\KubernetesVolumes\Yamls\service-node-port.yaml

# RETURNS: service/web-service-node-port created
```

7. Create Pod connected to Volume Claim
```powershell
kubectl apply --filename .\KubernetesVolumes\Yamls\pod-with-volume.yaml

# RETURNS: pod/web-app-for-volumes created
```

8. Wait few seconds and check that is web app available 
```powershell
Start-Process "http://localhost:32410/"

# RETURNS: null
```

9. Read content, add some messages to it and read it again. Now this content is storing in Volume not in the Pod.
```powershell
Start-Process "http://localhost:32410/read"
Start-Process "http://localhost:32410/append"
Start-Process "http://localhost:32410/read"

# RETURNS: null
```

10. Check if Volume and Claim are fine. Firstly check Volume
```powershell
kubectl get pv

# RETURNS: 
# NAME             CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                          STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
# web-app-volume   10Mi       RWO            Retain           Bound    default/web-app-volume-claim   ssd            <unset>                          8m38s
```

11. Check Volume Claim
```powershell
kubectl get pvc

# RETURNS:
# NAME                   STATUS   VOLUME           CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
# web-app-volume-claim   Bound    web-app-volume   10Mi       RWO            ssd            <unset>                 2m
```

### Step 2 - Recreate Pod and check storing data

1. Recreate Pod attached to Volume
```powershell
kubectl delete --filename .\KubernetesVolumes\Yamls\pod-with-volume.yaml
kubectl apply --filename .\KubernetesVolumes\Yamls\pod-with-volume.yaml

# RETURNS: Informations about deleting and creating Pod
```

2. Check that is information still there. As you can see there is still a message because all data is now storing in the Volume
```powershell
Start-Process "http://localhost:32410/read"

# RETURNS: null
```

3. Cleanup
```powershell
kubectl delete --filename .\KubernetesVolumes\Yamls\pod-with-volume.yaml
kubectl delete --filename .\KubernetesVolumes\Yamls\service-node-port.yaml
kubectl delete --filename .\KubernetesVolumes\Yamls\volume-persistent-claim.yaml
kubectl delete --filename .\KubernetesVolumes\Yamls\volume-persistent.yaml

docker image rm docker-run-app:v1

# RETURNS: Informations about deleting
```