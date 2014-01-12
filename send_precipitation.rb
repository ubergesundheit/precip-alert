#!/usr/bin/env ruby

require './image_analyzer'
require 'yaml'
require 'blather/client'

@config = YAML.load_file(File.join(File.dirname(File.expand_path(__FILE__)), 'config.yml'))

image_analyzer = ImageAnalyzer.new

result = image_analyzer.human_readable

puts result

start = Time.new(2014,1,12,20,0)

def in(time)
  now = Time.now
  now - time
end

# if result == ""
#   setup @config['jid'], @config['password'], 'talk.google.com'
# 
#   when_ready do
#     @config['send_to'].each do |addr|
#       say addr, result
#     end
#     shutdown
#   end
# end
