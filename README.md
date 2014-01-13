#Precipitation Alert

This is a set of ruby and shell scripts which does the following:
 - Download a set of images from a weather forecast website
 - Analyze the images
 - if there is a forecast for rain, send an alert via google hangouts

###Installation
 - run `bundle`
 - make a copy of the config example `cp config.yml.example config.yml`
 - edit the `config.yml` to your needs
 - run the script `send_precipitation.rb` or put it in your crontab `59 7-22 * * * PATH=$PATH:/usr/local/bin && bash -lc "/path/to/precip-alert/send_precipitation.rb"`
