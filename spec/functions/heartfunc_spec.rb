require 'spec_helper'
	
	describe 'get_primary' do
	it { should run.with_params({'k1' => 'v1'}) }
	end
	
	describe 'int_address' do
	it { should run.with_params('eth0') }
	end
	
	describe 'template' do
	it { should run.with_params('heartbeat/authkeys') }
	end
	
	describe 'template' do
	it { should run.with_params('heartbeat/haresources') }
	end
	
	describe 'template' do
	it { should run.with_params('heartbeat/ha.cf') }
	end
	
#	describe 'mask2cidr' do
#	it { should run.with_params('eth0') }
#	end
