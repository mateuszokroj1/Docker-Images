FROM ubuntu:latest

# Start path is user dir
WORKDIR /home

# Install updates
RUN apt update
RUN apt full-upgrade -y

# Install basic dev-libs
RUN apt install build-essentials -y

# Install Git
RUN apt install git-all git-lfs -y

# Install vcpkg system dependencies
RUN apt install curl zip unzip -y

# Clone repo of vcpkg
RUN git clone https://github.com/microsoft/vcpkg

RUN ./vcpkg/bootstrap-vcpkg.sh 
