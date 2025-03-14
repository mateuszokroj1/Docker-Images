FROM ubuntu:latest

# Start path is user dir
WORKDIR /home

# Install updates
RUN apt update
RUN apt full-upgrade -y

# Install basic dev-libs
RUN apt install build-essential gcc clang-format clang-tidy clang-tools clang clangd libc++-dev libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev llvm-runtime llvm python3-clang -y

# Install Git
RUN apt install git-all git-lfs -y

# Install vcpkg system dependencies
RUN apt install curl zip unzip pkg-config libtool libtool-bin libmount-dev  -y

# Disable 
RUN echo "insecure" >> /root/.curlrc

# Clone repo of vcpkg
RUN git clone https://github.com/microsoft/vcpkg

RUN ./vcpkg/bootstrap-vcpkg.sh 

ENV VCPKG_ROOT="/home/vcpkg"
ENV PATH="$VCPKG_ROOT:$PATH"