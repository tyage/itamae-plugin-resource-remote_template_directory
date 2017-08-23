require 'spec_helper'

describe file('/tmp/remote_template_directory_spec/test1') do
  it { should be_file }
  it { should exist }
  its(:content) do
    should eq <<-'EOS'
Sample Message
1+1=2
EOS
  end
end
