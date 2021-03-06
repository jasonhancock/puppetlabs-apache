require 'spec_helper_acceptance'
require_relative './version.rb'

describe 'apache::mod::mime class' do
  context "default mime config" do
    it 'succeeds in puppeting mime' do
      pp= <<-EOS
        class { 'apache': }
        include apache::mod::mime
      EOS
      apply_manifest(pp, :catch_failures => true)
    end

    describe service($service_name) do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe file("#{$mod_dir}/mime.conf") do
      it { is_expected.to contain "AddType application/x-compress .Z" }
      it { is_expected.to contain "AddHandler type-map var\n" }
      it { is_expected.to contain "AddType text/html .shtml\n" }
      it { is_expected.to contain "AddOutputFilter INCLUDES .shtml\n" }
    end
  end
end
