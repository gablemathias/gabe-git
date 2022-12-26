require 'zlib'
require 'digest'

# 83baae61804e65cc73a7201a7252750c76066a30

command = ARGV[0]

case command
when "init"
  Dir.mkdir("./.gabegit")
  Dir.mkdir("./.gabegit/objects")
  Dir.mkdir("./.gabegit/refs")
  File.write("./.gabegit/HEAD", "ref: refs/heads/master\n")
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
when "hash-object"
  file = File.open(ARGV[2])
  # transform the file input into a SHA1 HASH
  content = file.read
  sha1 = Digest::SHA1.hexdigest content
  compress_content = Zlib.deflate(content)
  # Create folder with the first 2 chars of the SHA1 HASH
  Dir.mkdir("./gabegit/objects/#{sha1[...2]}")
  # Create a file with the rest of it inside the new folder
  File.write("./gabegit/objects/#{sha1[..2]}/#{sha1[2..]}", compress_content)
  print sha1
else
  raise "Unknown command #{command}" # Runtime Error
end
