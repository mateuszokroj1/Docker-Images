FROM ubuntu:latest

# Install updates
RUN apt update && apt full-upgrade -y && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt -y install tzdata

# Install basic dev-libs
RUN apt install -y build-essential gcc clang-format clang-tidy clang-tools clang clangd libc++-dev libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev llvm-runtime llvm python3-clang

# Install Git
RUN apt install -y git-all git-lfs

# Install vcpkg system dependencies
RUN apt install -y curl zip unzip pkg-config

# Disable 
RUN echo "insecure" >> /root/.curlrc

# Clone repo of vcpkg
WORKDIR /home
RUN git clone https://github.com/microsoft/vcpkg

RUN ./vcpkg/bootstrap-vcpkg.sh 

ENV VCPKG_ROOT="/home/vcpkg"
ENV PATH="$VCPKG_ROOT:$PATH"