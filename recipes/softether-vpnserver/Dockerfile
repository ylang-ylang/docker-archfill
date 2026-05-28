FROM debian:bookworm AS build

ARG SOFTETHER_VERSION

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      build-essential \
      ca-certificates \
      cmake \
      git \
      libreadline-dev \
      libsodium-dev \
      libssl-dev \
      zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --branch "${SOFTETHER_VERSION}" \
    https://github.com/SoftEtherVPN/SoftEtherVPN_Stable.git /src

WORKDIR /src

RUN ./configure \
    && make -C build

FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      ca-certificates \
      iproute2 \
      iputils-ping \
      net-tools \
      procps \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /src/build/vpnserver /usr/local/vpnserver

WORKDIR /usr/local/vpnserver

EXPOSE 443/tcp 992/tcp 1194/tcp 5555/tcp

CMD ["/usr/local/vpnserver/vpnserver", "execsvc"]

