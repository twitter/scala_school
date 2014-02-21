This is Scala School- a set of lessons covering the Scala programming language.

We use [jekyll](https://github.com/mojombo/jekyll) to generate the site. In order to build it, you must first install it:

	$ gem install jekyll

should do. Now, build the site with `make`. This will create a copy of the lessons in the `web.out` folder.

For development, you'll also need to install [RedCloth](http://redcloth.org/).

  $ gem install RedCloth

Then `make serve` will launch `jekyll` in serving mode: a web server will be launched on port 4000, and changing files will automatically rebuild the site.

To publish to http://twitter.github.io/scala_school :

	$ make publish
