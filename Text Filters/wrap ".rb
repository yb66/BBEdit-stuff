#! /usr/bin/env ruby
# encoding: UTF-8

# This wraps quotes (and others) around a selection
# In order:
# bare
# "bare"
# 'bare'
# "'bare'"
# '"bare"'
# [bare]
# {bare}
# {:bare}
# {"bare"}
# #{bare}
# "#{bare}"
# bare


original = ARGF.readlines.join

PRINTCHARS = /[[:print:]]+?/
DQ  = /"/
SQ  = /'/
B1  = /\{/
B2  = /\}/
HASH  = /#/
SB1 = /\[/
SB2 = /\]/

print case original
  # "#{bare}" -> bare   # remove interpolation and quotes
  when /^  #{DQ}   #{HASH}  #{B1}  (#{PRINTCHARS})  #{B2}   #{DQ} $/x
    $1
  # "bare"  ->  'bare'
  when /^  #{DQ} (?!')(#{PRINTCHARS})(?<!') #{DQ} $/x
    %Q!'#{$1}'!
  # "'bare'"  -> '"bare"'
  when /^ #{DQ} #{SQ} (#{PRINTCHARS}) #{SQ} #{DQ} $/x
    %Q!'"#{$1}"'!
  # '"bare"'  -> [bare]
  when /^  #{SQ}  #{DQ} (#{PRINTCHARS}) #{DQ}  #{SQ} $/x
    %Q![#{$1}]!
  # [bare]  ->  {bare}
  when /^ #{SB1} ( #{PRINTCHARS} ) #{SB2} /x
    %Q!{#{$1}}!
  # {"bare"} -> #{bare}
  when /^ #{B1} #{DQ} (#{PRINTCHARS}) #{DQ} #{B2} /x
    %Q!\#{#{$1}}!
  # {bare}  -> {:bare}
  when /^ #{B1} (?!\:)(#{PRINTCHARS}) #{B2} /x
    %Q!{:#{$1}}!
  # {:bare} -> {"bare"}
  when /^ #{B1} \: (#{PRINTCHARS}) #{B2} /x
    %Q!{"#{$1}"}!
  else
    %Q!"#{original}"!
end