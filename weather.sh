#!/bin/bash
API_KEY="Have to replace with open weather api key"

LOCATION="$1"

URL="https://api.openweathermap.org/data/2.5/weather?q=$LOCATION&appid=$API_KEY&units=metric"

weather_data=$(wget -qO- "$URL")

temp=$(echo "$weather_data" | awk -F'[,:]' '/"temp":/{print $19}')
weather_description=$(echo "$weather_data" | awk -F'"' '/weather/ {print $14}')
humidity=$(echo "$weather_data" | awk -F'[,:]' '/"humidity":/{print $29}')
wind_speed=$(echo "$weather_data" | awk -F'[,:]' '/"speed":/{print $34}')


get_activity_recommendation() {
    local weather_description="$1"
    local temp="$2"
    local wind_speed="$3"

    if echo "$weather_description" | grep -qi "rain"; then
        echo "It's raining, you should stay at home. If you need to go out, bring your umbrella"
    elif [[ "$temp" -gt 25 ]]; then
        echo "It's hot, you should go out swimming, eat an ice cream"
    elif [[ "$wind_speed" -gt 10 ]]; then
        echo "It's windy, maybe flying your kites!"
    else
        echo "Great day for outdoor activities like hiking, cycling, or picnicking!"
    fi
}
activity=$(get_activity_recommendation "$weather_description" "$temp" "$wind_speed")

echo "Weather summary for $LOCATION at Time: $(date)"
echo "Temperature: $temp°C"
echo "Condition: $weather_description"
echo "Humidity: $humidity%"
echo "Wind speed: $wind_speed m/s"
echo "Activity Recommendation: $activity"
echo "" 