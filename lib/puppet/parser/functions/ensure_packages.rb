#
# ensure_packages.rb
#
require 'puppet/parser/functions'

module Puppet::Parser::Functions
  newfunction(:ensure_packages, :type => :statement, :doc => <<-EOS
Takes a list of packages and adds them to the catalog using the specified
ensure value. Defaults to 'present'.
    EOS
  ) do |arguments|
    raise(Puppet::ParseError, "ensure_packages(): Wrong number of arguments " +
      "given (#{arguments.size} when 1 or 2 expected)") if ![1, 2].include? arguments.size
    raise(Puppet::ParseError, "ensure_packages(): Requires array " +
      "given (#{arguments[0].class})") if !arguments[0].kind_of?(Array)

    arguments[1] ||= 'present'
    raise(Puppet::ParseError, "ensure_packages(): Requires valid ensure value " +
      "given (#{arguments[1].class})") if !arguments[1].kind_of?(String)

    Puppet::Parser::Functions.function(:ensure_resource)
    arguments[0].each { |package_name|
      function_ensure_resource(['package', package_name, {'ensure' => arguments[1] } ])
    }
  end
end

# vim: set ts=2 sw=2 et :
