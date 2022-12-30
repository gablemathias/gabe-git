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
  content = file.read
  data = "blob #{content.size}\x00#{content}"
  sha1 = Digest::SHA1.hexdigest data
  compress_content = Zlib.deflate(data)
  Dir.mkdir("./.git/objects/#{sha1[...2]}")
  File.write("./.git/objects/#{sha1[...2]}/#{sha1[2..]}", compress_content)
  print sha1
when "ls-tree"
  sha1 = ARGV[-1]
  file_path = "./.git/objects/#{sha1[...2]}/#{sha1[2..]}"
  file_raw_source = File.read(file_path)
  file_source = Zlib.inflate(file_raw_source).split("\x00")[1..]
  file_names_tree = file_source.map { |f| f.split[-1] }.join("\n")
  puts file_names_tree
else
  raise "Unknown command #{command}" # Runtime Error
end
