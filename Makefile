all:
	jekyll web web.out

serve:
	jekyll --serve --auto web web.out

publish: all
	./publish.sh web.out

.PHONY: all serve publish
