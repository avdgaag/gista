shared_examples_for 'API request' do
  before do
    FakeWeb.register_uri(:post, url, options)
  end

  context 'when successful' do
    let(:options) do
      { body:         '{"foo":"bar"}',
        content_type: 'application/json',
        status:       [201, 'Created'] }
    end

    it 'should request json at Github' do
      subject.fetch('foo')
      FakeWeb.last_request.content_type.should == 'application/json'
    end

    it 'should parse the body as JSON' do
      subject.fetch('foo').should == 'bar'
    end
  end

  context 'when not OK' do
    let(:options) { { body: '', status: [301, 'Redirect'] } }

    it 'should raise' do
      expect { subject.fetch('foo') }.to raise_error(Gista::RequestError)
    end
  end

  context 'when not authorized' do
    let(:options) { { body: '', status: [401, 'Not authorized'] } }

    it 'should raise' do
      expect { subject.fetch('foo') }.to raise_error(Gista::Unauthorized)
    end
  end
end
