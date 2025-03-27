FROM linux-vcpkg-base

ARG GITHUB_TOKEN=0

RUN apt install \
linux-libc-dev \
libtool \
libtool-bin \
libmount-dev \
meson \
python3-jinja2 \
autoconf \
autoconf-archive \
bison \
flex \
'^libxcb.*-dev' \
libx11-xcb-dev \
libglu1-mesa-dev \
libxrender-dev \
libxi-dev \
libxkbcommon-dev \
libxkbcommon-x11-dev \
libegl1-mesa-dev -y

RUN echo "-H \"Authorization: Bearer ${GITHUB_TOKEN}\"" >> /root/.curlrc 

RUN vcpkg install qtbase qtdeclarative qtsvg qtimageformats

RUN rm /root/.curlrc