all: deps lint test
	CGO_ENABLED=0 go build -a -o hello_world

test:
	GIN_MODE=debug go test

lint:
	test -z `gofmt -s -l .`
	go vet ./...
	golint -set_exit_status `go list ./...`

deps:
	go install
	go install github.com/stretchr/testify@v1.8.4
	go install golang.org/x/lint/golint@latest
