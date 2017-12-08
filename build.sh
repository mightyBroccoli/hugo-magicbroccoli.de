#!/bin/bash -e
#
## Hugo Build script
#

## variables
Folders=("/home/nico/Programming/Github/hugo-magicbroccoli.de/public")
ext="css|js|html|xml|svg|ico|eot|otf|ttf"

## functions
function compressResource {
	gzip -c9 "$1" >"$1.gz"
	touch -c --reference="$1" "$1.gz"
	echo "Compressed: $1 > $1.gz"
}

## script
# remove the old public directory
echo "Removing old public directory"
rm -rf "/home/nico/Programming/Github/hugo-magicbroccoli.de/public"

# optimizing all png images with optipng
echo "Optimizing static/*.png"
#find $DIRECTORY/static/ -type f -name '*.png' -print0 | xargs optipng -nc -nb -o7 -silent

# builging latest site
hugo --source "/home/nico/Programming/Github/hugo-magicbroccoli.de/"

# precompiled list of folders
for appDir in "${Folders[@]}"
do
	# fetch all existing gzipped CSS/JavaScript/webfont files and remove files that do not have a base uncompressed file
	find "$appDir" -type f -regextype posix-extended -iregex ".*\\.(${ext})\\.gz$" -print0 | while read -d '' compressFile
	do
		if [[ ! -f ${compressFile%.gz} ]]; then
			# remove orphan gzipped file
			rm "$compressFile"
			echo "Removed: $compressFile"
		fi
	done

	# fetch all source CSS/JS/webfont files - excluding *.src.* variants (pre-minified CSS/JavaScript)
	# gzip each file and give timestamp identical to that of the uncompressed source file
	find "$appDir" -type f -regextype posix-extended \( -iregex ".*\\.(${ext})$" \) \( ! -name "*.src.css" -and ! -name "*.src.js" \) -print0 | while read -d '' sourceFile
	do
		if [[ -f "$sourceFile.gz" ]]; then
			# only re-gzip if source file is different in timestamp to the existing gzip file
			if [[ ($sourceFile -nt "$sourceFile.gz") || ($sourceFile -ot "$sourceFile.gz") ]]; then
				compressResource "$sourceFile"
			fi
		else
			compressResource "$sourceFile"
		fi
	done
done

# clearing variables
unset Folders ext
exit 0
