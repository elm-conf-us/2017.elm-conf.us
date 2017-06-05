public: $(shell find themes content static -type f) static/styles/main.css static/images/news/2017-speakers.jpg
	hugo -d $@

static/images/news/2017-speakers.jpg: static/images/speakers/*
	montage $(shell find static/images/speakers -type f | gsort -R | head -n 9) -geometry 166x166+0+0 $@

static/styles/main.css: elm/Style*.elm
	elm-css -o static/styles elm/Stylesheets.elm

.PHONY: publish
publish: public
	./scripts/publish.sh
