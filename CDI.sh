#!/bin/bash
echo "[INIT] Initialize CDI."

# funkcje
progexit(){
	read -p "Press Enter to close..."
	echo "[INFO] Close" 
	exit 1
}


# 1. sprawdzenie podania aplikascji
if [ -z "$1" ]; then
	echo "[ERR] Dismiss app name"
	progexit
fi

# 2. sprawdzenie scierzki

APP_NAME=$1
echo "[INFO] Get app name $APP_NAME"

APP_PATH=$(which $APP_NAME)


if [  -z "$APP_PATH"  ]; then
	echo "[ERR] No found $APP_PATH "
	progexit
else
	echo "[INFO] Find path: $APP_PATH"
fi


# Procesz przszukiwania grafik w celu znalezienia ikonki
echo "[PROC] Find one icon"

# moje ikonki
MY_ICONS_DB="/home/szarbotek/Pictures/Ico"

FINDICO=$(find "$MY_ICONS_DB" "/usr/share/$APP_NAME/" "/snap/$APP_NAME/" -type f \( -name "*$APP_NAME.png" -o -name "*$APP_NAME.svg" -o -name "*$APP_NAME.jpg"  -o -name "icon*" \)  2>/dev/null )
 #PROPICO=$(find "/snap/$APP_NAME/" -type f -name "*icon*" )
  
  i=1
while read -r K; do
   if [ -n "$K" ]; then
       echo "[$i]: $K"
	   ((i++))
    fi
done <<< "$FINDICO"
 
 #wybranie pierwszej ikonki
 SEARCH_ICON=$(head -n 1 <<< "$FINDICO")

# ustawienie w razie praku wynkiu ikonki systemowej
if [ -n "$SEARCH_ICON" ]; then
    ICON="$SEARCH_ICON"
	echo "[INFO] Find soecific ico file"
else
    echo "Use standard icon for file"
	ICON="utilities-terminal"
fi


# tworzenie odnosnika .desktop

DESKTOP_FILE="/home/szarbotek/Desktop/$APP_NAME.desktop"
echo "[INFO] Creat end file path"

cat <<EOF > "$DESKTOP_FILE"
[Desktop Entry]
Version=1.0
Type=Application
Name=$APP_NAME
Exec=$APP_PATH
Icon=$ICON
Terminal=false
Categories=Utility;
EOF

chmod +x "$DESKTOP_FILE"

# Oznaczenie pliku jako zaufanego (usuwa komunikat ze zdjęcia)