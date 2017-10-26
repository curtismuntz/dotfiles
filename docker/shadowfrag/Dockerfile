FROM ubuntu:16.04
MAINTAINER Curtis Muntz <cmuntz@outlook.com>

# update ubuntu
# RUN apt-get update && apt-get upgrade -y --no-install-recommends
# usability installs
RUN apt-get update && apt-get install -y \
	software-properties-common

RUN apt-get update && \
	apt-get install -y \
    python3 \
    python3-pip \
    python3-virtualenv \
		python3-setuptools \
    vim \
	--no-install-recommends

RUN mkdir /usr/src/app
COPY requirements.txt /usr/src/app/requirements.txt
RUN pip3 install -r /usr/src/app/requirements.txt

# cleanup from all the apt stuff...
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir /usr/io
COPY shadowfrag.py /usr/src/app
RUN chmod +x /usr/src/app/shadowfrag.py
CMD /usr/bin/python /usr/src/app/shadowfrag.py
