#!/bin/bash

mkdir -p tmp
wget --quiet -O "tmp/tmp.gif" "http://www.wetteronline.de/?pid=p_radar_map&ireq=true&src=radar/vermarktung/p_radar_map_forecast/forecastLoop/NRW/latestForecastLoop.gif"
gm convert tmp/tmp.gif -coalesce +adjoin tmp/regen_%d.png
