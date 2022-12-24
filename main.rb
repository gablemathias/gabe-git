require 'zlib'

# 83baae61804e65cc73a7201a7252750c76066a30

command = ARGV[0]

case command
when 'init'
  Dir.mkdir('./.git')
  Dir.mkdir('./.git/objects')
  Dir.mkdir('./.git/refs')
  File.write("./.git/HEAD", "ref: refs/heads/master\n")
  puts "Initialized myOwnGit directory"
when "cat-file"
  flag = ARGV[1][1]
  folder = ARGV[2][...2]
  file_name = ARGV[2][2..]
  file_path = File.open("./.git/objects/#{folder}/#{file_name}")
  file = file_path.read
  raw_file = Zlib.inflate(file) if flag == 'p' # file with header: blob 10\x00
  file_source = raw_file[raw_file.index("\x00") + 1..]
  puts file_source
else
  raise "Unknown command #{command}" # Runtime Error
end
