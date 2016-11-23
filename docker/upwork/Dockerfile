# https://www.upwork.com app container

FROM ubuntu:yakkety

MAINTAINER Mike Kuznetsov <mike4gg@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

COPY xdg-open-docker.sh /usr/bin/xdg-open
RUN chmod +x /usr/bin/xdg-open

ENV VERSION v4_2_95_0_9xgmle488qryoawe

ADD https://updates-desktopapp.upwork.com/binaries/${VERSION}/upwork_amd64.deb /tmp/upwork_amd64.deb

RUN apt update && \
    apt install -y --no-install-recommends libpulse0 && \
    dpkg --force-depends -i /tmp/upwork_amd64.deb && \
    apt install -yf --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*.deb

ENV HOME /home/upwork
RUN useradd --create-home --home-dir $HOME upwork && \
	chown -R upwork:upwork $HOME

WORKDIR $HOME
USER upwork

ENTRYPOINT ["upwork"]
