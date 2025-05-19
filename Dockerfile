FROM golang:1.24.3-alpine3.21 AS build
RUN apk --no-cache add git

ENV CGO_ENABLED=0

WORKDIR /src/
ADD . /src/
RUN go get -u -v
RUN go install

FROM scratch

LABEL org.opencontainers.image.licenses=Apache-2.0

COPY --from=build /go/bin/govanityurls /bin/govanityurls
EXPOSE 8080

CMD ["/bin/govanityurls", "/config/vanity.yaml"]
