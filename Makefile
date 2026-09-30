.PHONY: default server client deps fmt clean all release-all contributors

BUILDTAGS=debug
default: all

deps: 
	go mod tidy

server: deps
	go build -tags '$(BUILDTAGS)' -o bin/ngrokd ngrok/main/ngrokd

client: deps
	go build -tags '$(BUILDTAGS)' -o bin/ngrok ngrok/main/ngrok

fmt:
	go fmt ngrok/...

release-client: BUILDTAGS=release
release-client: client

release-server: BUILDTAGS=release
release-server: server

release-all: fmt release-client release-server

all: fmt client server

clean:
	go clean -r ./...
	rm -fr bin

contributors:
	echo "Contributors to ngrok, both large and small:\n" > CONTRIBUTORS
	git log --raw | grep "^Author: " | sort | uniq | cut -d ' ' -f2- | sed 's/^/- /' | cut -d '<' -f1 >> CONTRIBUTORS
