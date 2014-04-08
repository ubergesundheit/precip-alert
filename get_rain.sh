#!/bin/bash

mkdir -p tmp
#wget --quiet -O "tmp/tmp.gif" "http://www.wetteronline.de/?pid=p_radar_map&ireq=true&src=radar/vermarktung/p_radar_map_forecast/forecastLoop/NRW/latestForecastLoop.gif"
curl 'http://www.wetteronline.de/?pid=p_radar_map&ireq=true&src=radar/vermarktung/p_radar_map_forecast/forecastLoop/NRW/latestForecastLoop.gif' -H 'Accept-Encoding: gzip,deflate,sdch' -H 'Accept-Language: en-US,en;q=0.8,de;q=0.6' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Cache-Control: max-age=0' -H 'Connection: keep-alive' --silent -o tmp/tmp.gif
gm convert tmp/tmp.gif -coalesce +adjoin tmp/regen_%d.png
