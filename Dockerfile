FROM alpine:3.6
MAINTAINER Jérémy SEBAN <jeremy@seban.eu>

# Installing software to compile
RUN apk add --update gcc autoconf automake git g++ make python-dev openssl-dev libffi-dev \
  && git clone https://github.com/Parchive/par2cmdline /root/par2cmdline \
  && cd /root/par2cmdline \
  && aclocal \
  && automake --add-missing \
  && autoconf \
  && ./configure \
  && make \
  && make install \
  && apk add unrar unzip p7zip python openssl libffi \
  && cd /root \
  && curl https://bootstrap.pypa.io/get-pip.py > /root/pip.py \
  && python /root/pip.py \
  && pip install cheetah \
  && pip install configobj \
  && pip install feedparser \
  && pip install pyOpenSSL \
  && curl http://www.golug.it/pub/yenc/yenc-0.3.tar.gz > /root/yenc-0.3.tar.gz \
  && tar -xvzf yenc-0.3.tar.gz \
  && cd /root/yenc-0.3 \
  && python setup.py build \
  && python setup.py install \
  && mkdir /opt && cd /opt \
  && git clone -b master https://github.com/sabnzbd/sabnzbd sabnzbd \
  && cd /opt/sabnzbd \
  && apk del gcc autoconf automake git g++ make python-dev openssl-dev libffi-dev \
  && rm -rf /var/cache/apk/* \
  && rm -rf /root/par2cmdline \
  && rm /root/pip.py \
  && rm /root/yenc-0.3.tar.gz \
  && rm -rf /root/yenc-0.3

# Exposing sabnzbd web ui
EXPOSE 8080

# Define container volume
VOLUME ["/config", "/downloads"]

# Define environement variables, this is a hack since SABnzbd will store
# its configuration in ~/.sabnzbd
ENV HOME /config

USER 1001

# Setting start CMD
CMD ["/usr/bin/python", "/opt/sabnzbd/SABnzbd.py", "-f", "/config/sabnzbd.ini", "-s", "0.0.0.0:8080"]
