require 'gmo'

module Gmo
  module Payment
    class Client
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

      #
      # Shop API
      #
      def entry_tran(options = {})
        @shop.entry_tran(options)
      end

      def entry_tran_cvs(options = {})
        @shop.entry_tran_cvs(options)
      end

      def exec_tran(options = {})
        @shop.exec_tran(options)
      end

      def exec_tran_cvs(options = {})
        @shop.exec_tran_cvs(options)
      end

      def alter_tran(options = {})
        @shop.alter_tran(options)
      end

      def change_tran(options = {})
        @shop.change_tran(options)
      end

      def search_trade(options = {})
        @shop.search_trade(options)
      end

      def search_trade_multi(options = {})
        @shop.search_trade_multi(options)
      end


      #
      # Site API
      #
      def save_member(options = {})
        @site.save_member(options)
      end

      def update_member(options = {})
        @site.update_member(options)
      end

      def delete_member(options = {})
        @site.delete_member(options)
      end

      def search_member(options = {})
        @site.search_member(options)
      end

      def save_card(options = {})
        @site.save_card(options)
      end

      def delete_card(options = {})
        @site.delete_card(options)
      end

      def search_card(options = {})
        @site.search_card(options)
      end

      def exec_tran_with_saved_card(options = {})
        @site.exec_tran(options)
      end

      #
      # Shop and Site API
      #
      def trade_card(options = {})
        @shop_and_site_api.trade_card(options)
      end

    end
  end
end
