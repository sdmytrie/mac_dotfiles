sketchybar --set $NAME \
    label="Loading..." \
    icon.color=0xff5edaff

# fetch weather data
LOCATION="sarreguemines"
REGION=""
LANG="fr"

# Line below replaces spaces with +
LOCATION_ESCAPED="${LOCATION// /+}+${REGION// /+}"
WEATHER_JSON=$(curl -s "https://wttr.in/$LOCATION_ESCAPED?0pq&format=j1&lang=$LANG")

# Fallback if empty
if [ -z $WEATHER_JSON ]; then
    sketchybar --set $NAME label="$LOCATION"
    return
fi

TEMPERATURE=$(echo $WEATHER_JSON | jq '.current_condition[0].temp_C' | tr -d '"')
#WEATHER_DESCRIPTION=$(echo $WEATHER_JSON | jq '.current_condition[0].weatherDesc[0].value' | tr -d '"' | sed 's/\(.\{16\}\).*/\1.../')
WEATHER_DESCRIPTION=$(echo $WEATHER_JSON | jq '.current_condition[0].lang_fr[0].value' | tr -d '"' | sed 's/\(.\{26\}\).*/\1.../')
HUMIDITY=$(echo $WEATHER_JSON | jq '.current_condition[0].humidity' | tr -d '"')
PRESSURE=$(echo $WEATHER_JSON | jq '.current_condition[0].pressure' | tr -d '"')
sketchybar --set $NAME \
    label="$TEMPERATURE$(echo '°')C • $WEATHER_DESCRIPTION • $HUMIDITY % • $PRESSURE hPa"
