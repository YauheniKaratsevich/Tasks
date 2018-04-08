#!/bin/bash

if [[ "$#" -eq 0 ]]; then
	mode="by_name"
elif [[ "$#" -eq 1 && "$1" == "name" ]]; then
	mode="by_name"
elif [[ "$#" -eq 1 && "$1" == "cont" ]]; then
	mode="by_cont"
else
	echo "Error: invalid arguments"
	exit 1
fi

IFS=$'\n'
# f=`find . -type f -printf '%p\n'`
f=`find . -type f | rev | sort | rev`
script_file="rm_dups.sh"
echo "#!/bin/bash" > $script_file
#-----------------------name-----------------------------------------------
if [ $mode == "by_name" ]; then
	echo "##### BY NAME ######" >> $script_file

	#remove unique file names
	result="uniq"
	for file1 in $f
	do
		for file2 in $f
		do
			if [ "$file1" != "$file2" ]; then	#not file itself
				if [ $(basename "$file1") == $(basename "$file2") ]; then	
					result="not_uniq"
					break
				fi
			fi
		done

		if [[ "$result" == "uniq" ]]; then
			f=${f/$file1}
		fi

		result="uniq"
	done

	#output in a file
	previous_file_name="/"
	for current_file_name in $f
	do
		if [ $(basename "$previous_file_name") != $(basename "$current_file_name") ]; then	
			printf "%s\n" "####------------------| $(basename "$current_file_name") |------------------" >> $script_file
		fi	

		printf "#rm %q\n" "$current_file_name" >> $script_file
		previous_file_name=${current_file_name}
	done

	echo $f
	exit 1

fi

#-----------------------cont-----------------------------------------------
if [ $mode == "by_cont" ]; then
	echo "#####  DONE BY CONTENT ##### " >> $script_file
	for file1 in $f
	do
		for file2 in $f
		do
			if [ "$file1" != "$file2" ]; then	#not file itself
				if cmp -s "$file1" "$file2"; then		
					printf "%s\n" "####------------------| $(basename "$file1") |------------------" >> $script_file
					printf "#rm %q\n" "$file1" >> $script_file
					printf "#rm %q\n" "$file2" >> $script_file
				fi
			fi
		done
	done
	exit 1
fi
