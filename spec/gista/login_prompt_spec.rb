require 'spec_helper'

describe Gista::LoginPrompt do
  let(:output) { StringIO.new }
  let(:input)  { StringIO.new("username\npassword\n") }

  before do
    $stdout = output
    $stdin  = input
  end

  after do
    $stdout = STDOUT
    $stdin  = STDIN
  end

  it 'should ask for username and password' do
    subject.username
    output.string.should include('Please authenticate with your Github credentials:')
    output.string.should include('Username: ')
    output.string.should include('Password: ')
  end

  its(:username) { should == 'username' }
  its(:password) { should == 'password' }
end
