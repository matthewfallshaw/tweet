$LOAD_PATH << File.dirname(__FILE__)
require 'rubygems'
require 'activesupport'
require 'rest_client'

module Tweet
  CONFIG_FILE = ENV['HOME']+'/.tweet'
  
  class << self
    attr_accessor :username, :password
    
    def create_status(status, just_count = false)
      len = status.length
      if just_count
        puts "Counting... #{len} chars"
        exit 0 
      end

      abort "Message limit is 140 characters. You currently have #{len}" if len > 140
      get_credentials!
      unless @debug
        resource = RestClient::Resource.new 'http://twitter.com/statuses/update.xml', username, password
        resource.post(:status => status, :source => 'tweetgem', :content_type => 'application/xml', :accept => 'application/xml')
      end
      puts "#{len} chars" + (len == 140 ? "!\nYou rock!" : '.')
    end
    
    def get_credentials!
      abort "You must create a #{CONFIG_FILE} file to use this CLI." unless File.exist?(CONFIG_FILE)
      config = YAML.load(File.read(CONFIG_FILE)).symbolize_keys
      @username, @password, @debug = config[:username], config[:password], config[:debug]
      warn "  debug mode (not really posting)" if @debug
    end
  end
end
