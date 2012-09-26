require 'spec_helper'

describe Gista::UserToken do
  let(:token_file) { '/tmp/gista_token' }
  let(:authoriser) { double('auth', fetch: 'token') }
  let(:subject)    { described_class.new authoriser, token_file }

  after do
    File.unlink(token_file) if File.exist?(token_file)
  end

  context 'when the token file exists' do
    before do
      File.open(token_file, 'w') { |f| f.write 'foo' }
    end

    its(:token) { should == 'foo' }
  end

  context 'when the token file does not exist' do
    it 'writes token to file' do
      File.exist?(token_file).should be_false
      subject.token
      File.exist?(token_file).should be_true
      File.read(token_file).should == 'token'
    end

    its(:token) { should == 'token' }
  end
end
