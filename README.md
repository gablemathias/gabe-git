# Gabe Git Implementation

A small git implementation that's capable of initializing a repository, creating commits and cloning a public repository.

# How to use it?

This repo already has a git copy repo created so in your terminal you can type:

```sh
./gabe_git.sh <your_command> <optional-flag> <sha>
```
If you face permission errors you can run CHMOD and change the permissions to be able to read, create and write the files through the commands

Full-permission example:

```sh
chmod 777 gabe_git.sh
```

If not sure giving full permission, you can read about the others permissions here:
https://kb.iu.edu/d/abdb#:~:text=To%20change%20file%20and%20directory,%2C%20write%2C%20and%20execute%20permissions.

Alternative:

You can run the direct command below instead of using `gabe_git.sh` as well, considering that your user has the permission

```sh
ruby main.rb <command> <optional-flag> <sha>
```

Available Commands:
- init
- cat-file (opt-flag: -p)
- hash-object (opt-flag: -w)
- ls-tree (opt-flag --only-name)
