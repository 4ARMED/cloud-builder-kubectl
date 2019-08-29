FROM alpine:3.9 AS downloader
LABEL maintainer="Marc Wickenden <marc@4armed.com>"

RUN apk --update add curl && \
    curl -sL -o /kubectl \
    https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && \
    chmod +x /kubectl

FROM scratch
LABEL maintainer="Marc Wickenden <marc@4armed.com>"

COPY --from=downloader /kubectl /kubectl
ENTRYPOINT [ "/kubectl" ]
