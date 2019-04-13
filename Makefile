
all: build serve

build:
	JEKYLL_ENV=production bundle exec jekyll build --incremental

serve:
	JEKYLL_ENV=production bundle exec jekyll serve --incremental

themes:
	bundle show

change:
	open $(bundle show minima)

update:
	bundle update jekyll
