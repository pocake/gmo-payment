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
        client.class.should == Gmo::Payment::Client
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

  context 'scenario' do
    before(:all) do
      @client = Gmo::Payment::Client.new(
        site_id:   CONFIG["site_id"],
        site_pass: CONFIG["site_pass"],
        shop_id:   CONFIG["shop_id"],
        shop_pass: CONFIG["shop_pass"],
        host:      CONFIG["host"]
      )
    end
  end
end