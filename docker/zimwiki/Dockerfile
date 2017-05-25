#modified from http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/
# 
#
#
# Run with:
#   docker run -it --rm \                                                                                                                                       
#       -e DISPLAY=$DISPLAY \
#       -v /tmp/.X11-unix:/tmp/.X11-unix \
#       -v /home/murt/Desktop/tmp/zimtest:/home/developer/Notes \
#        zim_wiki_tst

FROM debian:stretch

RUN apt-get update && apt-get install -y zim sudo python-gtksourceview2

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    mkdir -p /home/developer/Notebooks/Notes && \
    mkdir -p /home/developer/Pictures/wiki && \
    chown ${uid}:${gid} -R /home/developer


USER developer
ENV HOME /home/developer
CMD /usr/bin/zim --standalone
#ENTRYPOINT [ "/usr/bin/zim" ]
