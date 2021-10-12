#!/bin/bash
#
# Build script for groovy scripts
#

g=src/main/groovy/
O=outputs/
Osettings="${O}/settings/"
Isettings="${g}/settings/"
Obuild="${O}/build/"
Ibuild="${g}/build/"

VAR=""
function configure() {
	VAR="$1"
	file="${VAR/*\//}"
	folder="${VAR/%$file/}"
	mkdir -p "$folder"
	> "$VAR"
}
function apply() {
       FILES=("$@")
       FILES=("${FILES[$i]/%.gradle/}")
       FILES=("${FILES[$i]/%/.gradle}")
       echo "// ${FILES[@]}" >> "$VAR"
       cat "${FILES[@]}" >> "$VAR"
}
function apply2() {
	echo "$@" >> "$VAR"
}
function apply3() {
	for f in "$@" ; do apply "${Isettings}/${f}" ; done
}
mkdir -p "$Obuild" "$Osettings"

configure "$Osettings/autodiscover.gradle"
apply2 "// Projects are discovered from the directory structure, nothing to do"
apply3 lib common

for f in $(ls ${g}/build/*) ; do
	file="${f/*\//}"
	cp "${Isettings}/lib.gradle" "$Obuild/$file"
	echo "" >> "${Obuild}/$file"
	cat "$f" >> "$Obuild/$file"
done





