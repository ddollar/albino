@config.name = "albino"

require "lib/#{@config.name}"

@config.version  = '1.0.3'
@config.homepage = "http://github.com/ddollar/albino"
@config.summary  = "Ruby wrapper for Pygments syntax-highlighting library"

@config.description = <<-DESCRIPTION

Albino is an interface to the Python-based Pygments library. The code was all
written by Chris Wanstrath and can be found at 
http://github.com/github/albino

David Dollar wrapped it in a gem.

DESCRIPTION

@config.author_name  = "David Dollar"
@config.author_email = "ddollar@gmail.com"
