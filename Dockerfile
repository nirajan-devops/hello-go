# -------- Stage 1: Test & Build Stage --------
FROM golang:1.24.5-alpine AS builder

# Install git for modules and bash for CI clarity (optional)
RUN apk add --no-cache git bash

WORKDIR /app

# Copy go.mod and go.sum first for caching
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the source code
COPY . .

# Static analysis
RUN go vet ./...

# Run unit tests
RUN go test ./...

# Build the binary
RUN go build -o hello-web

# -------- Stage 2: Lightweight Runtime Stage --------
FROM alpine:latest

WORKDIR /root/

# Copy only the compiled binary from the builder stage
COPY --from=builder /app/hello-web .

# Expose app port
EXPOSE 8080

# Default command
CMD ["./hello-web"]
