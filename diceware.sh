#!/bin/bash

##
# diceware.sh
#
# Displays 5, 6 or 7 words passphrase with Diceware method
#
# Usage :
# diceware

# Pour un fonctionnement dans le répertoire :
# 1. Commenter 		ligne 16 : #source ~/MyEntranceHall/Maintenance/02-GitBashRC/MyPaths.sh
# 2. Commenter 		ligne 35 : #combination_space_word=`grep ${diceware_combinations} ${myPath012}diceware_fr.txt`
# 3. Décommenter 	ligne 36 : combination_space_word=`grep ${diceware_combinations} diceware_fr.txt`

source ~/MyEntranceHall/Maintenance/02-GitBashRC/MyPaths.sh

rollingDices() {
	diceware_combination=""
	for ((i = 1 ; i <= 5 ; i++)); do
		dice=$(($RANDOM%6))
		let dice+=1
		diceware_combination+=${dice}
	done
	# echo ${diceware_combination} équivalent au return ${diceware_combination} qui ne fonctionne pas en Bash
	# les retours de valeurs par les fonctions se faisant par des échos
	echo ${diceware_combination}
}

passPhrase() {
	echo ""
	passphrase=""
	for ((i = 1 ; i <= ${1} ; i++)); do
		diceware_combinations="$(rollingDices)"
		combination_space_word=`grep ${diceware_combinations} ${myPath012}diceware_fr.txt`
		#combination_space_word=`grep ${diceware_combinations} diceware_fr.txt`
		echo "${i} - ${combination_space_word}"
		word=`echo ${combination_space_word:6}` 
		if [[ ${i} -lt ${1} ]]
		then
			passphrase+=${word}"-"
		else
			passphrase+=${word}
		fi
	done

	case $1 in
		5) passphrase_5=${passphrase};;
		6) passphrase_6=${passphrase};;
		7) passphrase_7=${passphrase};;
	esac 

	echo ""
	echo -e "\033[0;40;31mPassPhrase ${1} de mots : \033[0;0;39m"
	echo -e "\033[0;40;32m${passphrase}\033[0;0;39m"
}

passPhrasesOnly() {
	echo ""
	echo ""
	echo -e "\033[0;40;31mPassPhrase 5,6 et 7 mots : \033[0;0;39m"
	echo -e "\033[0;40;32m${passphrase_5}\033[0;0;39m"
	echo -e "\033[0;40;32m${passphrase_6}\033[0;0;39m"
	echo -e "\033[0;40;32m${passphrase_7}\033[0;0;39m"
}

main() {
	#clear
	echo ""
	echo "******************************"
	echo "Méthode Diceware 5,6 et 7 mots"
	echo "******************************"
	passPhrase "5"
	passPhrase "6"
	passPhrase "7"
	passPhrasesOnly
}
#echo ${myPath012}
main

