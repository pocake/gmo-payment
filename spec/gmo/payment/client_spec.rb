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
    it 'save member and card, then exec payment' do
      @client = Gmo::Payment::Client.new(
        site_id:   CONFIG["site_id"],
        site_pass: CONFIG["site_pass"],
        shop_id:   CONFIG["shop_id"],
        shop_pass: CONFIG["shop_pass"],
        host:      CONFIG["host"]
      )

      order_id  = "order-#{Time.now.to_i}"
      member_id = "member-#{Time.now.to_i}"
      amount    = 99

      entry_tran_result = @client.entry_tran(order_id: order_id, job_cd: "CAPTURE", amount: amount)
      @client.save_member(member_id: member_id)
      @client.save_card(member_id: member_id, card_no: '4111111111111111', expire: '1705')

      result = @client.exec_tran_with_saved_card(
        access_id:   entry_tran_result['AccessID'],
        access_pass: entry_tran_result['AccessPass'],
        order_id:    order_id,
        member_id:   member_id,
        card_seq:    "0",
        method:      "1",
      )

      expect(result["TranID"]).to be_true

    end
  end
end