#! /usr/bin/env moon
lfs = require"lfs"
import open, popen from io

VERSION = '0.1'
DATE = '2023/03/06'

read = =>
  return if not @
  r = @read'*a'
  @close!
  r

update_string = (before, after) ->
  for f in lfs.dir '.'
    if lfs.attributes(f, "mode") == "file"
      text, n = read(open f)\gsub before, after
      if n > 0
        print '', '- '..f
        output = open f, 'w'
        output\write text
        output\close!

if arg and arg[0]
  version = arg[1]
  date = read(popen 'git log -n1 --date=short --format="%ad"')\gsub('-', '/')\sub 1, -2
  if version and date
    print 'Updated version number:'
    update_string VERSION, version
    print '\nUpdated release date:'
    update_string DATE, date
    print '\nUpdated copyright:'
    update_string [[([Cc]opyright.*2022[%-]*)%d%d%d%d(.*)]], "%1#{date\sub(1,4)}%2"
