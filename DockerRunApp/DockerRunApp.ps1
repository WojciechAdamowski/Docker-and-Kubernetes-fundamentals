$repoPath = 'your\repo\path'

# Run app using Docker file 
Set-Location $repoPath
docker image build --rm --pull --tag docker-run-app:v1 --file dockerfile .
docker container run --rm --detach --name docker-run-app --publish 5000:5000/tcp docker-run-app:v1

docker image ls
docker image ls docker-run-app
docker container ls

Start-Process http://localhost:5000
Start-Process http://localhost:5000/read
Start-Process http://localhost:5000/append
Start-Process http://localhost:5000/read

docker container stop docker-run-app

# Run app with volume to store data
Set-Location $repoPath
docker volume create docker-run-app-volume
docker volume ls

docker container run --rm --detach --name docker-run-app --publish 5000:5000/tcp --volume docker-run-app-volume:/app/data docker-run-app:v1

Start-Process http://localhost:5000
Start-Process http://localhost:5000/read
Start-Process http://localhost:5000/append
Start-Process http://localhost:5000/read

# Checking existed messages
docker container stop docker-run-app
docker container run --rm --detach --name docker-run-app --publish 5000:5000/tcp --volume docker-run-app-volume:/app/data docker-run-app:v1

Start-Process http://localhost:5000/read

# Remove all previous created objects
docker container stop docker-run-app
docker volume rm docker-run-app-volume
docker image rm docker-run-app:v1

# Run app using Docker compose file
Set-Location $repoPath
docker volume create docker-run-app-volume

docker compose --file docker-compose.yaml --project-name docker-run-app-compose up --detach

docker image ls docker-run-app
docker container ls
Start-Process http://localhost:5000

docker compose --project-name docker-run-app-compose down
docker volume rm docker-run-app-volume
docker image rm docker-run-app:v1

