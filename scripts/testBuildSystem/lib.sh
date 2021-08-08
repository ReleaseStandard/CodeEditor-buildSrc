success=0
failure=0
function printSuccess() {
	printf "[\033[01;32mSUCCESS\033[0m] $1\n"
}
function printFail() {
	printf "[\033[01;31mFAILURE\033[0m] $1\n"
}
function assert() {
        local rv="$?"
        if ( [ "$3" = "" ] && [ "$rv" -eq "0" ] ) || ( [ "$2" = "$3" ] && ! [ "$3" = "" ] ) ; then
		printSuccess "$1"
                ((success=success+1))
                return 0
        fi
        echo "RESULTS"
        echo " $2"
        echo "EXPECTED"
        echo " $3"
	printFail "$1"
        ((failure=failure+1))
        return 1
}
function init() {
        echo "Launching tests ..."
}
function finit() {
        if [ "$failure" -eq "0" ] ; then
                echo "Tests done failure=${failure}, success=${success}"
        else
                echo "Tests failure failure=${failure}, success=${success}"
        fi
}
