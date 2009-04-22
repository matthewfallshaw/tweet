Gem::Specification.new do |s|
  s.name         = "tweet"
  s.version      = "0.0.6"
  s.date         = "2009-04-22"
  s.summary      = "Update your twitter status from the command line."
  s.email        = "matthew.fallshaw@tricycledevelopments.com"
  s.homepage     = "http://twitter.com/"
  s.description  = "Tweet from the command-line"
  s.has_rdoc     = false
  s.require_path = "lib"
  s.bindir       = "bin"
  s.executables  = %w(tweet)
  s.authors      = ["James Golick", "Mathieu Martin", "Francois Beausoleil", "Matthew Fallshaw"]
  s.files        = ["lib/tweet.rb", "bin/tweet", "README.rdoc", "LICENSE", "test/test_helper.rb"]
  s.add_dependency  'technoweenie-rest-client'
end
