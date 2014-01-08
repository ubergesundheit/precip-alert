#!/usr/bin/env ruby

require 'chunky_png'


# hard coded values for regenradar images from wetteronline.de

rain_strengths = {
  # :kein_regen => '#d4d6d4',
    :leicht     => "#acfefc",
    :maessig    => "#54d2fc",
    :maessiger  => "#2caafc",
    :stark      => "#1c7edc",
    :staerker   => "#9c329c",
    :sehr_stark => "#fc02fc"
}

pixels_to_check = [
	[249,168],
	[253,168],
	[249,172],
	[253,172]
]

def hex(pixel)
  ChunkyPNG::Color.to_hex(pixel, false)
end

def parse_time(image = ChunkyPNG::Image.from_file("tmp/regen_0.png"))
  white = "#fcfafc"
  
  # first digit: check for 0,1,2

  # second digit: check for 0 to 9

  # third digit: check for 0,1,3,4
  # is it a 4?
  if hex(image[42,17]) == white
    minutes = 45
  elsif hex(image[38,15]) == white # either a 1 or 3
    if hex(image[41,13]) == white # its a 3
      minutes = 30
    else
      minutes = 15
    end
  else # its a 0
    minutes = 0
  end

  minutes
end 

# execute shell script to download
# and split the rain gif
%x{./get_rain.sh}


# discard first image and look at the rest of the images
(1..8).each do |i|
  image = ChunkyPNG::Image.from_file("tmp/regen_#{i}.png")
  puts "regen#{i} #{image.dimension.inspect}"
  puts parse_time(image)
  pixels_to_check.each do |coords|
    pixel_color = hex(image[coords[0],coords[1]])
    if rain_strengths.values.include?(pixel_color)
      puts "regen!! #{rain_strengths.key(pixel_color)}"
    end
  end
end
