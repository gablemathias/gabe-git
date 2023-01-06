require 'zlib'
require 'digest'
require './gabe_git'

# 83baae61804e65cc73a7201a7252750c76066a30

command = ARGV[0]

case command
when "init"
  init
when "cat-file"
  cat_file
when "hash-object"
  hash_object
when "ls-tree"
  ls_tree
else
  error # Runtime Error
end
