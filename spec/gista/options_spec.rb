require 'spec_helper'

describe Gista::Options do
  let(:input)   { StringIO.new('input') }
  let(:subject) { described_class.new(args).options }

  before { $stdin = input }

  context 'without options' do
    let(:args)     { [] }
    its([:public]) { should be_false }
  end

  context 'with public switch' do
    let(:args)     { ['-p'] }
    its([:public]) { should be_true }
  end

  context 'with filenames that exist' do
    let(:args)    { ['/tmp/gista_file1', '/tmp/gista_file2'] }

    before do
      args.each_with_index do |filename, i|
        File.open(filename, 'w') { |f| f.write "gista example #{i}" }
      end
    end

    after do
      args.each { |filename| File.unlink(filename) if File.exists?(filename) }
    end

    its([:files]) do
      should == {
        'gista_file1' => { content: 'gista example 0' },
        'gista_file2' => { content: 'gista example 1' }
      }
    end
  end

  context 'with filenames that do not exist' do
    let(:args) { ['foo'] }

    it 'should raise exception' do
      expect { subject }.to raise_error
    end
  end

  context 'reading content from STDIN with default filename' do
    let(:args)    { ['-f', 'bla'] }
    its([:files]) { should == { 'bla' => { content: 'input' } } }
  end

  context 'reading content from STDIN with default filename' do
    let(:args)    { [] }
    its([:files]) { should == { 'untitled' => { content: 'input' } } }
  end
end
