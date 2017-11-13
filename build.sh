#!/bin/bash
#
## Hugo Build script
#
DIRECTORY="/home/nico/Programming/Github/hugo-magicbroccoli.de"

# remove the old public directory
echo "Removing old public directory"
time cd $DIRECTORY && rm -rf ./public

# optimizing all png images with optipng
echo "Optimizing static/*.png"
time for x in `find $DIRECTORY/static/ -type f -name '*.png'`; do
	optipng -o5 -silent ${x};
done

# builging latest site
cd $DIRECTORY && hugo

# precompressing html css and js files
echo "precompressing *.html *.css and *.js files"
time for x in `find $DIRECTORY/public -type f -name '*.html' -o -name '*.css' -o -name '*.js'`; do
     gzip --best --keep --force ${x};
done

# clearing variables
unset DIRECTORY
exit 0
