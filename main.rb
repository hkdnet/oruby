def evaluate(text)
  text.to_i
end

filename = ARGV.first
text = File.read(filename)
exit evaluate(text)
