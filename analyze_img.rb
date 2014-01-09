#!/usr/bin/env ruby

require 'oily_png'


# hard coded values for regenradar images from wetteronline.de

@rain_strengths = {
  # :kein_regen => '#d4d6d4',
    :leicht     => "#acfefc",
    :mäßig    => "#54d2fc",
    :mäßiger  => "#2caafc",
    :stark      => "#1c7edc",
    :stärker   => "#9c329c",
    :"sehr stark" => "#fc02fc"
}

@pixels_to_check = [
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
    elsif hex(image[26,17]) == white # 6
      second = 6
    else
      second = 1
    end
  elsif hex(image[22,15]) == white # 3 or 8
    if hex(image[20,13]) == white
      second = 8
    else
      second = 3
    end
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

  now = Time.now
  Time.new(now.year, now.month, now.day, "#{first}#{second}".to_i, minutes)
end 

# execute shell script to download
# and split the rain gif
%x{./get_rain.sh}


def parse_imgs
  time_first_img = parse_time
  result = {}

  # discard first & second image and look at the rest of the images
  (1..8).each do |i|
    image = ChunkyPNG::Image.from_file("tmp/regen_#{i}.png")
 
    current_img_result = []

    @pixels_to_check.each do |coords|
      pixel_color = hex(image[coords[0],coords[1]])
      if @rain_strengths.values.include?(pixel_color)
        current_img_result << @rain_strengths.values.find_index(pixel_color)
      end
    end

    # make items in the array unique
    current_img_result.uniq!

    result[time_first_img + 900*i] = current_img_result.sort if current_img_result != []
  end
  result
end

def make_human_readable(times)
  puts times
  output = ""
  times.each do |time,strength|
      current_result_string = "#{@rain_strengths.keys[strength[0]]}er"
      current_result_string << " bis #{@rain_strengths.keys[strength[1]]}er" if strength.size == 2
      current_result_string << " Regen"
      
      current_result_string << " in #{time}\n"
      output << current_result_string
  end
  output
end

puts make_human_readable(parse_imgs)
