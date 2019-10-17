#!/bin/bash
docker login 
docker build -t apache .
docker tag apache $1/apache
docker push $1/apache