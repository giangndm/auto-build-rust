FROM ubuntu:22.04 as base

COPY . /tmp
WORKDIR /tmp

RUN echo $TARGETPLATFORM
RUN ls -R /tmp/
# move the binary to root based on platform
RUN case $BUILDARCH in \
        "amd64")  TARGET_APP=x86_64-unknown-linux-gnu/app1-x86_64-unknown-linux-gnu  ;; \
        "arm64")  TARGET_APP=aarch64-unknown-linux-gnu/app1-aarch64-unknown-linux-gnu  ;; \
        *) exit 1 ;; \
    esac; \
    mv TARGET_APP /app1; \
    chmod +x /app1

FROM ubuntu:22.04

COPY --from=base /app1 /app1

ENTRYPOINT ["/app1"]