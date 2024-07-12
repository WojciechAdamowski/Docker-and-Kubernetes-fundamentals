# Kubernetes pods
![My Skills](https://skillicons.dev/icons?i=kubernetes,powershell)

In this section we will take a closer look at the:
1. [How to run web application using simple pod]()
2. [Pod with configured resources]()
3. [Pod with configured liveness]()
4. [Checking and cleaning]()

## Info
### Order 
In this section, we will focuse on how to run our web application using a kubernetes pods in different configurations. The configurations are as follows:
1. Simple pod with no special settings only a basic ones, including pod name, image name and port
2. Pod with resource constraints set
3. Pod with configured liveness 

At the end we will check all the pods and remove them to avoid cluttering

* If you are intresting in Powershell only, look at this [file](KubernetesPods.ps1)
* I only show necessary informations about the Kubernetes pods because there are plenty of articles on the web

### Brief information about Kubernetes 
* **What is Kubernetes** Kubernetes is an open source system for automating deployment, scaling and management of containerized applications. Using Kubernetes you can deploy, rollback and scale you applications in organized environment. More information in the [official documentation](https://kubernetes.io/)  
* **What is Kubernetes Node** Node is a virtual or physical machine. Kubernetes use nodes to run workload by placing containers into Pods. Each node is manageded by the control panel and contains the srvices to necessary to run Pods. More information in the [official documentation](https://kubernetes.io/docs/concepts/architecture/nodes/)   
* **What is Kubernetes Pod** Pod is smallest object in Kubernetes that you can create and manage. It is a group of one or more containers, with shared storage and network resources, and a specification for how to run the containers. More information in the [official documentation](https://kubernetes.io/docs/concepts/workloads/pods/)   
