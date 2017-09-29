filename = ARGV.first
text = File.read(filename)
status = text.to_i
exit status
