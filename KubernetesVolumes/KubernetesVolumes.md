# Kubernetes volumes
![My Skills](https://skillicons.dev/icons?i=kubernetes,powershell)

In this section we will tak a closer look at the:
1. [Create Volume from file and attach Pod to it]()
2. [Recreate Pod and check storing data]()

## Info 
### Order 

In this section we will focus on how to use the services to expose pods to each other and to the outside. 
* If you are intresting in Powershell only, look at this [file](KubernetesVolumes.ps1)
* I only show necessary informations about the Kubernetes services because there are plenty of articles on the web

### Kubernetes volumes
* **What is Kubernetes volume?** A volume is a place where we can store data from running containers, because containers only save their data for their lifetime,after that all of it is lost. More information in the [official documentation](https://kubernetes.io/docs/concepts/storage/volumes/)
* **Which Volume we will focus on?** In this section we focus on the Persistent Volume, because it is piece of the storage in the cluster. It provide storing space in Pods by creating folders which we can use. There are other types of Volumes like: Projected Volumes and Ephemeral Volumes. More information in the [official documentation](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
* **What we need to attach Persistent Volume to Pod?** To attach Volume to Pod we will need Persistent Volume Claim. It is request for storage by a user running the Pod. More information in the [official documentation](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims)

<details>
<summary> Kubernetes commands - official documentation for every command used in this section </summary>

* [kubectl apply](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_apply/)
* [kubectl get](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_get/)
* [kubectl delete](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_delete/)

</details>