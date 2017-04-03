public: $(find themes content layouts static -type f) static/styles/main.css
	hugo -d $@

static/styles/main.css: elm/Style*.elm
	elm-css -o static/styles elm/Stylesheets.elm

.PHONY: publish
publish: public
	./scripts/publish.sh
