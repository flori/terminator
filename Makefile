GLOBAL_GOPATH := $(HOME)/go/bin
GOPATH := $(shell pwd)/gospace
EXECUTABLE ?= "foo"

.EXPORT_ALL_VARIABLES:

.PHONY: build build-info

all: setup terminator killme

terminator: cmd/terminator/main.go
	go build -ldflags "-X main.Executable=${EXECUTABLE}" -o $@ $<

killme: killme.go
	go build -o $@ $<

fetch:
	go mod download

setup: fake-package fetch

fake-package:
	rm -rf $(GOPATH)/src/github.com/flori/terminator
	mkdir -p $(GOPATH)/src/github.com/flori
	ln -s $(shell pwd) $(GOPATH)/src/github.com/flori/terminator

test:
	@go test

coverage:
	@go test -coverprofile=coverage.out

coverage-display: coverage
	@go tool cover -html=coverage.out

clean:
	@rm -f terminator coverage.out tags

clobber: clean
	@rm -rf $(GOPATH)/*

tags: clean
	@gotags -tag-relative=false -silent=true -R=true -f $@ . $(GOPATH)

build:
	@docker build --pull -t terminator -f Dockerfile-terminator .
	@docker build --pull -t killme -f Dockerfile-killme .

create-cronjob:
	@kubectl apply -f cronjob.yml

test-kubernetes: build create-cronjob
