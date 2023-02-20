
FROM golang:alpine AS builder

WORKDIR /usr/src/app
COPY go.mod ./
RUN go mod download && go mod verify

COPY . .
RUN go build -o /usr/local/bin/app
FROM scratch
COPY --from=builder /usr/local/bin/app /usr/local/bin/app
ENTRYPOINT ["/usr/local/bin/app"]