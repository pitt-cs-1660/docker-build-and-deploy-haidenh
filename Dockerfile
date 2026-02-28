# Stage 1

FROM golang:1.23 AS builder

WORKDIR /app

COPY main.go .
COPY go.mod .
COPY templates ./templates/

RUN CGO_ENABLED=0 go build -o band_app .

# Stage 2

FROM scratch

WORKDIR /app

COPY --from=builder /app/band_app .
COPY --from=builder /app/templates ./templates/

CMD ["./band_app"]