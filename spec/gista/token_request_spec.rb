require 'spec_helper'

describe Gista::TokenRequest do
  let(:credentials) { double('credentials', username: 'username', password: 'password') }
  let(:url)         { 'https://username:password@api.github.com/authorizations' }
  let(:subject)     { described_class.new(credentials) }
  it_should_behave_like 'API request'
end
