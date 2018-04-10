#!/bin/bash -e
#
## Hugo Build script
#
## variables
Folders=( /home/nico/Programming/Github/hugo-magicbroccoli.de )

## script
# remove the old public directory
echo "Removing old public directory"
rm -rf "/home/nico/Programming/Github/hugo-magicbroccoli.de/public"

# optimizing all png images with optipng
echo "Optimizing static/*.png"
for i in "${Folders[@]}"; do
	find "$i/static/" -type f -regextype posix-extended -iregex ".*\\.png$" | xargs optipng -nc -nb -o7 -silent
done

# builging latest site
hugo --source "/home/nico/Programming/Github/hugo-magicbroccoli.de/"

# clearing variables
unset Folders
exit 0
