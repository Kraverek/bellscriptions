FROM ubuntu:20.04
ARG version=2.0.0

# Update and install required packages
RUN apt update && apt upgrade -y && apt install -y curl gpg ca-certificates tar dirmngr

# Download and install BellsCoin
RUN curl -o bellscoin.tar.gz -Lk https://github.com/Nintondo/bellscoin/releases/download/2.0.0/bells-2.0.0-x86_64-linux-gnu.tar.gz
RUN tar -xvf bellscoin.tar.gz
RUN rm bellscoin.tar.gz
RUN install -m 0755 -o root -g root -t /usr/local/bin bells-${version}/bin/*

# Network port configuration
EXPOSE 19918
EXPOSE 19919

# Volume setting for data (ensure this path matches your configuration)
VOLUME ["/mnt/nvme_data/bellscoin_data"]

# Image metadata
LABEL name="bellscoin-node" version="${version}" description="Dogecoin fullnode container based off Debian"
LABEL maintainer="Dylan Murray <dymurray5@gmail.com>"
