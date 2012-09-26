require 'spec_helper'

describe Gista::GistRequest do
  let(:subject) { described_class.new('token') }
  let(:url)     { 'https://api.github.com/gists?access_token=token' }
  it_should_behave_like 'API request'
end
