require 'spec_helper'

describe 'heartbeat' do
	let (:params) {{ :ha_adapter => 'eth0', :ha_startup => 'true', :partner_hash => {'k1'=>'v1'}, :ha_VIP => 'viptest',\
	:ha_auth => 'authtest',:ha_script=>'scripttest'}}
	
	it { should contain_class('heartbeat') }
	
	it { should contain_package('heartbeat').with('ensure' => 'installed')}
	
	it { should contain_file('/etc/ha.d/authkeys').with('mode' => '0600','notify' => 'Service[heartbeat]').that_requires('Package[heartbeat]')}
	
	it { should contain_file('/etc/ha.d/haresources').with('notify' => 'Service[heartbeat]').that_requires('Package[heartbeat]')}
	
	it { should contain_file('/etc/ha.d/ha.cf').with('notify' => 'Service[heartbeat]').that_requires('Package[heartbeat]')}
	
	it do should contain_exec('sysconfig/heartbeat').with(
            'command'     => '/bin/echo "HA_BIN=/usr/lib64/heartbeat" >> /etc/sysconfig/heartbeat',
            'unless'     => '/bin/grep -q HA_BIN /etc/sysconfig/heartbeat',
            'refreshonly' => 'true').that_subscribes_to('Package[heartbeat]')
    end
	
	it { should contain_service('heartbeat').with('enable' => 'true') }  
end
