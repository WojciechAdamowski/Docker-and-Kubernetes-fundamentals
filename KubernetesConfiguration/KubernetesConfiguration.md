# Kubernetes configuration
![My Skills](https://skillicons.dev/icons?i=kubernetes,powershell,bash)

In this section we will take a closer look at the:
1. [How to use ConfigMaps in the Pod]()
2. [Using ConfigMap in filelike style]()
3. [How to use Secrets in the Pod]()

## Info
### Order 

In this section we will focus on how to use the Configurations to set variables for the Pods but outside of them. There are several types of Configurations but we only focus on ConfigMap and Secrets. 
* If you are intresting in Powershell only, look at this [file](KubernetesConfiguration.ps1)
* I only show necessary informations about the Kubernetes services because there are plenty of articles on the web

### Kubernetes Configuration
* **What is ConfigMap?** ConfigMap is using for setting configuration data separately from application code. More information in the [official documentation](https://kubernetes.io/docs/concepts/configuration/configmap/)
* **What is Secrets?** Secrets are similar to ConfigMaps but are specifically intended to hold confidential data. More information in the [official documentation](https://kubernetes.io/docs/concepts/configuration/secret/)

<details>
<summary> Kubernetes commands - official documentation for every command used in this section </summary>

* [kubectl apply](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_apply/)
* [kubectl get](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_get/)
* [kubectl delete](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_delete/)

</details>

## Steps

### Step 1 - How to use ConfigMaps in the Pod

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
# docker-run-app   v1        9e9debb3d1e9   3 days ago   166MB

# INFO: Image properties
```

4. Create ConfigMap in propertylike style
```powershell
kubectl apply --filename .\KubernetesConfiguration\Yamls\configuration-configmap-propertylike.yaml

# RETURNS: configmap/web-configuration-configmap-propertylike created
```

5. Create Pod that uses propertylike style ConfigMap
```powershell
kubectl apply --filename .\KubernetesConfiguration\Yamls\pod-with-configmap-propertylike.yaml

# RETURNS: pod/web-app-configmap-propertylike created
```

6. Wait few seconds and show Pod logs which using environment variables from ConfigMap
```powershell
kubectl logs pods/web-app-configmap-propertylike

# RETURNS: USER_NAME: Peter - USER_LAST_NAME: Novac - USER_BIRTH_DATE: 10.05.1980
```

7. Cleanup
```powershell
kubectl delete --filename .\KubernetesConfiguration\Yamls\pod-with-configmap-propertylike.yaml
kubectl delete --filename .\KubernetesConfiguration\Yamls\configuration-configmap-propertylike.yaml

# RETURNS: Deleting informations
```

### Step 2 - Using ConfigMap in filelike style

1. Create ConfigMap in filelike style 
```powershell
kubectl apply --filename .\KubernetesConfiguration\Yamls\configuration-configmap-filelike.yaml

# RETURNS: configmap/web-configuration-configmap-filelike created
```

2. Create Pod that uses filelike style ConfigMap
```powershell
kubectl apply --filename .\KubernetesConfiguration\Yamls\pod-with-configmap-filelike.yaml

# RETURNS: pod/web-app-configmap-filelike created
```

3. Wait few seconds and show ConfigMap content from the file
```powershell
kubectl apply --filename .\KubernetesConfiguration\Yamls\pod-with-configmap-filelike.yaml

# RETURNS: 
# user.name=Peter
# user.lastname=Novac
# user.birthdate=10.05.1980
# user.family=Anna,Tom
```

4. Cleanup
```powershell
kubectl delete --filename .\KubernetesConfiguration\Yamls\pod-with-configmap-filelike.yaml
kubectl delete --filename .\KubernetesConfiguration\Yamls\configuration-configmap-filelike.yaml

# RETURNS: Deleting informations
```

### Step 3 - How to use Secrets in the Pod
1. Create Secret
```powershell
kubectl apply --filename .\KubernetesConfiguration\Yamls\configuration-secret.yaml

# RETURNS: secret/web-secret created
```

2. Create Pod that uses Secret
```powershell
kubectl apply --filename .\KubernetesConfiguration\Yamls\pod-with-secret.yaml

# RETURNS: secret/web-secret created
```

3. Wait few seconds and show enviroment variables from Secret
```powershell
kubectl logs pods/web-app-secret

# RETURNS: USERNAME: some_username - PASSWORD: some_password
```

4. Cleanup
```powershell
kubectl delete --filename .\KubernetesConfiguration\Yamls\pod-with-secret.yaml
kubectl delete --filename .\KubernetesConfiguration\Yamls\configuration-secret.yaml
docker image rm docker-run-app:v1

# RETURNS: Deleting informations
```



