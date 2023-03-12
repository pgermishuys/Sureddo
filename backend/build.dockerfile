FROM alpine:latest

ARG GitHubToken
ENV GitHubToken=${GitHubToken}
ARG GITHUB_RUN_NUMBER
ENV GITHUB_RUN_NUMBER=${GITHUB_RUN_NUMBER}

RUN apk update && apk add clang lld curl gcc

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

ENV PATH "$PATH:/root/.cargo/bin"

COPY . ./repo/

WORKDIR /repo
