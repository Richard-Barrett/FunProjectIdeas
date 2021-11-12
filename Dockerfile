FROM golang:1.17.3-alpine3.14 AS FunProjectIdeas
COPY . /w
WORKDIR /w

RUN go build github.com/Richard-Barrett/FunProjectIdeas/cmd/funprojectideas

FROM alpine:3.14.2
COPY --from=magnetite /w/FunProjectIdeas /bin/funprojectideas
ENTRYPOINT [ "/bin/funprojectideas" ]