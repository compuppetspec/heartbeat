require 'spec_helper'
	
	describe 'get_primary' do
	it { should run.with_params({'hosttest' => 'hostvalue'}) }
	end
	
	describe 'int_address' do
	it { should run.with_params('eth0') }
	end
	
#	describe 'mask2cidr' do
#	it { should run.with_params('eth0') }
#	end
