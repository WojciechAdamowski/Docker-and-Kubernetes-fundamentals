# Step 1 - Checking all instalations
<# 1. #> python --version
<# 2. #> docker --version
<# 3. #> kubectl version --client

# Step 2 - Create the virtual environment for app
Set-Location "your\repository\path"
Set-Location "WebApp\App"
python -m venv venv
.\venv\Scripts\activate
pip install -r requirements.txt
pip list
deactivate

# Step 3 - The raw startup of web application
Set-Location "your\repository\path"
Set-Location "WebApp\App"
.\venv\Scripts\activate
python app.py
deactivate
