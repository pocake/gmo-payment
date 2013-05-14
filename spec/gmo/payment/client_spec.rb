require 'spec_helper'

describe Gmo::Payment::Client do
  describe '#initialize' do
    context 'valid options' do
      it 'return instance' do
        client = Gmo::Payment::Client.new(
          site_id: 'hoge',
          site_pass: 'piyo',
          shop_id: 'hoge',
          shop_pass: 'piyo',
          host: 'foo'
        )
      end
    end

    context 'invalid options' do
      it 'raise error' do
        lambda {
          client = Gmo::Payment::Client.new()
        }.should raise_error
      end
    end
  end
end