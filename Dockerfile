
FROM docker.io/library/golang:1.19

WORKDIR /app 

### Copy source code for building the application
COPY ./mandel.go .

### Download dependencies and build
RUN go mod init gomandel && \
    go mod tidy -e 
###    go build . 
RUN CGO_ENABLED=0 GOOS=linux go build 
EXPOSE 8080
ENTRYPOINT ["/app/gomandel"]
CMD ["--server", "--xres=1024", "--yres=1024" ]
