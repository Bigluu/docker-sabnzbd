FROM alpine:3.6

LABEL io.k8s.description="Sabnzbd" \
      io.k8s.display-name="Sabzbd" \
      io.openshift.expose-services="8080" \
      io.openshift.tags="sabnzbd"

## Maintainer info
MAINTAINER Nicolas Bigler <https://github.com/Bigluu>
# Installing software to compile
RUN apk add --update gcc autoconf automake git g++ make python-dev openssl-dev libffi-dev libgomp curl\
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
  && pip install sabyenc \
  && mkdir /opt && cd /opt \
  && git clone -b master https://github.com/sabnzbd/sabnzbd sabnzbd \
  && cd /opt/sabnzbd \
  && apk del gcc autoconf automake git g++ make python-dev openssl-dev libffi-dev \
  && rm -rf /var/cache/apk/* \
  && rm -rf /root/par2cmdline \
  && rm /root/pip.py

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
