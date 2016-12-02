# Skype for Linux Alpha

FROM ubuntu:yakkety

MAINTAINER Mike Kuznetsov <mike4gg@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

COPY xdg-open-docker.sh /usr/bin/xdg-open
RUN chmod +x /usr/bin/xdg-open

RUN apt update && \
    apt install -y libpulse0 --no-install-recommends

RUN echo "enable-shm = no" >> /etc/pulse/client.conf

ADD https://go.skype.com/skypeforlinux-64-alpha.deb /tmp/skypeforlinux-64-alpha.deb

RUN apt update && \
    dpkg --force-depends -i /tmp/skypeforlinux-64-alpha.deb && \
    apt install -yf --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*.deb

COPY skype_wrapper.sh /usr/bin/skype_wrapper.sh
RUN chmod +x /usr/bin/skype_wrapper.sh

# Make a user
ENV HOME /home/skype
RUN useradd --create-home --home-dir $HOME skype \
	&& chown -R skype:skype $HOME \
	&& usermod -a -G video skype

WORKDIR $HOME
USER skype

# Start Skype
ENTRYPOINT ["skype_wrapper.sh"]
