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
o=modules.gradle
o2=root.gradle

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
mkdir -p "$O"

configure "$Osettings/$o"
apply2 "// All modules (CodeEditor modules) must have the same settings in entry"
apply2 "// this script play this role"
apply2 ""
apply3 lib common modules


configure "$Osettings/$o2"
apply2 "// root project of CodeEditor have common parts with modules so we manage that here"
apply2 ""
apply3 lib common root

cp -r "${g}/build/" "$O"
