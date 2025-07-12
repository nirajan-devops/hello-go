# -------- Stage 1: build the binary --------
FROM golang:1.22-alpine AS builder

# Enable static linking so we can copy the binary into a scratch image later
ENV CGO_ENABLED=0

WORKDIR /app

# Copy go.mod & go.sum first (better layer‑caching)
COPY go.mod go.sum ./
RUN go mod download

# Copy source and build
COPY . .
RUN go build -o hello .

# -------- Stage 2: minimal runtime image --------
FROM scratch
COPY --from=builder /app/hello /hello
ENTRYPOINT ["/hello"]
