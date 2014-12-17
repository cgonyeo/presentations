build:
	~/.cabal/bin/pandoc -t revealjs -V theme=solarized -V transition=linear -s haskell.md -o haskell.html

install-deps:
	cabal install pandoc
	git clone https://github.com/hakimel/reveal.js.git

install:
	sudo rsync -av haskell.html reveal.js /var/www
