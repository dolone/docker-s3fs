FROM ubuntu:18.04

WORKDIR /root/

ENV VERSION=1.86 \
    ENDPOINT="your endpoint" \
    ACCESS_Key_ID="your access key" \
    ACCESS_KEY_SCERET="your secret key" \
    BUCKET="your bucket name" \
    UID=0 \
    GID=0

COPY start.sh /root/

VOLUME /mnt/

RUN apt-get update -y \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    automake \
    curl \
    build-essential \
    libcurl4-openssl-dev \
    libssl-dev \
    libfuse-dev \
    libtool \
    libxml2-dev mime-support \
    tar \
    pkg-config \
 && rm -rf /var/lib/apt/lists/* \
 && curl -L https://github.com/s3fs-fuse/s3fs-fuse/archive/v${VERSION}.tar.gz | tar zxv -C /usr/src \
 && cd /usr/src/s3fs-fuse-${VERSION} \
 && ./autogen.sh \
 && ./configure --prefix=/usr \
 && make && make install

# CMD ["/bin/bash", "-C","/root/start.sh","${ACCESS_Key_ID}","${ACCESS_KEY_SCERET}","${BUCKET}","${UID}","${GID}","${ENDPOINT}"] 报错，无法识别变量
CMD sh /root/start.sh ${ACCESS_Key_ID} ${ACCESS_KEY_SCERET} ${BUCKET} ${UID} ${GID} ${ENDPOINT}