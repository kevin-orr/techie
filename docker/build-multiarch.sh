#!/bin/bash


# Usage: ./build-multiarch.sh <image-name> [tag]

# Example: ./build-multiarch.sh myrepo/myapp v1.0.0
 

# Exit immediately if any command fails
set -e
 
# Takes the 1st argument passed to the script (the Docker image name).
IMAGE_NAME="$1"

# Takes the 2nd argument as the image tag. If no tag is provided, it defaults to latest.
TAG="${2:-latest}"

# Checks if `IMAGE_NAME` is empty (`-z` = “is zero length?”).
if [ -z "$IMAGE_NAME" ]; then

  echo "Usage: $0 <image-name> [tag]"
  exit 1

fi
 

ARCHS=("amd64" "arm64")
 

# Build and push images for each architecture

# loop through each architecture type
for ARCH in "${ARCHS[@]}"; do

  echo "Building image for $ARCH..."

  docker buildx build --platform "linux/$ARCH" -t "${IMAGE_NAME}:${TAG}-$ARCH" --load .

  echo "Pushing image ${IMAGE_NAME}:${TAG}-$ARCH..."

  docker push "${IMAGE_NAME}:${TAG}-$ARCH"

done
 

# Create and annotate manifest

echo "Creating multi-arch manifest ${IMAGE_NAME}:${TAG}..."

docker manifest create "${IMAGE_NAME}:${TAG}" \

  "${IMAGE_NAME}:${TAG}-amd64" \

  "${IMAGE_NAME}:${TAG}-arm64"

 

for ARCH in "${ARCHS[@]}"; do

  docker manifest annotate "${IMAGE_NAME}:${TAG}" "${IMAGE_NAME}:${TAG}-$ARCH" --arch "$ARCH"

done

 

# Push the manifest

echo "Pushing manifest ${IMAGE_NAME}:${TAG}..."

docker manifest push "${IMAGE_NAME}:${TAG}"

 

echo "Multi-arch image ${IMAGE_NAME}:${TAG} created and pushed successfully."

 