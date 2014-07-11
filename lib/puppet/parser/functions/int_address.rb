module Puppet::Parser::Functions
  newfunction(:int_address, :type => :rvalue, :doc => 'Returns the address of an interface') do |arguments|
    
    if arguments.size < 1 
        raise(Puppet::ParseError, "int_address(): Wrong number of arguments " +
           "given (#{arguments.size} for 1)")
    end

    iface = arguments[0]

    unless iface.class == String
        raise(Puppet::ParseError, 'int_address(): Requires a ' +
           'string to work with') 
    end
        
    result = lookupvar('ipaddress_' + iface)
    return result
  end
end
