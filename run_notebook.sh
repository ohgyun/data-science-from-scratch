#!/bin/bash
container_name=data-science-from-scratch
image_repository=jupyter/datascience-notebook
host_port=9999

if [[ -n $(docker ps -q -f name=${container_name}) ]]; then
    echo "Container is already running"
elif [[ -n $(docker ps -aq -f name=${container_name}) ]]; then
    echo "Restart container"
    docker restart $container_name
else
    echo "Create and run new container"
    docker run -d \
        -p $host_port:8888 \
        --name $container_name \
        -v $(pwd)/notebooks:/home/jovyan/work \
        -v $(pwd)/data:/home/jovyan/data \
        $image_repository
fi

sleep 1
open http://localhost:$host_port