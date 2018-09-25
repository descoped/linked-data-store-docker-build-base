FROM statisticsnorway/alpine-jdk11-buildtools:latest

# Add script used by LDS servers to clone all SSB snapshot dependencies
ADD clone_snapshots.sh /

# Warm maven cache using stable LDS core
RUN git clone https://github.com/statisticsnorway/linked-data-store-core.git
WORKDIR /linked-data-store-core
RUN git checkout $(git tag | tail -1)
RUN mvn -B verify dependency:go-offline
WORKDIR /
