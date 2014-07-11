module Puppet::Parser::Functions
  newfunction(:get_primary, :type => :rvalue, :doc => '') do |arguments|
    
    if arguments.size < 1 
        raise(Puppet::ParseError, "get_primary(): Wrong number of arguments " +
           "given (#{arguments.size} for 1)")
    end

    top_hash = arguments[0]

    unless top_hash.class == Hash
        raise(Puppet::ParseError, 'get_primary(): Requires a ' +
           'hash to work with') 
    end
    names = [ lookupvar('fqdn') ]
    top_hash.each do |key,value|
       names << key
       value.each do |k,v|
         if k == 'primary'
	   return key
         end
       end
    end
    return names.sort.at(0) 
  end
end
