# Run with:
#   docker run -it --rm \
#       -e DISPLAY=$DISPLAY \
#       -v /tmp/.X11-unix:/tmp/.X11-unix \
#       -v /home/murt/Desktop/tmp/zimtest:/home/developer/Notes \
#        zim_wiki

#FROM debian:stretch
FROM ubuntu:xenial
MAINTAINER Curtis Muntz <cmuntz@outlook.com>

RUN apt-get update && apt-get upgrade -y --no-install-recommends

RUN apt-get install -y --no-install-recommends \
        zim \
        sudo \
        locales \
        python-gtksourceview2 \
        graphviz \
        ditaa

# Set the locale
RUN apt-get install -y --no-install-recommends \
        language-pack-en

# cleanup after deb installs
RUN rm -rf /var/lib/apt/lists/*

# language stuff for python locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
RUN dpkg-reconfigure locales

# copy in zim prefs
COPY preferences.conf /home/curtis/.config/zim/

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/curtis && \
    echo "curtis:x:${uid}:${gid}:Developer,,,:/home/curtis:/bin/bash" >> /etc/passwd && \
    echo "curtis:x:${uid}:" >> /etc/group && \
    echo "curtisALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/curtis&& \
    chmod 0440 /etc/sudoers.d/curtis && \
    mkdir -p /home/curtis/Notebooks/Notes && \
    mkdir -p /home/curtis/Pictures && \
    mkdir -p /home/curtis/.config/zim && \
    chown ${uid}:${gid} -R /home/curtis

# run it
USER curtis
ENV HOME /home/curtis
CMD /usr/bin/zim --standalone
