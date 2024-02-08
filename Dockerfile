FROM ubuntu:22.04

ENV UID=1000
ENV GID=1000

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common && \
    apt-get clean && \
    apt-get autoremove -y

RUN add-apt-repository multiverse && \
    dpkg --add-architecture i386 && \
    apt-get update

# Accept Steam License
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN echo steam steam/question select "I AGREE" | debconf-set-selections \
 && echo steam steam/license note '' | debconf-set-selections

RUN apt-get install -y --no-install-recommends ca-certificates locales steamcmd && \
    apt-get clean && \
    apt-get autoremove -y


# Add unicode support
RUN locale-gen en_US.UTF-8
ENV LANG 'en_US.UTF-8'
ENV LANGUAGE 'en_US:en'

# Create symlink for executable
RUN ln -s /usr/games/steamcmd /usr/bin/steamcmd

RUN adduser --shell $(which sh) --uid ${UID} --disabled-password palworld

USER ${GID}:${UID}

RUN steamcmd +quit
RUN steamcmd +login anonymous +app_update 1007 +quit

# Fix missing directories and libraries
RUN mkdir -p $HOME/.steam && \
    ln -s $HOME/.local/share/Steam/steamcmd/linux32 $HOME/.steam/sdk32 && \
    ln -s $HOME/.local/share/Steam/steamcmd/linux64 $HOME/.steam/sdk64 && \
    ln -s $HOME/.steam/sdk32/steamclient.so $HOME/.steam/sdk32/steamservice.so && \
    ln -s $HOME/.steam/sdk64/steamclient.so $HOME/.steam/sdk64/steamservice.so && \
    echo "Linking done"

# Install the Palworld server
RUN steamcmd +login anonymous +app_update 2394010 validate +quit

EXPOSE 8211

COPY start.sh /home/palworld/start.sh

WORKDIR /home/palworld
ENTRYPOINT [ "/home/palworld/start.sh" ]

