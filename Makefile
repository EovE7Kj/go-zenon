.PHONY: all clean znnd

GO ?= latest

EXECUTABLE=libznn.so
SERVERMAIN = $(shell pwd)/cmd/znnd
LIBMAIN = $(shell pwd)/cmd/libznn
BUILDDIR = $(shell pwd)/build
GIT_COMMIT=$(shell git rev-parse HEAD)
GIT_COMMIT_FILE=$(shell pwd)/metadata/git_commit.go

export GO111MODULE=off

$(EXECUTABLE):
        go build -o $(BUILDDIR)/$(EXECUTABLE) -buildmode=c-shared -tags libznn $(LIBMAIN)

libznn: $(EXECUTABLE) ## Build binaries
        @echo "Build libznn done."

znnd:
        env GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o $(BUILDDIR)/znnd $(SERVERMAIN)
        @echo "Build znnd done."
        @echo "Run \"$(BUILDDIR)/znnd\" to start znnd."

clean:
        rm -r $(BUILDDIR)/

all: znnd libznn
