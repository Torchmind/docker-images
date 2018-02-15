FROM circleci/openjdk:8-jdk-browsers
RUN sudo apt-get install openjfx
RUN build_deps="curl ca-certificates" && \
    sudo apt-get update && \
    DEBIAN_FRONTEND=noninteractive sudo apt-get install -y --no-install-recommends ${build_deps} && \
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash && \
    DEBIAN_FRONTEND=noninteractive sudo apt-get install -y --no-install-recommends git-lfs && \
    git lfs install && \
    sudo rm -r /var/lib/apt/lists/*
