class heartbeat (
  $node = $::fqdn,
  $partner_hash,
  $ha_VIP,
  $ha_adapter = 'eth0',
  $ha_auth,
  $ha_script,
  $ha_startup = true,
  $primary = get_primary($partner_hash)
  ){

  $ha_address = int_address($ha_adapter)
  #$netmask_bits = mask2cidr($ha_adapter)

  package {'heartbeat':
    ensure  => 'installed',
  }
  ->
  file {
  '/etc/ha.d/authkeys':
    mode    => '0600',
    content => template('heartbeat/authkeys'),
    notify  => Service['heartbeat'];

  '/etc/ha.d/haresources':
    content => template('heartbeat/haresources'),
    notify  => Service['heartbeat'];

  '/etc/ha.d/ha.cf':
    content => template('heartbeat/ha.cf'),
    notify  => Service['heartbeat'];
  }

  exec { 'sysconfig/heartbeat':
    command     => '/bin/echo "HA_BIN=/usr/lib64/heartbeat" >> /etc/sysconfig/heartbeat',
    unless      => '/bin/grep -q HA_BIN /etc/sysconfig/heartbeat',
    subscribe   => Package['heartbeat'],
    refreshonly => true,
  }

  service {'heartbeat':
    enable  => $ha_startup
  }
}
