+++
title = "Tools"
description = "List of tools that I use"
menu = "main"
draft = false
toc = true
comments = false
+++

Config:
- [.vimrc](https://gist.github.com/jaswdr/0de529f2b23a3409b632384d206c833d)

Plugins:
- [VundleVim/Vundle](https://github.com/VundleVim/Vundle.vim)
- [preservim/nerd](https://github.com/preservim/nerdtree)
- [christoomey/vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)
- [altercation/vim-colors-solarized](https://github.com/altercation/vim-colors-solarized)
- [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)
- [majutsushi/tagbar](https://github.com/majutsushi/tagbar)
- [codota/tabnine-vim](https://github.com/codota/tabnine-vim)
- [ryanoasis/vim-devicons](https://github.com/ryanoasis/vim-devicons)
- [fatih/vim-go](https://github.com/fatih/vim-go)

## [bat](https://github.com/sharkdp/bat)

```
 bat
# Print and concatenate files.
# A `cat` clone with syntax highlighting and Git integration.
# More information: <https://github.com/sharkdp/bat>.

# Print the contents of a file to the standard output:
bat file

# Concatenate several files into the target file:
bat file1 file2 > target_file

# Append several files into the target file:
bat file1 file2 >> target_file

# Number all output lines:
bat -n file

# Syntax highlight a json file:
bat --language json file.json

# Display all supported languages:
bat --list-languages
```

## [ripgrep](https://github.com/BurntSushi/ripgrep)

```
# ripgrep
# A recursive line-oriented CLI search tool.
# Aims to be a faster alternative to `grep`.
# More information: <https://github.com/BurntSushi/ripgrep>.

# Recursively search the current directory for a regex pattern:
rg pattern

# Search for pattern including all .gitignored and hidden files:
rg -uu pattern

# Search for a pattern only in a certain filetype (e.g., html, css, etc.):
rg -t filetype pattern

# Search for a pattern only in a subset of directories:
rg pattern set_of_subdirs

# Search for a pattern in files matching a glob (e.g., `README.*`):
rg pattern -g glob

# Only list matched files (useful when piping to other commands):
rg --files-with-matches pattern

# Show lines that do not match the given pattern:
rg --invert-match pattern

# Search a literal string pattern:
rg -F string
```

## [fzf](https://github.com/junegunn/fzf)

```
# fzf
# Command line fuzzy finder.
# More information: <https://github.com/junegunn/fzf>.

# Start finder on all files from arbitrary locations:
find path/to/search -type f | fzf

# Start finder on running processes:
ps aux | fzf

# Select multiple files with `Shift + Tab` and write to a file:
find path/to/search_files -type f | fzf -m > filename

# Start finder with a given query:
fzf -q "query"

# Start finder on entries that start with core and end with either go, rb, or py:
fzf -q "^core go$ | rb$ | py$"

# Start finder on entries that not match pyc and match exactly travis:
fzf -q "!pyc 'travis"
```

## [jq](https://github.com/stedolan/jq)

```
# jq
# A lightweight and flexible command-line JSON processor.

# Output a JSON file, in pretty-print format:
jq

# Output all elements from arrays
# (or all key-value pairs from objects) in a JSON file:
jq .[]

# Format JSON data
cat file.json | jq

# Filter data
cat file.json | jq -r '.attribute'

# URL Encode something
date | jq -sRr @uri
```

## [httpie](https://github.com/httpie/httpie)

```
# httpie
# A user friendly command line HTTP tool.

# Send a GET request (default method with no request data):
http https://example.com

# Send a POST request (default method with request data):
http https://example.com hello=World

# Send a POST request with redirected input:
http https://example.com < file.json

# Send a PUT request with a given json body:
http PUT https://example.com/todos/7 hello=world

# Send a DELETE request with a given request header:
http DELETE https://example.com/todos/7 API-Key:foo

# Show the whole HTTP exchange (both request and response):
http -v https://example.com

# Download a file:
http --download https://example.com
```

## [ytfzf](https://github.com/pystardust/ytfzf)

```
# ytfzf
# Youtube seach engine in terminal
ytfzf <search query>
```

## [cheat](https://cheat.sh/)

```
# cheat
# Create and view interactive cheat sheets on the command-line.
# More information: <https://github.com/cheat/cheat>.

# Show example usage of a command:
cheat command

# Edit the cheat sheet for a command:
cheat -e command

# List the available cheat sheets:
cheat -l

# Search available the cheat sheets for a specified command name:
cheat -s command

# Get the current cheat version:
cheat -v
```

## [filewatcher](https://github.com/dnephin/filewatcher)

```
# filewatcher
# Watch file changes and execute command when an event happen
$ filewatcher --help
Usage:
  filewatcher [OPTIONS] COMMAND ARGS... 

Options:
  -L, --depth int               Descend only level directories deep (default 5)
  -d, --directory strings       Directories to watch (default [.])
  -e, --event event             events to watch (create,write,remove,rename,chmod)
  -x, --exclude strings         Exclude file patterns
      --idle-timeout duration   Exit after idle timeout (default 10m0s)
  -q, --quiet                   Quiet
  -v, --verbose                 Verbose
```

More to share soon...
