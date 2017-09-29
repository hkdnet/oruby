def system!(*args)
  raise 'Fail' unless system(*args)
end

task :spec do
  Dir.glob('test/**/*.sh') do |f|
    puts f
    system! f
  end
end
