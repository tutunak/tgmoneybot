FROM golang:alpine3.18 as builder
LABEL authors="tutunak"

COPY . /app
WORKDIR /app
RUN go build -o goapp .

FROM alpine:3.18 as production
LABEL authors="tutunak"
COPY --from=builder /app/tgmoneybot /app/tgmoneybot
RUN addgroup -S tgmoneybot && adduser -S tgmoneybot -G tgmoneybot && \
    chown -R tgmoneybot:tgmoneybot /app
USER tgmoneybot
WORKDIR /app
CMD ["./tgmoneybot"]
