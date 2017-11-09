#!/bin/bash
#
## Hugo Build script
#
DIRECTORY="/home/nico/Programming/Github/hugo-magicbroccoli.de"

# remove the old public directory
echo "Removing old public directory"
cd $DIRECTORY && rm -rf ./public

# builging latest site
cd $DIRECTORY && hugo

# precompressing html css and js files
for x in `find $DIRECTORY/public -type f -name '*.html' -o -name '*.css' -o -name '*.js'`; do
     gzip --best --keep --force ${x};
done

# clearing variables
unset DIRECTORY
exit 0
