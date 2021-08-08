#!/bin/bash
#
# Test the build system for modules
#

#
# Include other scripts
#
scriptPath="$(pwd)/$0"
file="${scriptPath/*\//}"
folder="${scriptPath/${file}/}"
source "${folder}/lib.sh"
if [ "$REMOTE" = "" ] ; then r=false ; else r=true ; fi

init

./gradlew -q newVersion || ( printFail "newVersion" )
printSuccess "newVersion"
./gradlew -q projects || ( printFail "projects" )
printSuccess "projects"
$r && assert "send to MavenCentral" "$(./gradlew assemble && ./gradlew produceBigJar && ./gradlew --stacktrace --info --debug publishToSonatype closeAndReleaseStagingRepository)"
assert "assemble the project" "$(./gradlew assemble)"
find -name "*.jar"

./gradlew produceBigJar
arch="build/libs/CodeEditor-logger-debug-$(./gradlew version -q).jar"
content=$(unzip -l $arch)
FILES=($(find -name "*.java"))
for f in "${FILES[@]}" ; do
	ffile="${f/*\//}"
	ffolder="${f/${ffile}/}"
	fclass="${ffile/.java/}"
	echo "$content" |grep "$fclass"
	if [ "$?" -ne "0" ] ; then printFail "$f not found in the final archive" ; fi
done
printSuccess "produceBigJar"

echo "content=$content"
#assert "all classes are included" "$(true)"
finit
