# Usage:
# 'make dep' and 'make webtools' to install dependencies.
# 'make clean' to clear all work files
# 'make' to build css and js into static/
# 'make serve' to start dev webserver

NODE_VER = 18.12.1

JSFILES = index.js Index.svelte

all: static/style.css static/bundle.js

dep:
	sudo apt update && apt upgrade
	sudo apt install curl software-properties-common
	curl -fsSL https://deb.nodesource.com/setup_$(NODE_VER).x | sudo bash -
	sudo apt install nodejs
	sudo npm install -g npx

webtools:
	npm install --save-dev tailwindcss
	npm install --save-dev postcss-cli
	npm install --save-dev cssnano
	npm install --save-dev svelte
	npm install --save-dev rollup
	npm install --save-dev rollup-plugin-svelte
	npm install --save-dev @rollup/plugin-node-resolve

static/style.css: twsrc.css
	#npx tailwind build twsrc.css -o twsrc.o 1>/dev/null
	#npx postcss twsrc.o > static/style.css
	npx tailwind -i twsrc.css -o static/style.css 1>/dev/null

static/bundle.js: $(JSFILES)
	npx rollup -c

clean:
	rm -rf static/*.js static/*.css static/*.map

serve:
	python -m SimpleHTTPServer

