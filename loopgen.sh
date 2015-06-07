#!/bin/bash
# grab the file text
file=$(<$1)
# trim filename to function name
fun=${1##*/}
fun=${fun%%.*}
# gen is generation function
gen="digraph $fun
{
    layout=circo;"
# fin is final function
fin=""
# get the number of inputs
num=$(head -n 1 <<< "$file")
if [ $num -lt 2 ]; then
    echo "Bad number of inputs."
    exit -1
fi
# increment the lines of the file
file=$(tail -n +2 <<< "$file")
# add all lines up to the first blank line
gen="$gen
    $(printf "$file" | awk '!p;/^$/{p=1}')"
# remove all lines before the first blank line
file=$(printf "$file" | awk '/^$/{p=1}p')
# begin producing character-based nodes
i=1
gen="$gen
    node0 "
while [ $i -lt $num ]; do
    # awk command gets character from number
    gen="$gen -> node$i"
    let i=i+1
done
#finish the loop
gen="$gen -> node0;
}"
# generate, replace circo layout reference, make positions absolute
gen=$(printf "$gen" | dot |
sed -e 's/layout=circo/layout=neato/' -e 's/\(pos=".*\)"/\1!"/g')
# remove trailing brace
gen=$(printf "$gen" | head -n -1)
fin="/* generated with loopgen.sh */
    $gen
    $file
}"

printf "$fin"
