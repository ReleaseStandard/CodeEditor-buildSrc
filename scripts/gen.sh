#!/bin/bash
#
# Build script for groovy scripts
#

g=src/main/groovy/
O=outputs/
o=settings.modules.gradle
o2=settings.root.gradle

VAR=""
function configure() {
	VAR="$1"
	> "$VAR"
}
function apply() {
	cat "$@" >> "$VAR"
}
function apply2() {
	echo "$@" >> "$VAR"
}
function apply3() {
	for f in "$@" ; do apply "${g}/${f}" ; done
}
mkdir -p "$O"

configure "$O/$o"
apply2 "// All modules (CodeEditor modules) must have the same settings in entry"
apply2 "// this script play this role"
apply2 ""
apply3 settings.lib.gradle settings.common.gradle settings.modules.gradle


configure "$O/$o2"
apply2 "// root project of CodeEditor have common parts with modules so we manage that here"
apply2 ""
apply3 settings.lib.gradle settings.common.gradle settings.root.gradle

cp -r "${g}/build/" "$O"
