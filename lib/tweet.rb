$LOAD_PATH << File.dirname(__FILE__)
require 'rubygems'
require 'activesupport'
require 'rest_client'

module Tweet
  CONFIG_FILE = ENV['HOME']+'/.tweet'
  
  class << self
    def count(status)
      puts "Counting... #{status.length} chars."
      exit 0 
    end

    def create_status(status, source = nil)
      len = status.length
      abort "Abort: Message limit is 140 characters. You currently have #{len}." if len > 140

      if @debug
        puts "Would have tweeted: ", status
      else
        resource = RestClient::Resource.new 'http://twitter.com/statuses/update.xml', credentials[:username], credentials[:password]
        resource.post(:status => status, :content_type => 'application/xml', :accept => 'application/xml',
                      :source => (source || credentials[:source] || 'tweetgem'))
      end
      puts "#{len} chars" + (len == 140 ? "!\nYou rock!" : '.')
    end
    
    def credentials
      @credentials ||= begin
                         abort "You must create a #{CONFIG_FILE} file to use this CLI." unless File.exist?(CONFIG_FILE)
                         warn "  debug mode (not really posting)" if @debug
                         YAML.load(File.read(CONFIG_FILE)).symbolize_keys
                       end
    end
  end
end
