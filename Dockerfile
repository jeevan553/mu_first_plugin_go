# Build Stage
FROM my_first_docker_build_image:latest AS build-stage

LABEL app="build-mu_first_plugin_go"
LABEL REPO="https://github.com/jeevan553/mu_first_plugin_go"

ENV PROJPATH=/go/src/github.com/jeevan553/mu_first_plugin_go

# Because of https://github.com/docker/docker/issues/14914
ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin

ADD . /go/src/github.com/jeevan553/mu_first_plugin_go
WORKDIR /go/src/github.com/jeevan553/mu_first_plugin_go

RUN make build-alpine

# Final Stage
FROM my_first_docker_image

ARG GIT_COMMIT
ARG VERSION
LABEL REPO="https://github.com/jeevan553/mu_first_plugin_go"
LABEL GIT_COMMIT=$GIT_COMMIT
LABEL VERSION=$VERSION

# Because of https://github.com/docker/docker/issues/14914
ENV PATH=$PATH:/opt/mu_first_plugin_go/bin

WORKDIR /opt/mu_first_plugin_go/bin

COPY --from=build-stage /go/src/github.com/jeevan553/mu_first_plugin_go/bin/mu_first_plugin_go /opt/mu_first_plugin_go/bin/
RUN chmod +x /opt/mu_first_plugin_go/bin/mu_first_plugin_go

# Create appuser
RUN adduser -D -g '' mu_first_plugin_go
USER mu_first_plugin_go

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/opt/mu_first_plugin_go/bin/mu_first_plugin_go"]
