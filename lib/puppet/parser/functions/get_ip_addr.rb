require 'resolv'

module Puppet::Parser::Functions
  newfunction(:get_ip_addr, :type => :rvalue) do |args|
    
    if args.size < 1 
        raise(Puppet::ParseError, "get_ip_addr(): Wrong number of arguments " +
           "given (#{args.size} for 1)")
    end

    # regex to match valid IPs
    ip_addr_re = /\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b/
    hostname = args[0].strip
    if hostname =~ ip_addr_re then return hostname end
    ipaddr = ''
    begin
      ipaddr=Resolv.new.getaddress(hostname).to_a
      rescue Resolv::ResolvError
      return ipaddr
    end
  end
end
