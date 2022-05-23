# Starting from golang alpine.
FROM golang:1.18-alpine AS builder

WORKDIR /build

# Copying the go mod files and downloads the dependecies
# so docker can cache this layer.
COPY go.mod /build/go.mod
#COPY go.sum /build/go.sum
RUN go mod download

# Builds the app.
COPY . /build
ENV CGO_ENABLED=0
ENV GOOS=linux
RUN go build -o workers-io cmd/server/main.go

# Runing the app in a clean container.
FROM alpine:latest AS runner

WORKDIR /app
# Copy the executable to the new container.
COPY --from=0 /build/workers-io /app/workers-io

ENTRYPOINT ["./workers-io"]
