
# [Projekt]: BININ TO DO LIST

### POPIS  
Lehká bashová aplikace pro správu úkolů pomocí jednoduchých .conf souborů. Běží v terminálu, má přehledné menu a volitelnou ASCII animaci kočky při startu.
Tento projekt byl vyvíjen a testován v prostředí:
- GNU Bash, version 5.2.21(1)-release (x86_64-pc-linux-gnu)
- Licence: [GNU GPL v3+](http://gnu.org/licenses/gpl.html)

> *Doporučujeme používat Bash verze 5.2 nebo novější, aby všechny funkce fungovaly správně.*


## Hlavní funkce
- Vytvoření úkolů
- Přepnutí stavu úkolů
- Smazání úkolů
- Zobrazení všech úkolů i s jejich stavem
- Skript používá **SCRIPT_DIR**, takže funguje odkudkoli (relativní cesty se dopočtou). Cesty a volby jsou v resources/values.sh.

## Instalace
**1. Naklonuj repozitář:** git clone https://github.com/AnxiousSiren/TO_DO_LIST && cd **TO_DO_LIST**
    > Pokud stahuješ aplikaci ve formátu ZIP, po rozbalení v Linux/MacOS si zachová práva. We Win je třeba přidat práva na spuštění: chmod +x ./bina_TO_DO.sh
**2. Nainstaluj si základní nástroje:** sed, grep, printf, cat, sleep, rm/mv, mkdir
**3. Zkontroluj práva:** Uděl spustitelné: **chmod +x ./bina_TO_DO.sh** pokud je třeba
**4. Spusť script:** ./bina_TO_DO.sh 
*5. Doporučené: vytvoř pro spuštění scriptu alias s absolutní cestou k místu, kde se nachází.*
> Př. alias bina='<tva_cesta_k_souboru>/bina_TO_DO.sh' 


## Struktura složek
**./bina_TO_DO.sh** hlavní skript  
**./resources/values.sh** cesty a proměnné  
**./graphics/** veškeré grafické položky (ASCII arty, source pro barvy)  
**./config/** složka pro konfigurační soubory úkolů (*.conf). 
**<nezmíněné>** repo obsahuje i soubory navíc, které jsou předpřipravené pro další update aplikace

## Způsob použití
Spusť script a v menu vybírej akce a nebo po vyzván vkládej hodnoty.

## Roadmap
- **Validace po spuštění:** V případě, že neexistuje žádný úkol při spuštění scriptu, aplikace vyzve uživatele k vytvoření nového úkolu
- **Vizuální update:**  Barevné rozlišení pro větší přehlednost, stylizace
- **Validace vstupů:** Momentálně je tvrdá validace pouze u zakládání nového úkolu, plán je rozšířit ji na celou aplikaci, aby si uživatel při zadání neočekávaného znaku nevypnul aplikaci
- **Přidání popisků úkolů:** Aplikace je napsaná s vizí zapisování detailů/popisků ke konkrétnímu úkolu, s tím přijde i feature zobrazit si detail úkolu.
- **Soft delete:** Při smazání úkolu se jeho konfigurační soubor přesune do koše, ze kterého bude možné ho i obnovit, pokud mezi úkoly nebude existovat úkol se stejným systémovým názvem (případně vyzve ke změně systémového názvu). Přibude feature **Obnovení smazaného úkolu**.  
- **Změna úkolu na nesplněný:** Pro případy, kdy chybně označíte úkol, který chcete označit jako splněný, použijete funkci změny nebo vybrání stavu úkolu (přibude varianta změny stavu úkolu na nesplněný).

## Licence
Binin TO DO LIST je open source a volně použitelný.

## Changelog
**24/08/2025 v. 1.0** První verze Binina TO DO LISTu s možnostmi zakládat úkoly, označit je jako splněné, mazat úkoly a vylistovat si seznam, kde jsou viditelně odlišené úkoly, které jsou již splněné. 
