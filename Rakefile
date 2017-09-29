def system!(*args)
  raise 'Fail' unless system(*args)
end

task :spec do
  system! 'ruby main.rb src/status0.rb'
  system! 'ruby main.rb src/status1.rb && exit 1 || exit 0'
end
