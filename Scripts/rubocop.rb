#!/usr/bin/env ruby

# Run Rubocop and open it in BBEdit's results window.

require 'pathname'
require 'shellwords'

path = Shellwords.escape Pathname(ENV["BB_DOC_PATH"]).to_path
begin
  `rubocop #{path} | bbresults`
rescue => e
  warn e
end