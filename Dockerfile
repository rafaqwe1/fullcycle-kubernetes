from golang:1.15  as golang

WORKDIR /go/src/server

COPY . .

RUN go build -o app .

FROM golang:1.15

COPY --from=golang /go/src/server/app .

CMD ["./app"]