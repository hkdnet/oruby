require 'pry'
require 'ripper'

def reduce(sexp)
  puts '-' * 20
  p sexp
  if sexp.first == :program
    return sexp[1].map { |e| reduce e }.first
  end
  case sexp.first
  when :@int
    sexp[1].to_i
  when :binary
    l, o, r = sexp.drop(1)
    reduce(l) + reduce(r) # currently, only support :+
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
