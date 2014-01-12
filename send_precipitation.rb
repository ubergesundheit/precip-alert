#!/usr/bin/env ruby

require './image_analyzer'
require 'yaml'
require 'blather/client'

@config = YAML.load_file(File.join(File.dirname(File.expand_path(__FILE__)), 'config.yml'))

image_analyzer = ImageAnalyzer.new

result = image_analyzer.human_readable

if result == ""
  setup @config['jid'], @config['password'], 'talk.google.com'

  when_ready do
    @config['send_to'].each do |addr|
      say addr, result
    end
    shutdown
  end
end
