#!/usr/bin/env ruby

# This will add interpolators for Ruby code and ERB in the following order
# given: original
# #{original}
# <% original %>
# <%= original %>
# original

original = ARGF.read

retval = catch(:retval) {
  if md = original.match(/^\#\{(?<content>.+)}$/)
    throw :retval, "<% #{md[:content]} %>"
  # The <%= must come before <% test as the <% gobbles up both
  elsif md = original.match(/<%=\s*(?<content>.+)\s+%>/)
    throw :retval, md[:content]
  elsif md = original.match(/<%\s*(?<content>.+)\s+%>/)
    throw :retval, "<%= #{md[:content]} %>"
  else
    throw :retval, '#{' + original + '}'
  end
}
print retval