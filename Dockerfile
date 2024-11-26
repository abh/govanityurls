FROM golang:1.23.3-alpine3.20 AS build
RUN apk --no-cache add git

ENV CGO_ENABLED=0

WORKDIR /src/
ADD . /src/
RUN go get -u -v
RUN go install

FROM scratch
COPY --from=build /go/bin/govanityurls /bin/govanityurls
EXPOSE 8080

CMD ["/bin/govanityurls", "/config/vanity.yaml"]
