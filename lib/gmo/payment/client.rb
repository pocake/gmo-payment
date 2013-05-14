require 'gmo'

module GMO
  module Payment
    class Client

      APIS = {
        entry_tran:         :shop,
        entry_tran_cvs:     :shop,
        exec_tran:          :shop,
        exec_tran_cvs:      :shop,
        alter_tran:         :shop,
        change_tran:        :shop,
        search_trade:       :shop,
        search_trade_multi: :shop,

        save_member:   :site,
        update_member: :site,
        delete_member: :site,
        search_member: :site,
        save_card:     :site,
        delete_card:   :site,
        search_card:   :site,
        exec_tran_with_saved_card: [:site, :exec_tran],

        trade_card: :shop_and_site,
      }

      def initialize(config = {})
        @site_id   = config[:site_id]
        @site_pass = config[:site_pass]
        @shop_id   = config[:shop_id]
        @shop_pass = config[:shop_pass]
        @host      = config[:host]

        unless [@site_id, @site_pass, @shop_id, @shop_pass, @host].all?
          raise ArgumentError, "require folloings: :site_id, :site_pass, :shop_id, :shop_pass, :host"
        end

        @shop_api          = GMO::Payment::ShopAPI.new(shop_id: @shop_id, shop_pass: @shop_pass, host: @host)
        @site_api          = GMO::Payment::SiteAPI.new(site_id: @site_id, site_pass: @site_pass, host: @host)
        @shop_and_site_api = GMO::Payment::ShopAndSiteAPI.new(shop_id: @shop_id, shop_pass: @shop_pass, site_id: @site_id, site_pass: @site_pass, host: @host)
      end
      attr_reader :site_id, :site_pass, :shop_id, :shop_pass, :host

      def method_missing(action, *args)
        api_info = APIS[action]
        return super unless action

        if api_info.is_a? Symbol
          api_name   = api_info
          api_action = action
        elsif api_info.is_a? Array
          api_name   = api_info[0]
          api_action = api_info[1]
        end

        return super unless [:shop, :site, :shop_and_site].include? api_name


        begin
          instance_variable_get("@#{api_name.to_s}_api").send(api_action, *args)
        rescue Exception => e
          error_messages = e.message.scan(/[A-Z][0-9]{8}/).map{ |error_code|
            GMO::Payment::Const::ERROR_CODES[error_code]
          }

          raise e if error_messages.size == 0

          detailed_error_message = e.message + "&ErrMessage=" + error_messages.join("|")
          raise e, detailed_error_message

        end
      end

    end
  end
end
