# First look
[![My Skills](https://skillicons.dev/icons?i=python,flask,powershell,vscode)](https://skillicons.dev)

In this section we will take a closer look at the:
1. [Checking all instalations](#step-1---checking-all-instalations)
2. [Create the virtual environment for App](#step-2---create-the-virtual-environment-for-app)
3. [The raw startup of web application](#step-3---the-raw-startup-of-web-application)

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

### Step 2 - Create the virtual environment for app

1. Go to your repo location (where you clone repo)

```powershell
Set-Location "your\repository\path"

# RETURNS: null
# INFO: We change directory where we are running powershell commands
```

2. Go to App folder location in repository e.g. "Docker-and-Kubernetes-fundamentals\WebApp\App"

```powershell
Set-Location "WebApp\App"

# RETURNS: null
# INFO: We change directory where we are running powershell commands
```

3. We create virtual environment for python (venv)

```powershell
python -m venv venv

# RETURNS: null
# INFO: You can notice it created a new folder called venv
```

4. Switch to venv environment

```powershell
.\venv\Scripts\activate

# RETURNS: null
# INFO: You can notice there is (venv) mark in your terminal
```

5. Now install all necessary libraries from the [requirements file](App/requirements.txt)

```powershell
pip install -r requirements.txt

# RETURNS: Collecting and installing libraries
```

6. Fast look at the list of libraries

```powershell
pip list

# RETURNS: List of libraries
```

7. Exit from venv

```powershell
deactivate

# RETURNS: null
# INFO: As you can see there is no more mark (venv) in your terminal

```

## Step 3 - The raw startup of web application

1. Go to your repo location (where you clone repo)

```powershell
Set-Location "your\repository\path"

# RETURNS: null
# INFO: We change directory where we are running powershell commands
```

2. Go to App folder location in repository e.g. "Docker-and-Kubernetes-fundamentals\WebApp\App"

```powershell
Set-Location "WebApp\App"

# RETURNS: null
# INFO: We change directory where we are running powershell commands
```

3. Switch to venv environment

```powershell
.\venv\Scripts\activate

# RETURNS: null
# INFO: You can notice there is (venv) mark in your terminal
```

4. Take a quick look at the [application](App/app.py) to know what are you running

5. Run app using Python

```powershell
python app.py

# RETURNS: Information about running app in Flask
```

6. Check running application at http://127.0.0.1:5000 address, browser should display ```Flask project ver. 1```

7. If everything looks fine stop application by ```Ctrl + C``` in terminal

8. Exit from venv

```powershell
deactivate

# RETURNS: null
# INFO: As you can see there is no more mark (venv) in your terminal
```