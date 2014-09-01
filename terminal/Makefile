build:
	~/.cabal/bin/pandoc -t revealjs -V theme=night -V transition=linear -s terminal.md -o terminal.html

install-deps:
	cabal install pandoc
	git clone https://github.com/hakimel/reveal.js.git

install:
	sudo rsync -av terminal.html reveal.js /var/www
