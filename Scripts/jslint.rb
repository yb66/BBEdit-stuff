#!/usr/bin/env ruby

# This script will run jslint on a file.

require 'pathname'
require 'shellwords'

path = Shellwords.escape Pathname(ENV["BB_DOC_PATH"]).to_path

begin
  pattern = '(?P<file>.+?):[[:space:]]line[[:space:]](?P<line>[[:digit:]]+),[[:space:]]col[[:space:]](?P<col>[[:digit:]]+),[[:space:]]+(?P<msg>.*)$'
  
  cmd = %Q!/usr/local/bin/jshint #{path} | bbresults --pattern '#{pattern}'!
  `#{cmd}`
rescue => e
  warn e
end