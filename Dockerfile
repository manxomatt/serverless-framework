FROM node:16

 RUN npm install -g serverless@2.60.0

# zip
RUN apt-get update && apt-get install -y zip && rm -rf /var/lib/apt/lists/*

ENV GLIBC_VER=2.31-r0

# install glibc compatibility for alpine
# and install AWS CLI 2
RUN apk --no-cache add \
        binutils \
        curl \
    && curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk 
    # && apk add --no-cache \
    #     glibc-${GLIBC_VER}.apk \
    #     glibc-bin-${GLIBC_VER}.apk 

# aws
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip
RUN ./aws/install && aws --version

# # jq
# ENV JQ_VERSION='1.6'
# RUN wget --no-check-certificate https://raw.githubusercontent.com/stedolan/jq/jq-${JQ_VERSION}/sig/jq-release.key -O /tmp/jq-release.key && \
#     wget --no-check-certificate https://raw.githubusercontent.com/stedolan/jq/jq-${JQ_VERSION}/sig/v${JQ_VERSION}/jq-linux64.asc -O /tmp/jq-linux64.asc && \
#     wget --no-check-certificate https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64 -O /tmp/jq-linux64 && \
#     gpg --import /tmp/jq-release.key && \
#     gpg --verify /tmp/jq-linux64.asc /tmp/jq-linux64 && \
#     cp /tmp/jq-linux64 /usr/bin/jq && \
#     chmod +x /usr/bin/jq && \
#     rm -f /tmp/jq-release.key && \
#     rm -f /tmp/jq-linux64.asc && \
#     rm -f /tmp/jq-linux64

RUN aws --version

RUN sls --version

# FROM node:16.20-alpine

# # Install Serverless Framework
# RUN npm install -g serverless@2.60.0

# ENV GLIBC_VER=2.31-r0

# # install glibc compatibility for alpine
# # and install AWS CLI 2
# RUN apk --no-cache add \
#         binutils \
#         curl \
#     && curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
#     && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk \
#     && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk \
#     && apk add --no-cache \
#         glibc-${GLIBC_VER}.apk \
#         glibc-bin-${GLIBC_VER}.apk \
#     && curl -sL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
#     && unzip awscliv2.zip \
#     && aws/install \
#     && rm -rf \
#         awscliv2.zip \
#         aws \
#         /usr/local/aws-cli/v2/*/dist/aws_completer \
#         /usr/local/aws-cli/v2/*/dist/awscli/data/ac.index \
#         /usr/local/aws-cli/v2/*/dist/awscli/examples \
#     && apk --no-cache del \
#         binutils \
#         curl \
#     && rm glibc-${GLIBC_VER}.apk \
#     && rm glibc-bin-${GLIBC_VER}.apk \
#     && rm -rf /var/cache/apk/*

# RUN aws --version
# RUN sls --version