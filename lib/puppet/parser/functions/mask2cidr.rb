module Puppet::Parser::Functions
  newfunction(:mask2cidr, :type => :rvalue, :doc => 'Converts octet style mask notation to CIDR bits.') do |arguments|
    
    if arguments.size < 1 
        raise(Puppet::ParseError, "mask2cidr(): Wrong number of arguments " +
           "given (#{arguments.size} for 1)")
    end

    nm_int = arguments[0]

    unless nm_int.class == String
        raise(Puppet::ParseError, 'mask2cidr(): Requires a ' +
           'string to work with') 
    end
        
    mask = lookupvar('netmask_' + nm_int)
    result = mask.split('.').map { |e| e.to_i.to_s(2).rjust(8, "0") }.join.count("1")
    return result
  end
end
