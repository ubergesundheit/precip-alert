class TimeReader

  @@digits_data =["data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAgAAAAKBAMAAAB76QKzAAAAKlBMVEUMCgwUFhQcHiQsKiw0MjRERkRUVlRkZmR8enyEhoS8urzc2tzs6uz8+vzNe8hcAAAAPUlEQVR4nAEyAM3/Ajm9yTMCQqeSQAIsz8wwAh3gDSACDxDfEAL+7v7+AvIAA/AC4wAC4ALFQEXAAq1sXa/YvhOyMRR+IwAAAABJRU5ErkJggg==",
  "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAgAAAAKBAMAAAB76QKzAAAAHlBMVEUMCgwcGhwcHiQcIhwcIiQkHhwsKiw0LjRcWlz8+vwtaPfIAAAANklEQVR4nGNK7yxLY3ok8IGBSfbCgQ9MvxmsuZk2bWDdwPQv4DcDE8OGDUACCEDEfyaOhg4GAMKnD3DMknedAAAAAElFTkSuQmCC",
  "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAgAAAAKBAMAAAB76QKzAAAALVBMVEUMCgwcGhwkHhwsKiw0MjRERkRcWlx8enyMjoycnpy8urzEwsTc2tzk5uT8+vxTLd1gAAAAOklEQVR4nGPqenfTmck2NC+BKefBGzume3xMj5gYGMQmMCmwZ+1jejIhhoHJYyYDA1PEBiBheffueQC3rxC/f7be9QAAAABJRU5ErkJggg==",
  "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAgAAAAKCAMAAAC+Ge+yAAAAOVBMVEUMCgwUFhQcHiQcIhwkHhwsKiw0MjQ8QjxERkRkZmR8enyEhoSUlpSsrqy8urzExsTc2tzs6uz8+vw7xiP/AAAAUUlEQVR4nB3KQQ6AIAwEwGVFIERM5P9/9KCpIiXVOOdhLlutJQTOQ47TslG6wh4aocSUbhC+lKyX49D9EP8dA7RdcRA/A9fkEXMz9nnZUhf3AhbhIWsggmGBAAAAAElFTkSuQmCC",
  "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAgAAAAKBAMAAAB76QKzAAAAJFBMVEUMCgwUFhQkHhwsKixEPjxERkRUVlRkZmR8enyEhoTs6uz8+vxwPYQOAAAAOklEQVR4nGMyNp5tzMTAKsDA9MHpAAOTkM6Ff0yipxkeMMUdeMDEJNy1YAVTWFhCGBPDfwYGJiD+DwBlAQ9gUBVoiQAAAABJRU5ErkJggg==",
  "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAgAAAAKBAMAAAB76QKzAAAAJFBMVEUMCgwcGhwsKiw0MjRMTkxcWlxsamx8eny8urzExsTk5uT8+vwxF2N4AAAAO0lEQVR4nGPavXv3ZqbvGen5TAz//zMw/f/P+J+Ja1bpR6aw8I3xQLFTBkwMDAwfmFoEzN8zPZ7lOwEAM/QU7pMnr5gAAAAASUVORK5CYII=",
  "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAgAAAAKBAMAAAB76QKzAAAAMFBMVEUMCgwcGhwcHiQkHhwsKiw0MjRMSkxcWlxkZmR8enysqqy8urzEwsTc2tzk5uT8+vwXrgK9AAAAPUlEQVR4nAEyAM3/AkSN/0QCBylFAAJQjgDeAiz9/SACM66lAQL+ZXMQAum9u54C1gAAzwLGUEaBApt+bM+2jxLiAQpLEQAAAABJRU5ErkJggg==",
  "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAgAAAAKBAMAAAB76QKzAAAALVBMVEUMCgwcGhwcHiQkHhwsKiw0MjRMTkxsamx8enyEhoSUlpSkoqTExsTc3tz8+vySNro6AAAAO0lEQVR4nGN69+7dU6aw8Mj7TA/+sC1gkr9sd5fpnIEXAxPD1XsXmBhM+oCsmAsMTMyaDAxM39a//w8AIz4TsEjwZwcAAAAASUVORK5CYII=",
  "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAgAAAAKCAMAAAC+Ge+yAAAAM1BMVEUMCgwcGhwkHhwsKiw0MjRMTkxcWlxkZmR8enyEhoSUkpSkpqS8urzMyszc3tzk5uT8+vz6kOH7AAAAUElEQVR4nA3KWxJAMBAEwMlkCbUK979mKPLa5bubosd5qgiXcefLVqd0h7fo7FMwzMP5xG3TqfCn/L4tGpdivdUEBgIwgDVFYK5/hh57ePABVFwiWBL90ywAAAAASUVORK5CYII=",
  "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAgAAAAKBAMAAAB76QKzAAAALVBMVEUMCgwcGhwkHhwsKiw0MjRMSkxUVlRsamx8enysqqy8urzExsTc2tzk5uT8+vyzPfHZAAAAPUlEQVR4nAEyAM3/AkfOyDMCI4WUQAJK4No+AjD+3iICdBIzEAK+m5L/AvszPM8CAAAFwAIAA4CgAg3X5//S7RKv1chbPwAAAABJRU5ErkJggg=="]

  def initialize(image = ChunkyPNG::Image.from_file("tmp/regen_0.png"))
    @image = image
    @digits = []
    @@digits_data.each do |data|
      @digits << ChunkyPNG::Image.from_data_url(data).pixels
    end
  end

  def read_time(image = @image)
    first_digit_img = image.crop(11,11,8,10).pixels
    second_digit_img = image.crop(20,11,8,10).pixels
    third_digit_img = image.crop(35,11,8,10).pixels

    first_results = []
    second_results = []
    third_results = []
    @digits.each do |digit|
      digit_result_first = []
      digit_result_second = []
      digit_result_third = []
      digit.each_index do |i|
        digit_result_first << (first_digit_img[i] - digit[i]).abs
        digit_result_second << (second_digit_img[i] - digit[i]).abs
        digit_result_third << (third_digit_img[i] - digit[i]).abs
      end
      first_results << digit_result_first.inject(:+)
      second_results << digit_result_second.inject(:+)
      third_results << digit_result_third.inject(:+)
    end

    minutes = case third_results.index(third_results.min)
      when 0 then 0
      when 1 then 15
      when 3 then 30
      when 4 then 45
    end

    now = Time.now
    Time.new(now.year, now.month, now.day, "#{first_results.index(first_results.min)}#{second_results.index(second_results.min)}".to_i, minutes)
  end

  def parse_time
    white = "#fcfafc"
    
    # first digit: check for 0,1,2
    if hex(@image[11,15]) == white # first digit is a 0
      first = 0
    elsif hex(@image[14,15]) == white # first digit is a 1
      first = 1
    else # only digit left: 2
      first = 2
    end
  
    # second digit: check for 0 to 9
    if hex(@image[27,17]) == white # 4
      second = 4
    elsif hex(@image[26,17]) == white # 6
      second = 6
    elsif hex(@image[20,15]) == white # 0 or 5
      if hex(@image[26,11]) == white
        second = 5 
      else
        second = 0
      end
    elsif hex(@image[25,20]) == white # 1 or 2
      if hex(@image[26,20]) == white
        second = 2
      else
        second = 1
      end
    elsif hex(@image[22,15]) == white # 3 or 8
      if hex(@image[20,13]) == white
        second = 8
      else
        second = 3
      end
    elsif hex(@image[20,11]) == white # 7
      second = 7
    else
      second = 9
    end
  
    # third digit: check for 0,1,3,4
    # is it a 4?
    if hex(@image[42,17]) == white
      minutes = 45
    elsif hex(@image[38,15]) == white # either a 1 or 3
      if hex(@image[41,13]) == white # its a 3
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

  private

    def compare_digit(digit_image)
     #image.crop(10,11,8,10).save('wat.png')  
    end
end
