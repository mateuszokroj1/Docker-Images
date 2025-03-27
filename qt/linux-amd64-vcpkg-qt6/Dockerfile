FROM linux-amd64-vcpkg-base

ARG GITHUB_TOKEN=0

RUN apt install \
libtool \
libtool-bin \
libmount-dev \
meson \
python3-jinja2 \
autoconf \
autoconf-archive \
bison \
flex \
libfontconfig1-dev \
libfreetype-dev \
libx11-dev \
libx11-xcb-dev \
libxcb-cursor-dev \
libxcb-glx0-dev \
libxcb-icccm4-dev \
libxcb-image0-dev \
libxcb-keysyms1-dev \
libxcb-randr0-dev \
libxcb-render-util0-dev \
libxcb-shape0-dev \
libxcb-shm0-dev \
libxcb-sync-dev \
libxcb-util-dev \
libxcb-xfixes0-dev \
libxcb-xinerama0-dev \
libxcb-xkb-dev \
libxcb1-dev \
libxext-dev \
libxfixes-dev \
libxi-dev \
libxkbcommon-dev \
libxkbcommon-x11-dev \
libxrender-dev -y

RUN echo "-H \"Authorization: Bearer ${GITHUB_TOKEN}\"" >> /root/.curlrc 

RUN vcpkg install qtbase qtdeclarative qtsvg qtimageformats

RUN rm /root/.curlrc