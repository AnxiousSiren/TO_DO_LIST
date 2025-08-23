#!/bin/bash
# Projekt IT Administrator: To Do List

# Script může odkazovat na potřebné soubory bez ohledu na to, ve které složce ho spustíme
	SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"


###########################################################
######################## SOURCE ###########################

# BARVIČKY - předpřipraveno pro nástavbu
	source "./graphics/colors.sh"

# PROMĚNNÉ	
	source "./resources/values.sh"


###########################################################
######################## FUNKCE ###########################



### ANIMACE PŘI SPUŠTĚNÍ TASKMASTERA ###
	
	bigus_catus_animatus() {
	for i in $(cat $BIGUS_CATUS_ANIM);
        
	do
		clear
                cat $BIG_CATWALK$i
                sleep 0.3
        done

}




### ZOBRAZIT SEZNAM ÚKOLŮ ###

	cat_tasks() {	
#	 echo "SEZNAM ÚKOLŮ!"
#	 ls -la $PELECH | awk '{print $9}'  | grep ".conf" > $LIST_MIAW

 	 # kontrola, jestli je ve složce s configy vůbec nějaký config
#	  if [ ! -s "$LIST_MIAW" ]; then    
#   	 	 echo "Nemáš zadané žádné úkoly."
#   	 	 read -r -p "Pokračuj stiskem Enter..." _ 
#		 clear; continue
# 	  fi
	  echo "SEZNAM ÚKOLŮ!"
	  local dir="${PELECH%/}"

 	 # jsou tam nějaké .conf?
 	  set -- "$dir"/*.conf
 	  if [ ! -e "$1" ]; then
   		 echo "Nemáš zadané žádné úkoly."
   		 read -r -p "Pokračuj stiskem Enter..." _ < /dev/tty
   		 clear; cat_menu; return
 	 fi

	 # vypsání seznamu úkolů
#	  for TASK_MEOW in $(cat $LIST_MIAW); do 
	  local i=0
	  local TASK_MEOW NAME STATUS
	  for TASK_MEOW in "$@"; do
	  	i=$((i+1)) 
	        unset NAME STATUS	
	 # přeskoč neexistující nebo prázdné řádky
# 	 	 [[ -f "$TASK_MEOW" ]] || continue
		source "$TASK_MEOW" 2>/dev/null || continue

	# defaultní hodnota pro proměnnou STATUS (v configu jednotlivých tasků)
 		 : "${STATUS:=N}"

 		 if [[ "${STATUS^^}" == "N" ]]; then
   	 # nedokončené úkoly: tyrkysově
   			 printf "${TEAL2}" "$NAME" "${BB}"
		 else
   	 # dokončené úkoly: fialově + kočička
   			 printf "${PURP2}" "≽^•⩊•^≼" "$NAME" "${BB}"
 		 fi
 	  done 
	 read -r -p "Pokračuj stiskem Enter..." _
         clear
         cat_menu
 }



### OZNAČIT ÚKOL JAKO SPLNĚNÝ ###

#         cat_ate_it() {


#	 cat_tasks
#}




### VYTVOŘIT NOVÝ ÚKOL ###

         atarashii_neko_task() {
         
         echo "ZVOLENÁ MOŽNOST: Vytvořit nový úkol! " 
	 echo
	 echo "Systémový název zadejte bez mezer a diakritiky (povoleno: a-z 0-9 . _ -).."

	# uživatel zadá systémový název	 
	 while :; do
	 read -r -p "Zadejte systémový název:" SYSCAT < /dev/tty
	 SYSCAT="${SYSCAT//[!a-z0-9._-]/_}"
	 	if [[ ! "$SYSCAT" =~ ^[a-z0-9._-]+$ ]]; then
    	 		echo "Neplatný název. Povolené znaky: a-z 0-9 . _ -"
    			continue
	 	fi
	# systémový název nemůže být prázdný
		if [[ -z "$SYSCAT" ]]; then
    			echo "Název nesmí být prázdný."; continue
  		fi
        # Zkontroluje, jestli už neexistuje úkol se stejným systémovým názvem
         echo "Kontrola duplicity:" 	
        # výsledný config nově založeného úkolu
         local CATNIP="$PELECH${SYSCAT}.conf"
	 	if [[ -e "$CATNIP" ]]; then
    		echo "Úkol s tímto systémovým názvem už existuje."; continue
 		 fi
	# všechno proběhlo v pořádku
	 echo "Je to OK! Neexistuje úkol se stejným systémovým názvem."
	 break 

	 done


	# název tasku s diakritikou - bude se zobrazovat v seznamu úkolů
	 read -r -p "Zadejte název úkolu s diakritikou: " CATNAME < /dev/tty
	# escapování / zbavení se speciálních znaků
	 CATNAME_E=${CATNAME//\\/\\\\}
	 CATNAME_E=${CATNAME_E//\"/\\\"}
	 CATNAME_E=${CATNAME_E//\$/\\$}
	# založí soubor s vyplněným názvem a přidá hodnotu pro status úkolu + zahlásí error při chybě vytváření úkolu
	 {
  	 printf 'NAME="%s"\n' "$CATNAME_E"
 	 printf 'STATUS=N\n'
	 } > "$CATNIP" || { echo "Zápis selhal: $CATNIP"; return 1; }

	# echo o zakončení vytváření nového úkolu
	 echo "Úkol založený: $CATNAME_E"
	 read -r -p "Pokračuj stiskem Enter..." _
	 clear
	# posunutí zpět na list tasků
	 cat_tasks 
}




### SMAZAT ÚKOL ###

#         buried_in_sand() {

#} 




### VYPNOUT TASKMASTER ###

         so_long_kitty() {
          sleep 0.2
	  clear
 	  exit 0
}




### ROZCESTNÍK MENU ###

        cat_menu() {
        cat $MENU_MIAW
        echo    
        read -p "ZADEJ [1-5]: " WHISKERS
        echo
        case $WHISKERS in
                1) cat_tasks ;;
                2) cat_ate_it ;;
                3) atarashii_neko_task ;;
                4) buried_in__sand ;;
                5) so_long_kitty
        esac

}

########################## START ###########################
##################### HLAVNÍHO SCRIPTU #####################

# úvodní sekvence
	clear
	echo "Vítej v Bínině TO DO LISTU!"
	sleep 2
	echo
	echo
	echo "Spouštění systému za..."
	sleep 1
	echo "3"
	sleep 1
	echo "2"
	sleep 1
	echo "1"
	sleep 1
	echo "..."
	sleep 1
	clear
	sleep 1

# animace čičiny
	bigus_catus_animatus
	sleep 2
	echo "############################## TADÁÁÁÁÁÁÁÁÁ! ################################"
	sleep 2 

# smyčka z menu k taskům a zpět

	cat_menu



