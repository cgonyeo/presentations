build:
	~/.cabal/bin/pandoc -t revealjs -V theme=night -V transition=linear -s bash.md -o bash.html

install-deps:
	cabal install pandoc
	git clone https://github.com/hakimel/reveal.js.git

install:
	sudo rsync -av bash.html reveal.js /var/www
