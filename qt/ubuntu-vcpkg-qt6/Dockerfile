ARG BASE_IMAGE

FROM $BASE_IMAGE

RUN apt install \
linux-libc-dev \
libtool \
libtool-bin \
libmount-dev \
python3 \
python3-setuptools \
python3-pip \
python3-venv \
python3-jinja2 \
meson \
gettext \
automake \
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
libegl1-mesa-dev \
libgl1-mesa-dev \
libglu1-mesa-dev \
mesa-common-dev \
libxrandr-dev \
libxxf86vm-dev \
libxcursor-dev \
libxext-dev \
libxfixes-dev \
libxrender-dev \
libxkbcommon-dev \
libxkbcommon-x11-dev -y

COPY .curlrc /root/.curlrc 

RUN vcpkg install qtbase qtdeclarative qtsvg qtimageformats

RUN rm /root/.curlrc