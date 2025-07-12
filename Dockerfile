# -------- Stage 1: Build the Go binary --------
FROM golang:1.24.5-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go build -o hello-web

# -------- Stage 2: Lightweight runtime --------
FROM alpine:latest

WORKDIR /root/

COPY --from=builder /app/hello-web .

EXPOSE 8080

CMD ["./hello-web"]
