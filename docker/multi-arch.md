A very simple bash script to build then push `arm64` and `amd64` images to specified repo - could be artifactory or an ACR etc.


What does it do:
- Builds architecture-specific images for amd64 and arm64.
- Pushes them individually to the Docker registry.
- Creates and pushes a multi-architecture manifest so users can pull myrepo/myapp:latest and automatically get the right image for their CPU.



Remember to mark the script as executable


`Usage: ./build-multiarch.sh <image-name> [tag]`

`Example: ./build-multiarch.sh myrepo/myapp v1.0.0`

 