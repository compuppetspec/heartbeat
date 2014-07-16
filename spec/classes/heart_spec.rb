require 'spec_helper'

describe 'heartbeat' do
	let (:facts) {{:fqdn =>'hosttest'}}
	let (:params) {{ :ha_adapter => 'eth0', :ha_startup => 'true', :partner_hash => {'hosttest'=>'hostvalue'}, :ha_VIP => 'viptest',\
	:ha_auth => 'authtest',:ha_script=>'scripttest'}}
	
	
	it { should contain_class('heartbeat') }
	
	it { should contain_package('heartbeat').with('ensure' => 'installed')}
	
	it { should contain_file('/etc/ha.d/authkeys').with('mode' => '0600','notify' => 'Service[heartbeat]').that_requires(\
	'Package[heartbeat]').with_content(/auth 1\n1 md5 authtest/)}
	
	it { should contain_file('/etc/ha.d/haresources').with('notify' => 'Service[heartbeat]').that_requires('Package[heartbeat]').with_content(\
	/hosttest scripttest viptest/)}
	
	it { should contain_file('/etc/ha.d/ha.cf').with('notify' => 'Service[heartbeat]').that_requires('Package[heartbeat]').with_content(\
	/logfacility\tlocal0\nkeepalive 250ms\ndeadtime 2\nwarntime 1\ninitdead 10\n\nauto_failback off\n\nnode hosttest\nucast eth0 \nnode hosttest/)}
	
	it do should contain_exec('sysconfig/heartbeat').with(
            'command'     => '/bin/echo "HA_BIN=/usr/lib64/heartbeat" >> /etc/sysconfig/heartbeat',
            'unless'     => '/bin/grep -q HA_BIN /etc/sysconfig/heartbeat',
            'refreshonly' => 'true').that_subscribes_to('Package[heartbeat]')
    end
	
	it { should contain_service('heartbeat').with('enable' => 'true') }  
end
