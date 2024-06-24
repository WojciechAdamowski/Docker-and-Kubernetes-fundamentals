# First look
[![My Skills](https://skillicons.dev/icons?i=docker,kubernetes,python,powershell)](https://skillicons.dev)

In this section we will take a closer look at the:
1. [Docker and Kubernetes installation](#step-1---docker-and-kubernetes-installation)
2. [Python installation](#step-2---python-installation)
3. [Enable Powershell custom script running](#step-3---enable-powershell-custom-script-running)

## Info
In this section, we will focus on one of the possible ways to install the previously mentioned tools. Ofcourse you can install this tools on your own.

## Steps

### Step 1 - Docker and Kubernetes installation

1. Here are the [system requirements](https://docs.docker.com/desktop/install/windows-install/#system-requirements) for Docker:
    * Windows 11 64-bit: Home or Pro version 21H2 or higher, or Enterprise or Education version 21H2 or higher
    * WSL
    * Turning on WSL 2 feature

2. Launch Powershell terminal as administrator
    
3. Check is your Windows version correct

```powershell
Start-Process winver

# RETURNS: null
# INFO: It opens the Windows version information panel
```

4. Install WSL

```powershell
wsl --install

# RETURNS: A lot information about wsl installation
```

5. Enable Windows Subsystem for Linux

```powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

# RETURNS: Information about command results, nothing intresting for us
```

6. Let's start by downloading the Docker installer
    * [Windows installer](https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-win-amd64)
    * [All downloads](https://docs.docker.com/get-docker/)

7. Run Docker installer (if some error occur restart your PC)

8. Run Docker Desktop

9. Accept all terms

10. And you have installed Docker on you computer. Yay! But...

11. We have to install Kubernetes too, so lets move to the settings and select the _Enable Kubernetes_ option 

![kubernetes_installation](images\kubernetes_installation.png)

12. Click install button

13. Wait until it installs

### Step 2 - Python installation

1. Download Python installer 
    * [Windows installer](https://www.python.org/ftp/python/3.12.4/python-3.12.4-amd64.exe)
    * [All downloads](https://www.python.org/downloads/)

2. Launch installer 

3. Check _Add python.exe to PATH_ option

![python_installation](images\python_installation.png)

4. Click install now button

5. Wait until it installs

6. Restart your PC

### Step 3 - Enable Powershell custom script running

1. Launch Powershell terminal as administrator

2. Run command, and write Y to confirm your decision

```powershell
Set-Executionpolicy remotesigned

# RETURNS: Info about consequences of the runned command
```