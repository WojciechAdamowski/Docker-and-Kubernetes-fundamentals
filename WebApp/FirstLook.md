<!-- TODO: Add other steps -->
<!-- TODO: Think about notebook structure -->
<!-- TODO: Test all of the steps -->
<!-- TODO: Copy code to the file -->
<!-- TODO: Try to make links to sections -->

# First look
In this section we will take a closer look at the:
1. Checking all instalations
2. Create the virtual environment for Python
3. The raw startup of web applications

## Info
* I hope you installed everything from the **What do you need?** section
* If you are only interested in the powershell code, you can find it [here](FirstLook.ps1)

## Steps
### Step 1 - Checking all instalations

1. Check is Python installed 

```powershell
python --version

# RETURNS: Python 3.11.8
```

2. Check is Docker installed

```powershell
docker --version

# RETURNS: Docker version 25.0.3, build 4debf41
```

3. Check is Kubernetes installed

```powershell
kubectl version --client

# RETURNS: Kustomize Version: v5.0.4-0.20230601165947-6ce0bf390ce3
```

### Step 2 - Create the virtual environment for Python

1. Go to your App folder location in repository e.g. "Docker-and-Kubernetes-fundamentals\WebApp\App"

```powershell
Set-Location "Docker-and-Kubernetes-fundamentals\WebApp\App"

# RETURNS: null
# INFO: We change directory where we are running powershell commands
```

2. We create virtual environment for python (venv)

```powershell
python -m venv venv

# RETURNS: null
# INFO: You can notice it created a new folder called venv
```

3. Switch to venv environment

```powershell
.\venv\Scripts\activate

# RETURNS: null
# INFO: You can notice there is (venv) mark in your terminal
```

4. Now install all necessary libraries from the [requirements file](App/requirements.txt)

```powershell
pip install -r requirements.txt

# RETURNS: Collecting and installing libraries
```

5. Fast look at the list of libraries

```powershell
pip list

# RETURNS: List of libraries
```

6. Exit from venv

```powershell
deactivate

# RETURNS: null
# INFO: As you can see there is no more mark (venv) in your terminal
```