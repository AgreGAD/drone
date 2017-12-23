all: deps build

deps:
	go get -u github.com/drone/drone-ui/dist
	go get -u golang.org/x/tools/cmd/cover
	go get -u golang.org/x/net/context
	go get -u golang.org/x/net/context/ctxhttp
	go get -u github.com/golang/protobuf/proto
	go get -u github.com/golang/protobuf/protoc-gen-go
	go get -u github.com/AgreGAD/drone/cmd/drone-agent

build:
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o release/drone-agent github.com/AgreGAD/drone/cmd/drone-agent
	docker build -f Dockerfile.agent.debian -t agregad/drone-agent .

deploy:
	docker push agregad/drone-agent
