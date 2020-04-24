#!/bin/bash

# get argument
folder=$1
if [ "$folder" = "" ];
then
	echo "Usage: $1 <pptx exploded folder>"
	return 1
fi

# masters that we rename
matches=(Covers Sections Hybrids Custom Endings)
echo "Master templates starting with these words will be renumbered: ${matches[*]}"

# init
count=0
declare -a indices
cd $folder

# make sure we get layouts in natural order
for layout in ppt/slideLayouts/slideLayout{1..999}.xml;
do

	# check if file exists
	if [ ! -f $layout ]; then
		continue
	fi

	# get filename
	filename=$(basename $layout)

	# find master
	master=$(grep -r -l $filename ppt/slideMasters/_rels)
	master=$(basename $master)

	# get theme
	number=$(echo $master | sed -e s/[a-zA-Z\.]//g)
	theme=ppt/theme/theme${number}.xml

	# get name
	name=$(tail -1 $theme | cut -d '=' -f 3 | cut -d '"' -f 2)
	word=$(echo $name | cut -d ' ' -f 1)

	# some masters are named manually
	if [[ " ${matches[*]} " == *" $word "* ]]; then

		# get index
		index=${indices[$number]}
		if [ "$index" == "" ]; then
			index=1
		fi

		# replace
		pattern="s/p:cSld name=\"[^\"]*\"/p:cSld name=\"$name $index\"/g"
		sed -i '' -e "$pattern" $layout

		# increment
		indices[$number]=$((index+1))
		count=$((count+1))

	fi

done

echo "${count} layout(s) updated!"
