#!/usr/bin/env ruby

# This script will run jslint on a file.

require 'pathname'

original = Pathname(ENV["BB_DOC_PATH"]).read


require 'tempfile'

fh = Tempfile.new ["jslint-", ".js"]
fh.write original
fh.rewind
begin
  pattern = '(?P<file>.+?):[[:space:]]line[[:space:]](?P<line>[[:digit:]]+),[[:space:]]col[[:space:]](?P<col>[[:digit:]]+),[[:space:]]+(?P<msg>.*)$'
  
  cmd = %Q!/usr/local/bin/jshint #{fh.path} | bbresults --pattern '#{pattern}'!
  `#{cmd}`
rescue => e
  warn e
end