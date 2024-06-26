$repoPath = 'your\repo\path'

# Run app using Docker file 
Set-Location $repoPath
docker build --rm --pull --tag docker-run-app:v1 --file dockerfile .
docker run --rm --detach --name docker-run-app --publish 5000:5000/tcp docker-run-app:v1

docker images 
docker ps

docker stop docker-run-app

# Run app with volume to store data
Set-Location $repoPath
docker volume create docker-run-app-volume
docker run --rm --detach --name docker-run-app --publish 5000:5000/tcp -v docker-run-app-volume:/app/data docker-run-app:v1

# Remove all previous created objects
docker stop docker-run-app
docker volume rm docker-run-app-volume
docker rmi docker-run-app:v1

# Run app usin Docker compose file
Set-Location $repoPath
docker volume create docker-run-app-volume

docker compose -f docker-compose.yaml -p docker-run-app-compose up --detach
docker compose -p docker-run-app-compose down

docker volume rm docker-run-app-volume

# Excersise with volume 
Set-Location $repoPath
docker build --rm --pull --tag docker-run-app:v1 --file dockerfile .

docker run --rm --detach --name docker-run-app --publish 5000:5000/tcp docker-run-app:v1
docker stop docker-run-app

docker run --rm --detach --name docker-run-app --publish 5000:5000/tcp docker-run-app:v1
docker stop docker-run-app

docker volume create docker-run-app-volume
docker run --rm --detach --name docker-run-app --publish 5000:5000/tcp -v docker-run-app-volume:/app/data docker-run-app:v1
docker stop docker-run-app

docker run --rm --detach --name docker-run-app --publish 5000:5000/tcp -v docker-run-app-volume:/app/data docker-run-app:v1
docker stop docker-run-app

docker volume rm docker-run-app-volume
docker rmi docker-run-app:v1

