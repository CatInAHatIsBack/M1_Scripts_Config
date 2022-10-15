item_re="^(Directory .*):$"


# targetDir=~/Desktop/code/M1_Scripts_Config
# targetDir= cat $PWD/dir.txt
targetDir=$( cat $PWD/dir.txt | xargs )
echo targetDir
mySave=$targetDir/file.txt
echo mySave
  

currDir=$(pwd)
mySave=$targetDir/file.txt
prefix="Directory"


do_sed() {
	# sed 'Directory src/a test' 
	do_check "$1" 
	# echo "$currDir/${file} after sed"
}
do_check(){
	while read -r; do
		if [[ $REPLY =~ $item_re ]]; then
			item=${BASH_REMATCH[1]}
			# echo "$item"
		else
			# echo "$item"
			# echo "${REPLY:10}"
			if [[ ${item:10} == $1 ]]; then
				# sed -i "/$prefix $1/a $currDir/${file}" $mySave
				# echo "succes"
				# return	
				gsed -i "/$prefix $1/a $currDir/${file}" $mySave
				echo "${file}"
				echo "heaf"
				echo "succes"
				return	
			fi
		fi
	done < $mySave 
	echo "no such dir"
}
make_dir(){
	echo "$prefix $1:" >> $mySave
	echo "" >> $mySave
}

printer(){
	# echo "sd" >> $mySave
	echo "-f specify file. must me used before i"
	echo "-i insert below dir"
	echo "-d make new dir "
	echo "-u update"
}

makeUpdate(){
	while read -r; do
		# echo $item
		if [[ $REPLY =~ $item_re ]]; then
			# item=${BASH_REMATCH[1]}
			echo "hello"
		else
			# from $REPLY abs path
			# printf "from: %s\n" "${REPLY}"
				
			# to targetDir + name
			# printf "to: ${targetDir}%s\n" "${item:10}"
			# printf "\n"

			# rsync -a /$currDir/${file} $targetDir/${name}
			#			from				to 
			# echo $REPLY
			rsync -a $REPLY ${targetDir}${item:10}/
		fi
	done < $mySave
	cd $targetDir
	git add .
	git commit -m "autosync commit"
	git push
}
while getopts ":f:i:d:hu" aflag; do 
	case ${aflag} in 
		f) file=$OPTARG;;				# specify file. must use before i
		i) do_sed "$OPTARG";;			# insert below specified dir
		d) make_dir "$OPTARG";;			# make new dir
		h) printer ;;
		u) makeUpdate;; 
	esac
done
echo "file path $currDir/${file}"

