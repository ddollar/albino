require 'open4'

#
# Wrapper for the Pygments command line tool, pygmentize.
#
# Pygments: http://pygments.org
#
# Assumes pygmentize is in the path.  If not, set its location
# with Albino.bin = '/path/to/pygmentize'
#
# Use like so:
#
#   @syntaxer = Albino.new('/some/file.rb', :ruby)
#   puts @syntaxer.colorize
#
# This'll print out an HTMLized, Ruby-highlighted version
# of '/some/file.rb'.
#
# To use another formatter, pass it as the third argument:
#
#   @syntaxer = Albino.new('/some/file.rb', :ruby, :bbcode)
#   puts @syntaxer.colorize
#
# You can also use the #colorize class method:
#
#   puts Albino.colorize('/some/file.rb', :ruby)
#
# Another also: you get a #to_s, for somewhat nicer use in Rails views.
#
#   ... helper file ...
#   def highlight(text)
#     Albino.new(text, :ruby)
#   end
#
#   ... view file ...
#   <%= highlight text %>
#
# The default lexer is 'text'.  You need to specify a lexer yourself;
# because we are using STDIN there is no auto-detect.
#
# To see all lexers and formatters available, run `pygmentize -L`.
#
# Chris Wanstrath // chris@ozmm.org 
#
# GitHub // http://github.com
#
class Albino

  @@bin = 'pygmentize'

  def self.bin=(path)
    @@bin = path
  end

  def self.colorize(*args)
    new(*args).colorize
  end

  def self.lexer_from_filename(filename)
    new('').lexer_from_filename(filename)
  end

  def initialize(target, lexer = nil, format = :html)
    @target  = File.exists?(target) ? File.read(target) : target rescue target
    @options = {}
    @options[:f] = format
    lexer ? @options[:l] = lexer : @options[:g] = ''
  end

  def execute(command)
    pid, stdin, stdout, stderr = Open4.popen4(command)
    stdin.puts @target
    stdin.close
    stdout.read.strip
  end

  def colorize(options = {})
    execute @@bin + convert_options(options)
  end
  alias_method :to_s, :colorize

  def convert_options(options = {})
    @options.merge(options).keys.sort_by { |k| k.to_s }.inject('') do |string, flag|
      value   = @options[flag]
      string += " -#{flag} #{value}"
    end
  end

  def lexer_from_filename(filename)
    execute @@bin + " -N #{filename}"
  end
end

if $0 == __FILE__
  require 'rubygems'
  require 'test/spec'
  require 'mocha'
  begin require 'redgreen'; rescue LoadError; end

  context "Albino" do
    setup do
      @syntaxer = Albino.new(__FILE__, :ruby)
    end

    specify "defaults to text with no and no syntax" do
      syntaxer = Albino.new(__FILE__)
      syntaxer.expects(:execute).with('pygmentize -f html -g ').returns(true)
      syntaxer.colorize
    end

    specify "accepts options" do
      syntaxer = Albino.new(__FILE__, :ruby, :html)
      @syntaxer.expects(:execute).with('pygmentize -f html -l ruby').returns(true)
      @syntaxer.colorize
    end

    specify "works with strings" do
      syntaxer = Albino.new('class New; end', :ruby)
      assert_match %r(highlight), syntaxer.colorize
    end

    specify "aliases to_s" do
      assert_equal @syntaxer.colorize, @syntaxer.to_s
    end

    specify "class method colorize" do
      assert_equal @syntaxer.colorize, Albino.colorize(__FILE__, :ruby)
    end

    specify "can get lexer from filename" do
      assert_equal "rb", @syntaxer.lexer_from_filename('test.gemspec')
    end

    specify "class method lexer_from_filename" do
      assert_equal @syntaxer.lexer_from_filename('test.gemspec'),
                   Albino.lexer_from_filename('test.gemspec')
    end
  end
end
