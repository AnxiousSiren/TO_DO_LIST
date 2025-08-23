#!/bin/bash
# Projekt IT Administrator: To Do List

# Script může odkazovat na potřebné soubory bez ohledu na to, ve které složce ho spustíme
	SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"


###########################################################
######################## SOURCE ###########################

# BARVIČKY
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
	 cat 


         cat_menu
 }




### VYPSAT POZNÁMKY K ÚKOLU ###

         el_gato_task() {



	cat_tasks	 
}




### OZNAČIT ÚKOL JAKO SPLNĚNÝ ###

         cat_ate_it() {


	 cat_tasks
}




### VYTVOŘIT NOVÝ ÚKOL ###

         atarashii_neko_task() {
         
         echo "ZVOLENÁ MOŽNOST: Vytvořit nový úkol! " 
	 echo
	 echo "Systémový název zadejte bez mezer a diakritiky (povoleno: a-z 0-9 . _ -).."

	# uživatel zadá systémový název	 
	 while :; do
	 read -r -p "Zadejte systémový název:" SYSCAT
	 SYSCAT="${SYSCAT//[!a-z0-9._-]/_}"
	 	if [[ ! "$SYSCAT" =~ ^[a-z0-9._-]+$ ]]; then
    	 		echo "Neplatný název. Povolené znaky: a-z 0-9 . _ -"
    			return 1
	 	fi
	# systémový název nemůže být prázdný
		if [[ -z "$SYSCAT" ]]; then
    			echo "Název nesmí být prázdný."; continue
  		fi

	# povolené znaky: a-z 0-9 . _ -
  		if [[ ! "$SYSCAT" =~ ^[a-z0-9._-]+$ ]]; then
    			echo "Systémový název obsahuje nepovolené znaky."
    			continue
 		fi

        # Zkontroluje, jestli už neexistuje úkol se stejným systémovým názvem
         echo "Kontrola duplicity:" 	
        # výsledný config nově založeného úkolu
         local CATNIP="$PELECH${SYSCAT}.conf"
	 	if [[ -e "$CATNIP" ]]; then
    		echo "Úkol s tímto systémovým názvem už existuje."; continue
 		 fi
	# všechno proběhlo v pořádku
	 break 

	done


	# název tasku s diakritikou - bude se zobrazovat v seznamu úkolů
	 read -r -p "Zadejte název úkolu s diakritikou: " CATNAME
	# escapování / zbavení se speciálních znaků
	 CATNAME_E=${CATNAME//\\/\\\\}
	 CATNAME_E=${CATNAME_E//\"/\\\"}
	 CATNAME_E=${CATNAME_E//\$/\\$}
	# založí soubor s vyplněným názvem a přidá hodnotu pro status úkolu
	 {
  	 printf 'NAME="%s"\n' "$CATNAME_E"
 	 printf 'STATUS=N\n'
	 } > "$CATNIP"

	# přidání detailů k úkolu
	 echo "DETAILS: piš text (více řádků). Ukonči řádkem: END"
	 CATNOTES=""
	 while IFS= read -r line; do
		  [[ $line == END ]] && break
		  CATNOTES+="$line"$'\n'
	  done
	 
        # další odpreparování spešl znaků  
         NOTES_E=${NOTES//\\/\\\\}
	 NOTES_E=${DETAILS_E//\"/\\\"}
	 NOTES_E=${DETAILS_E//\$/\\$}
	 
	# zapíše výstup do configu úkolu
	 printf 'DETAILS="%s"\n' "$DETAILS_E" >> "$CATNIP"
	
	 
	 clear
	
	# echo o zakončení vytváření nového úkolu
	 echo "Úkol založený: $CATNAME_E"

	# posunutí zpět na list tasků
	 cat_tasks 
}




### SMAZAT ÚKOL ###

#         buried_in_sand() {

#} 




### VYPNOUT TASKMASTER ###

#         so_long_kitty() {

#}




### ROZCESTNÍK MENU ###

        cat_menu() {
        cat $MENU_MIAW
        echo    
        read -p "ZADEJ [1-5]: " WHISKERS
        echo
        case $WHISKERS in
                1) cat_tasks ;;
                2) el_gato_task ;;
                3) cat_ate_it ;;
                4) atarashii_neko_task ;;
                5) buried_in_sand ;;
                6) so_long_kitty
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
	echo
	echo
	sleep 2 

# smyčka z menu k taskům a zpět

	cat_menu



