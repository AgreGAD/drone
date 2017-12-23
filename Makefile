all: deps build deploy

deps:
	go get -u github.com/drone/drone-ui/dist
	go get -u golang.org/x/tools/cmd/cover
	go get -u golang.org/x/net/context
	go get -u golang.org/x/net/context/ctxhttp
	go get -u github.com/golang/protobuf/proto
	go get -u github.com/golang/protobuf/protoc-gen-go
	go get -u github.com/AgreGAD/drone/cmd/drone-agent
	go get -u github.com/AgreGAD/drone/cmd/drone-server

build:
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o release/drone-server github.com/AgreGAD/drone/cmd/drone-server
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o release/drone-agent github.com/AgreGAD/drone/cmd/drone-agent

deploy:
	docker build -f Dockerfile.debian -t agregad/drone-server .
	docker build -f Dockerfile.agent.debian -t agregad/drone-agent .
	docker push agregad/drone-agent
	docker push agregad/drone-server
