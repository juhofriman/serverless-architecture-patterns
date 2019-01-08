#! /bin/bash

set -e

IMAGE_NAME=serverless-architectures-local-runner
CONTAINER_NAME=serverless-architectures-jekyll-site

if [[ "$1" == "--nuke" ]]; then
  echo "Nuking container and image ..."
  docker rm -f $CONTAINER_NAME
  docker rmi $IMAGE_NAME
fi

if [[ "$(docker images -q $IMAGE_NAME:latest 2> /dev/null)" == "" ]]; then
  echo "Image does not exist, building it ..."
  docker build -t $IMAGE_NAME:latest .
fi

if [ ! $(docker ps -a -q -f "name=$CONTAINER_NAME") ]; then
  echo "Container does not exists, creating it"
  docker run --name $CONTAINER_NAME -it -p 4000:4000 -v `pwd`:/site $IMAGE_NAME:latest
else
  echo "Starting already initialised container"
  docker start -i $CONTAINER_NAME
fi