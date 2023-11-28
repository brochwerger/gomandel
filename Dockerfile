
FROM ubi8/go-toolset:1.18 as build

### Copy source code for building the application
COPY ./mandel.go .

### Download dependencies and build
RUN go mod init gomandel && \
    go mod tidy -e && \
    go build . 

FROM alpine
WORKDIR /app 
COPY --from=build /opt/app-root/src/gomandel .

EXPOSE 8080
ENTRYPOINT ["/app/gomandel"]
CMD ["--server", "--xres=1024", "--yres=1024" ]
