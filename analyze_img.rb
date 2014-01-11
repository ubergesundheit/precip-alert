#!/usr/bin/env ruby

require 'oily_png'
require './time_reader'

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



# execute shell script to download
# and split the rain gif
%x{./get_rain.sh}


def parse_imgs
  time_reader = TimeReader.new
  time_first_img = time_reader.read_time
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
