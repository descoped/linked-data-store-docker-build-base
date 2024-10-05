FROM descoped/alpine-jdk11-buildtools:latest

# Add script used by LDS servers to clone all SSB snapshot dependencies
ADD clone_snapshots.sh /

# Warm maven cache using stable LDS core
RUN git clone https://github.com/descoped/linked-data-store-core.git
WORKDIR /linked-data-store-core
RUN mvn -B -DskipTests verify dependency:go-offline
RUN git checkout $(git tag | tail -1)
RUN mvn -B -DskipTests verify dependency:go-offline
WORKDIR /
