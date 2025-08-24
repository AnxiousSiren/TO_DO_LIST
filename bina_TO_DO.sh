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
                sleep 0.2
        done

}




### ZOBRAZIT SEZNAM ÚKOLŮ ###

	cat_tasks() {	
	 echo "ᓚᘏᗢ -- SEZNAM ÚKOLŮ -- ᗢᘏᓗ "

	 had_any=false
	 for LIST_TASKU in "$PELECH"/*.conf; do
   	 [ -e "$LIST_TASKU" ] || break
   	 had_any=true

	 name=$(grep -m1 '^NAME=' "$LIST_TASKU"   | sed -E 's/^NAME="?([^"]*)"?/\1/')
   	 status=$(grep -m1 '^STATUS=' "$LIST_TASKU" | sed -E 's/^STATUS="?([^"]*)"?/\1/')

   	 # fallbacky, kdyby klíč chyběl
   	 : "${name:=<bez NAME>}"
   	 : "${status:=N}"

	 # porovnání case-insensitive
  	  if [[ "${status^^}" == "Y" ]]; then
      		mark='[X]'
   	  else
      		mark='[ ]'
   	  fi
	 	printf "%s %s\n" "$mark" "$name"
	  done

	  if ! $had_any; then
   		 echo "Nemáš zadané žádné úkoly."
	  fi
	  
	  echo
	  echo
	  echo "[DALŠÍ MOŽNOSTI]"
	  echo "[1] Označit úkol jako přečtený"
	  echo "[2] Založit nový task"
	  echo "[3] Smazat úkol"
	  echo "[4] Vrátit se na hlavní menu"
	  echo
	  read -r -p "KAM DÁL? [1-4]: " CESTAZLISTU
          echo
          case $CESTAZLISTU in
		  1) clear ; cat_ate_it ;;
		  2) clear ; atarashii_neko_task ;;
		  3) clear ; buried_in_sand ;;
		  4) clear ; cat_menu
	  esac
         clear
 }



### OZNAČIT ÚKOL JAKO SPLNĚNÝ ###

         cat_ate_it() {
	i=1
	CAT_SOUBOR=()
	for LIST_TASKU in "$PELECH"/*.conf; do
   		[ -e "$LIST_TASKU" ] || break
   		name=$(grep -m1 '^NAME=' "$LIST_TASKU"   | sed -E 's/^NAME="?([^"]*)"?/\1/')
   		status=$(grep -m1 '^STATUS=' "$LIST_TASKU" | sed -E 's/^STATUS="?([^"]*)"?/\1/')
   		: "${name:=<bez NAME>}"
   		: "${status:=N}"
   		[[ "${status^^}" == "Y" ]] && mark='[X]' || mark='[ ]'
   		printf "%d) %s %s\n" "$i" "$mark" "$name"
   		CAT_SOUBOR[$i]="$LIST_TASKU"
   		((i++))
	done

	if [ ${#CAT_SOUBOR[@]} -eq 0 ]; then
        	echo "Nemáš zadané žádné úkoly."
       		read -r -p "Pokračuj stiskem Enter..." _
       		clear
       		cat_menu
       		return
   	fi

	read -r -p "Zadej číslo úkolu, který chceš označit jako splněný: " PREPSAT_CAT
	CAT_TARGET="${CAT_SOUBOR[$PREPSAT_CAT]}"
   	if [ -n "$PREPSAT_CAT" ]; then
        # přepiše STATUS na Y
       		sed -i 's/^STATUS=.*/STATUS="Y"/' "$CAT_TARGET"
       		echo "Úkol označen jako splněný!"
   	 else
         echo "Neplatná volba."
    fi

	 cat_menu
}




### VYTVOŘIT NOVÝ ÚKOL ###

         atarashii_neko_task() {
         
         echo "ZVOLENÁ MOŽNOST: Vytvořit nový úkol! " 
	 echo
	 echo "Systémový název zadejte bez mezer a diakritiky (povoleno: a-z 0-9 . _ -).."

	# uživatel zadá systémový název	 
	 while :; do
	 read -r -p "Zadejte systémový název:" SYSCAT < /dev/tty
	 SYSCAT="${SYSCAT//[!a-z0-9._-]/_}"
	 	if [[ -z "$SYSCAT" || ! "$SYSCAT" =~ ^[a-z0-9._-]+$ ]]; then 
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
	 CATNAME_ESC=${CATNAME_ESC//\"/\\\"}
	 CATNAME_ESC=${CATNAME_ESC//\$/\\$}
	# založí soubor s vyplněným názvem a přidá hodnotu pro status úkolu + zahlásí error při chybě vytváření úkolu
       	{
  	 printf 'NAME="%s"\n' "$CATNAME_E"
 	 printf 'STATUS=N\n'
	 } > "$CATNIP" || { echo "Zápis selhal: $CATNIP"; read -r -p "Enter..." _; clear; cat_tasks; return 1; }

	# echo o zakončení vytváření nového úkolu
	 echo "Úkol založený: $CATNAME"
	 read -r -p "Pokračuj stiskem Enter..." _
	 clear
	# posunutí zpět na list tasků
	 cat_menu 
}




### SMAZAT ÚKOL ###

   	 buried_in_sand() {
    	 echo "Který úkol chceš smazat?"
    	 i=1
    	 CAT_SOUBOR=()
    	 NAMES=()

   	 for LIST_TASKU in "$PELECH"/*.conf; do
    		[ -e "$LIST_TASKU" ] || break
    		 name=$(grep -m1 '^NAME=' "$LIST_TASKU"   | sed -E 's/^NAME="?([^"]*)"?/\1/')
       		 status=$(grep -m1 '^STATUS=' "$LIST_TASKU" | sed -E 's/^STATUS="?([^"]*)"?/\1/')
       		 : "${name:=<bez NAME>}"
       		 : "${status:=N}"
       		 [[ "${status^^}" == "Y" ]] && mark='[X]' || mark='[ ]'
       		 printf "%d) %s %s\n" "$i" "$mark" "$name"
       		 CAT_SOUBOR[$i]="$LIST_TASKU"
       		 NAMES[$i]="$name"
       		 ((i++))
   	 done

   	 if [ ${#CAT_SOUBOR[@]} -eq 0 ]; then
       		 echo "Nemáš zadané žádné úkoly."
       		 read -r -p "Pokračuj stiskem Enter..." _
       		 clear
       		 cat_tasks
       		 return
   	 fi

   	 echo
   	 read -r -p "Zadej číslo úkolu ke smazání: " CAT_SMAZAT
   	 if [[ ! "$CAT_SMAZAT" =~ ^[0-9]+$ ]] || [ -z "${CAT_SOUBOR[$CAT_SMAZAT]}" ]; then
       		 echo "Neplatná volba."
       		 read -r -p "Pokračuj stiskem Enter..." _
       		 clear
       		 cat_tasks
       		 return
    	 fi

   	 RED_DOT="${CAT_SOUBOR[$CAT_SMAZAT]}"
   	 FLUFFY="${NAMES[$CAT_SMAZAT]}"

	# validace, jestli opravdu mažeme task (y/N - velké písmeno značí defaultní volbu pro případ, že to proenterujete) 
	 read -r -p "Opravdu smazat „$FLUFFY“? [y/N]: " ans
   	 if [[ ! "$ans" =~ ^([Yy]|[Aa])$ ]]; then
        	 echo "Zrušeno."
        	 read -r -p "Pokračuj stiskem Enter..." _
        	 clear
        	 cat_menu
        	 return
   	 fi

	 if rm -- "$RED_DOT"; then
         echo "Úkol smazán: $FLUFFY"
         else
         echo "Chyba: úkol se nepodařilo smazat."
         fi

         read -r -p "Pokračuj stiskem Enter..." _
         clear
         cat_menu
} 




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
	echo "############################## TADÁÁÁÁÁÁÁÁÁ! ################################"
	sleep 0.3 

# smyčka z menu k taskům a zpět

	cat_menu



