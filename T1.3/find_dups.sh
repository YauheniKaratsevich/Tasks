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
script_file="rm_dups.sh"
echo "#!/bin/bash" > $script_file
#-----------------------name-----------------------------------------------
if [ $mode == "by_name" ]; then
	echo "##### BY NAME ######" >> $script_file

	f=`find . -type f | rev | sort | rev`
	
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

	exit 1
fi

#-----------------------cont-----------------------------------------------
if [ $mode == "by_cont" ]; then
	echo "#####  DONE BY CONTENT ##### " >> $script_file

	f=`find . -type f -exec md5sum {} \; | sort`

	#remove unique md5
	result="uniq"
	for file1 in $f
	do
		current_file1_md5=${file1:0:34}
		current_file1_name=${file1/${current_file1_md5}}

		for file2 in $f
		do
			current_file2_md5=${file2:0:34}
			current_file2_name=${file2/${current_file2_md5}}	

			if [ "$current_file1_name" != "$current_file2_name" ]; then	#not file itself
				if [ "$current_file1_md5" == "$current_file2_md5" ]; then	
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
	previous_file_md5="0"
	previous_file_name="/"
	for current_string in $f
	do
		current_file_md5=${current_string:0:34}
		current_file_name=${current_string/${current_file_md5}}

		if [ "$previous_file_md5" != "$current_file_md5" ]; then	
			printf "%s\n" "####------------------| MD5: $current_file_md5 |------------------" >> $script_file
		fi	

		printf "#rm %q\n" "$current_file_name" >> $script_file
		
		previous_file_md5=${current_file_md5}
		previous_file_name=${current_file_name}
	done

	exit 1
fi
