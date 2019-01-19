
all: build serve

build:
	JEKYLL_ENV=production bundle exec jekyll build --incremental

serve:
	JEKYLL_ENV=production bundle exec jekyll serve --incremental
