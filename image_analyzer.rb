class ImageAnalyzer

  require 'oily_png'
  require './time_reader'
  
  # hard coded values for regenradar images from wetteronline.de
  
  @@rain_strenghts = {
    # :kein_regen => 3570849023,
      :"sehr leicht"  => 2902392063,
      :leicht         => 1423113471,
      :mäßig          => 749403391,
      :stark          => 478076159,
      :stärker        => 2620562687,
      :"sehr stark"   => 4228054271
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
      when 37.6..52.5 then "einer Dreiviertelstunde"
      when 52.6..67.5 then "einer Stunde"
      when 67.6..82.5 then "einer Stunde und 15 Minuten"
      when 82.6..97.5 then "anderthalb Stunden"
      when 97.6..112.5 then "einer Stunde und 45 Minuten"
      when 112.6..127.6 then "zwei Stunden"
      else "???"
    end
  end

  def parse_imgs
    # execute shell script to download
    # and split the rain gif
    #%x{./get_rain.sh}
 
    time_reader = TimeReader.new
    time_first_img = time_reader.read_time
    result = {}
  
    # discard first & second image and look at the rest of the images
    (2..8).each do |i|
      image = ChunkyPNG::Image.from_file("tmp/regen_#{i}.png")
      
      current_img_result = []
      @@pixels_to_check.each do |coords|
        pixel_color = image.get_pixel(coords[0], coords[1])
        if @@rain_strenghts.values.include?(pixel_color)
          puts @@rain_strenghts.values.find_index(pixel_color)
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
        
        current_result_string << " in #{time_difference(time)} (#{time.strftime('%R')})\n"
        output << current_result_string
    end
    output.rstrip
  end

end
