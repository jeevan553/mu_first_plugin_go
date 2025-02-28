FROM golang:alpine
WORKDIR /app
COPY . .
RUN go build -o mu_first_plugin_go .
ENTRYPOINT ["./mu_first_plugin_go"]