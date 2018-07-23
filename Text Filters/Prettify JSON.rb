#!/usr/bin/env ruby

require 'json'

orig = ARGF.read

print JSON.pretty_unparse JSON.parse orig