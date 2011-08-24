all:
	jekyll web web.out

serve:
	jekyll --serve --auto web web.out


.PHONY: all serve
