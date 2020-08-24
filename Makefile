all: static/style.css static/bundle.js

dep:
	sudo apt update
	sudo apt install curl software-properties-common
	curl -sL https://deb.nodesource.com/setup_13.x | sudo bash -
	sudo apt install nodejs
	sudo npm --force install -g npx
	go get github.com/mattn/go-sqlite3
	go get golang.org/x/crypto/bcrypt
	go get github.com/shurcooL/github_flavored_markdown

nodemodules:
	rm -rf node_modules
	npm install

static/style.css: twsrc.css
	#npx tailwind build twsrc.css -o twsrc.o 1>/dev/null
	#npx postcss twsrc.o > static/style.css
	npx tailwind build twsrc.css -o static/style.css 1>/dev/null

t2: t2.go
	go build -o t2 t2.go

static/bundle.js: index.js App.svelte
	npx rollup -c

clean:
	rm -rf static/bundle.js static/bundle.css static/*.map
	rm -rf *.o static/style.css

