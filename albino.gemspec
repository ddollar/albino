
spec = Gem::Specification.new do |s|

  s.name        = "albino"
  s.version     = "1.0.4"
  s.summary     = "Ruby wrapper for Pygments syntax-highlighting library"
  s.homepage    = "http://github.com/ddollar/albino"

  s.description = <<-DESCRIPTION

Albino is an interface to the Python-based Pygments library. The code was all
written by Chris Wanstrath and can be found at 
http://github.com/github/albino

David Dollar wrapped it in a gem.


  DESCRIPTION

  s.author   = "David Dollar"
  s.email    = "ddollar@gmail.com"

  s.files    = ["lib/albino.rb"]
  s.platform = Gem::Platform::RUBY

  s.rubyforge_project = "albino"
  s.require_path      = "lib"
  s.has_rdoc          = true
  s.extra_rdoc_files  = ["README.rdoc"]

end
