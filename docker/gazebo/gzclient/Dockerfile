# This is an auto generated Dockerfile for gazebo:gzclient8
# generated from templates/docker_images/create_gzclient_image.Dockerfile.em
# generated on 2017-01-27 02:26:04 +0000
FROM gazebo:gzserver8

# install packages
RUN apt-get update && apt-get install -q -y \
    binutils \
    mesa-utils \
    module-init-tools \
    x-window-system\
    && rm -rf /var/lib/apt/lists/*

# install gazebo packages
RUN apt-get update && apt-get install -q -y \
    gazebo8=8.0.0* \
&& rm -rf /var/lib/apt/lists/*

# nvidia-docker hooks
LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

COPY ./gzserver_entrypoint.sh /

RUN chmod +x /gzserver_entrypoint.sh

CMD ["gzclient"]
