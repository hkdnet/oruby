require 'pry'
require 'ripper'

class ORuby
  class Function
    attr_reader :id, :body
    def initialize(id, body)
      @id = id
      @body = body
    end

    def call(args)
      oruby = ORuby.new(args)
      body.map { |e| oruby.reduce(e) }.last
    end
  end

  def initialize(args = [])
    @args = args
    @functions = {}
  end

  def evaluate(text)
    sexp = Ripper.sexp(text)
    reduce(sexp)
  end

  def reduce(sexp)
    puts '-' * 20
    p sexp
    if sexp.first == :program
      return sexp[1].map { |e| reduce e }.last
    end
    case sexp.first
    when :@backref
      identifier = sexp[1]
      idx = identifier[1..-1].to_i - 1
      args[idx]
    when :@int
      sexp[1].to_i
    when :binary
      l, o, r = sexp.drop(1)
      case o
      when :+
        reduce(l) + reduce(r)
      when :-
        reduce(l) - reduce(r)
      else
        raise NotImplementedError, 'binary'
      end
    when :def
      identifier = sexp[1][1]
      # params_info = sexp[2]
      body = sexp[3][1]
      functions[identifier] = Function.new(identifier, body)
      0
    when :command
      identifier = sexp[1][1]
      args = sexp[2][1].map { |e| reduce(e) }
      functions[identifier].call(args)
    else
      binding.pry
    end
  end

  private

  attr_reader :args, :functions
end

filename = ARGV.first
text = File.read(filename)
exit ORuby.new.evaluate(text)
