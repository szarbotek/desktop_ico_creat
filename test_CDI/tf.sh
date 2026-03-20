APP_NAME="inkscape"

echo "[PROC] Find one icon"

FINDICO=$(find "/usr/share/$APP_NAME/" "/snap/$APP_NAME/" -type f \( -name "*$APP_NAME.png" -o -name "*$APP_NAME.svg" -o -name "*$APP_NAME.jpg"  -o -name "icon*" \)  2>/dev/null )
 #PROPICO=$(find "/snap/$APP_NAME/" -type f -name "*icon*" )
  
  i=1
while read -r K; do
   if [ -n "$K" ]; then
       echo "[$i]: $K"
	   ((i++))
    fi
done <<< "$FINDICO"
 
 
 ICON=$(head -n 1 <<< "$FINDICO")
 


#while read -r K; do
#   if [ -n "$K" ]; then
#       echo "Open graphic: $K"
#        xdg-open "$K" &
#        sleep 0.5
#    fi
#done <<< "$PROPICO"

###| head -n 1
