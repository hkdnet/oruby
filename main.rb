require 'pry'
require 'ripper'

def reduce(sexp)
  puts '-' * 20
  p sexp
  if sexp.first == :program
    return sexp[1].map { |e| reduce e }.last
  end
  case sexp.first
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
  else
    binding.pry
  end
end

def evaluate(text)
  sexp = Ripper.sexp(text)
  reduce(sexp)
end

filename = ARGV.first
text = File.read(filename)
exit evaluate(text)
