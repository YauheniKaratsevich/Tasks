#!/bin/bash

# for entry in *
# do
# 	echo "$entry"
# done

# find . -type f

# find * -type f -printf '%f\n' | sort | uniq -dc
# find . -type f -printf '%p %f\n'
IFS=$'\n'
f=`find . -type f -printf '%p\n'`
echo "#!/bin/bash" >> log.txt
for file1 in $f
do
	for file2 in $f
	do
		if [ $(basename "$file1") == $(basename "$file2") ]; then		
			echo "####------------------| $(basename "$file1") |------------------" >> log.txt
			echo "#rm $file1" >> log.txt
			echo "#rm $file2" >> log.txt
		fi
	done
done
