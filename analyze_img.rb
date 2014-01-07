#!/usr/bin/env ruby

require 'chunky_png'

%x{./get_rain.sh}

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
	[248,167],
	[252,167],
	[248,171],
	[252,171]
]

8.times do |i|
  image = ChunkyPNG::Image.from_file("tmp/regen_#{i}.png")

  pixels_to_check.each do |coords|
    pixel_color = ChunkyPNG::Color.to_hex(image[coords[0],coords[1]], false)
    if rain_strengths.values.include?(pixel_color)
      puts "regen!! #{rain_strengths.key(pixel_color)}"
    end
  end
end
