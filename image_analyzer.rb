class ImageAnalyzer

  require 'oily_png'
  require './time_reader'
  
  # hard coded values for regenradar images from wetteronline.de
  
  @@rain_strenghts = {
    # :kein_regen => '#d4d6d4',
      :leicht     => "#acfefc",
      :mäßig    => "#54d2fc",
      :mäßiger  => "#2caafc",
      :stark      => "#1c7edc",
      :stärker   => "#9c329c",
      :"sehr stark" => "#fc02fc"
  }
  
  @@pixels_to_check = [
  	[249,168],
  	[253,168],
  	[249,172],
  	[253,172]
  ]
  
  def hex(pixel)
    ChunkyPNG::Color.to_hex(pixel, false)
  end
 
  def time_difference(time)
    now = Time.now
    case ((time - now) / 60)
      when 0..22.5 then "einer viertel Stunde"
      when 22.6..37.5 then "einer halben Stunde"
      when 37.6..52.5 then "einer Stunde"
      when 52.6..67.5 then "einer Stunde und 15 Minuten"
      when 67.6..82.5 then "anderthalb Stunden"
      when 82.6..97.5 then "einer Stunde und 45 Minuten"
      when 97.6..112.5 then "zwei Stunden"
    end
  end

  def parse_imgs
    # execute shell script to download
    # and split the rain gif
    %x{./get_rain.sh}
 
    time_reader = TimeReader.new
    time_first_img = time_reader.read_time
    result = {}
  
    # discard first & second image and look at the rest of the images
    (1..8).each do |i|
      image = ChunkyPNG::Image.from_file("tmp/regen_#{i}.png")
  
      current_img_result = []
      @@pixels_to_check.each do |coords|
        pixel_color = hex(image[coords[0],coords[1]])
        if @@rain_strenghts.values.include?(pixel_color)
          current_img_result << @@rain_strenghts.values.find_index(pixel_color)
        end
      end
  
      # make items in the array unique
      current_img_result.uniq!
      result[time_first_img + 900*i] = current_img_result.sort if current_img_result != []
    end
    result
  end
  
  def human_readable
    times = parse_imgs
    output = ""
    times.each do |time,strength|
        current_result_string = "#{@@rain_strenghts.keys[strength[0]]}er"
        current_result_string << " bis #{@@rain_strenghts.keys[strength[1]]}er" if strength.size == 2
        current_result_string << " Regen"
        
        current_result_string << " in #{time_difference(time)}\n"
        output << current_result_string
    end
    output
  end

end
