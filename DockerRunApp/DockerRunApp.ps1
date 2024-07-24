$repoPath = 'your\repo\path'

# Run app using Docker file 
Set-Location $repoPath

# Create an image
docker image build --rm --pull --tag docker-run-app:v1 --file dockerfile .
# Create a container
docker container run --rm --detach --name docker-run-app --publish 5000:5000/tcp docker-run-app:v1
# Check that is image exist
docker image ls
docker image ls docker-run-app
# Check that is container exist
docker container ls
# Check that is application available and work fine
Start-Process http://localhost:5000
Start-Process http://localhost:5000/read
Start-Process http://localhost:5000/append
Start-Process http://localhost:5000/read
# Stop container 
docker container stop docker-run-app

# Run app with volume to store data
Set-Location $repoPath
# Create volume
docker volume create docker-run-app-volume
# Check that is volume exist
docker volume ls
# Create container
docker container run --rm --detach --name docker-run-app --publish 5000:5000/tcp --volume docker-run-app-volume:/app/data docker-run-app:v1
# Check that is application available and work fine
Start-Process http://localhost:5000
Start-Process http://localhost:5000/read
Start-Process http://localhost:5000/append
Start-Process http://localhost:5000/read
# Recreate container
docker container stop docker-run-app
docker container run --rm --detach --name docker-run-app --publish 5000:5000/tcp --volume docker-run-app-volume:/app/data docker-run-app:v1
# Checking existed messages
Start-Process http://localhost:5000/read
# Remove all previous created objects
docker container stop docker-run-app
docker volume rm docker-run-app-volume
docker image rm docker-run-app:v1

# Run app using Docker compose file
Set-Location $repoPath
# Create volume
docker volume create docker-run-app-volume
# Create container from compose file
docker compose --file docker-compose.yaml --project-name docker-run-app-compose up --detach
# Check that is image, container and app working fine
docker image ls docker-run-app
docker container ls
Start-Process http://localhost:5000
# Remove all previous created objects
docker compose --project-name docker-run-app-compose down
docker volume rm docker-run-app-volume
docker image rm docker-run-app:v1

