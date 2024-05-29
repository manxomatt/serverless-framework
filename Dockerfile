# FROM node:20.12.2-alpine3.19

# RUN npm install -g serverless@3.0.0

# RUN export NODE_OPTIONS=--openssl-legacy-provider
# RUN apk update && \
#     apk add --no-cache --update \
#     python3 \
#     py3-pip \
#     pipx \
#     bash \
#     && pipx ensurepath

# ENV PATH="$PATH:/root/.local/bin"

# RUN pipx install awscli

# RUN aws --version

# RUN sls --version

FROM node:18.20.0-alpine

RUN npm install -g serverless@2.60.0

# zip
# RUN apt-get update && apt-get install -y zip && rm -rf /var/lib/apt/lists/*

ENV GLIBC_VER=2.31-r0

# install glibc compatibility for alpine
# and install AWS CLI 2
RUN apk --no-cache add \
    binutils \
    curl \
    && curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk \
    && apk add --force-overwrite --no-cache \
    glibc-${GLIBC_VER}.apk \
    glibc-bin-${GLIBC_VER}.apk 

# aws
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip
RUN ./aws/install && aws --version

RUN rm -rf \
    awscliv2.zip \
    aws \
    /usr/local/aws-cli/v2/*/dist/aws_completer \
    /usr/local/aws-cli/v2/*/dist/awscli/data/ac.index \
    /usr/local/aws-cli/v2/*/dist/awscli/examples \
    && apk --no-cache del \
    binutils \
    curl \
    && rm glibc-${GLIBC_VER}.apk \
    && rm glibc-bin-${GLIBC_VER}.apk \
    && rm -rf /var/cache/apk/*

RUN aws --version

RUN sls --version