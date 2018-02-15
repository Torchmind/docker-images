#!/bin/bash
for dockerFile in `find . -name "Dockerfile"`; do
  # First of all, we'll have to build the actual image name based on our path
  DIRECTORY_NAME=`dirname $dockerFile`
  PATH_ELEMENTS=$(echo $DIRECTORY_NAME | tr "/" " ")
  PATH_ELEMENTS=${PATH_ELEMENTS[@]:1}

  IMAGE_NAME=""
  VERSION_NUMBER=""

  for element in $PATH_ELEMENTS; do
    if [ ! -z "$VERSION_NUMBER" ]; then
      if [ -z "$IMAGE_NAME" ]; then
        IMAGE_NAME="$VERSION_NUMBER"
      else
        IMAGE_NAME="$IMAGE_NAME-$VERSION_NUMBER"
      fi
    fi

    VERSION_NUMBER=$element
  done

  echo "Building $IMAGE_NAME:$VERSION_NUMBER ..."
  docker build -t torchmind/$IMAGE_NAME:$VERSION_NUMBER $DIRECTORY_NAME
  echo "Successfully built image"

  if [ "$1" == "deploy" ]; then
    echo "Publishing $IMAGE_NAME:$VERSION_NUMER"
    docker push torchmind/$IMAGE_NAME:$VERSION_NUMBER
    echo "Successfully deployed image"
  fi
done
