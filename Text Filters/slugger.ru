#!/usr/bin/env ruby

# This turn text into a slug

original = ARGF.read


print original.empty? ? "" : original.strip.chomp.downcase.gsub(/\s{2,}/, " ").gsub(/[^a-z0-9]+/,'-')
