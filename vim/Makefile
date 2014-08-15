build:
	~/.cabal/bin/pandoc -t revealjs -V theme=night -V transition=linear -s vim.md -o vim.html

install-deps:
	cabal install pandoc
	git clone https://github.com/hakimel/reveal.js.git

install:
	sudo rsync -av vim.html reveal.js /var/www
