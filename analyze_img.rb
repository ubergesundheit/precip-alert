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
  if hex(image[11,15]) == white # first digit is a 0
    first = 0
  elsif hex(image[14,15]) == white # first digit is a 1
    first = 1
  else # only digit left: 2
    first = 2
  end

  # second digit: check for 0 to 9
  if hex(image[27,17]) == white # 4
    second = 4
  elsif hex(image[20,15]) == white # 0 or 5
    if hex(image[26,11]) == white
      second = 5
    else
      second = 0
    end
  elsif hex(image[25,20]) == white # 1 or 2
    if hex(image[26,20]) == white
      second = 2
    else
      second = 1
    end
  elsif hex(image[22,15]) == white # 3 or 8
    if hex(image[20,13]) == white
      second = 8
    else
      second = 3
    end
  elsif hex(image[26,17]) == white # 6
    second = 6
  elsif hex(image[20,11]) == white # 7
    second = 7
  else
    second = 9
  end

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

  ["#{first}#{second}".to_i, minutes]
end 

# execute shell script to download
# and split the rain gif
%x{./get_rain.sh}

start_time = parse_time

# discard first & second image and look at the rest of the images
(2..8).each do |i|
  image = ChunkyPNG::Image.from_file("tmp/regen_#{i}.png")
  # puts "regen#{i} #{image.dimension.inspect}"
  # puts parse_time(image)
  pixels_to_check.each do |coords|
    pixel_color = hex(image[coords[0],coords[1]])
    if rain_strengths.values.include?(pixel_color)
      puts "regen!! #{rain_strengths.key(pixel_color)}"
    end
  end
end
