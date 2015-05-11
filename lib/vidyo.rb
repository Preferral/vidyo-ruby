require "vidyo/version"

# Api/Use cases
require "vidyo/admin_api/room_creator"
require "vidyo/admin_api/room_getter"
require "vidyo/admin_api/room_destroyer"

# Models
require "vidyo/room"

# Runtime requirements
require "savon"

module Vidyo

  class Admin

    class << self

      attr_accessor(
        :instance_url,
        :admin_username,
        :admin_password,
        :extension_base,
        :app_user_name
      )

      def configure
        yield(self)
      end

      def method_missing(name, *args, &block)
        default_client.send(name, *args, &block)
      end

      def default_client
        @default_client ||= VidyoAdminClient.new(
          instance_url: instance_url,
          admin_username: admin_username,
          admin_password: admin_password,
          extension_base: extension_base,
          app_user_name: app_user_name
        )
      end

    end

    class VidyoAdminClient

      WSDL_URI = "services/VidyoPortalAdminService?wsdl"

      attr_accessor :extension_base, :app_user_name

      def initialize(instance_url:, admin_username:, admin_password:, extension_base:, app_user_name:)
        # Needed for Savon Client
        @instance_url = instance_url
        @admin_credentials = [admin_username, admin_password]

        # Needed for a single API call...
        @extension_base = extension_base
        @app_user_name = app_user_name
      end

      def soap_client
        @soap_client ||= Savon::Client.new({
          wsdl: wsdl_url,
          basic_auth: @admin_credentials,
          ssl_verify_mode: :none,
          follow_redirects: :true
        })
      end

      private

      def create_room(name:)
        return Vidyo::AdminApi::RoomCreator.new(name, self).call
      end

      def get_rooms
        return Vidyo::AdminApi::RoomGetter.new(self).all
      end

      def get_room_by_id(id:)
        return Vidyo::AdminApi::RoomGetter.new(self).find_by_id(id)
      end

      def get_room_by_extension(extension:)
        return Vidyo::AdminApi::RoomGetter.new(self).find_by_extension(extension)
      end

      def destroy_room(id:)
        return Vidyo::AdminApi::RoomDestroyer.new(self).destroy_by_id(id)
      end

      def wsdl_url
        @wsdl_url ||= URI.join(@instance_url, WSDL_URI).to_s
      end

    end

  end

end
