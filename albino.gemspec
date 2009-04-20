
spec = Gem::Specification.new do |s|

  s.name        = "albino"
  s.version     = "1.0"
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

  s.files    = ["doc/classes","doc/classes/Albino.html","doc/created.rid","doc/files","doc/files/lib","doc/files/lib/albino_rb.html","doc/files/README_rdoc.html","doc/fr_class_index.html","doc/fr_file_index.html","doc/fr_method_index.html","doc/index.html","doc/rdoc-style.css","lib/albino.rb"]
  s.platform = Gem::Platform::RUBY

  s.rubyforge_project = "albino"
  s.require_path      = "lib"
  s.has_rdoc          = true
  s.extra_rdoc_files  = ["README.rdoc"]

end
