FROM golang:1.21.0-alpine AS builder

WORKDIR /usr/src/app

COPY go.mod ./

RUN go mod download && go mod verify

COPY . .

RUN go build -v -o /usr/local/bin/app ./...


FROM scratch

COPY --from=builder /usr/local/bin/app /

CMD ["/app"]
