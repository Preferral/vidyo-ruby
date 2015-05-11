module Vidyo
  module AdminApi
    class RoomCreator < Struct.new(:name, :client)

      MAX_EXTENSION_TAIL = 9_999_999_999_999_999 # 16 digits

      def call
        create_room

        if @room_created
          return Vidyo::AdminApi::RoomGetter.new(client).find_by_extension(room_extension)
        end
      end


      private

      def create_room
        @failed_room_creation_attempts ||= 0

        while !@room_created && @failed_room_creation_attempts < 50 do
          begin
            @add_room_response = client.soap_client.call(:add_room, message: message)
            if @add_room_response.body[:add_room_response][:ok] == "OK"
              @room_created = true
            else
              @failed_room_creation_attempts += 1
            end

          rescue Savon::SOAPFault => error
            case error.message
            when /Room exist for extension/
              increment_extension_tail
            when /Room exist for name/
              @room_name = SecureRandom.base64
            else
              raise error
            end

            @failed_room_creation_attempts += 1
          end
        end
      end

      def message
        {
          'room' => {
            'name' => room_name,
            'RoomType' => room_type,
            'ownerName' => client.app_user_name,
            'extension' => room_extension,
            'groupName' => 'Default',
            'RoomMode' => {
              'isLocked' => false,
              'hasPin' => false
            }
          }
        }
      end

      def room_name
        @room_name ||= name
      end

      def room_extension
        @extension_tail ||= random_extension_tail
        "#{client.extension_base}#{@extension_tail}"
      end

      def room_type
        'Public'
        # ['Public', 'Private'].find { |t| t == params[:room_type] } || 'Public'
      end

      def random_extension_tail
        rand(MAX_EXTENSION_TAIL)
      end

      def increment_extension_tail
        @extension_tail = (@extension_tail == MAX_EXTENSION_TAIL ? rand(MAX_EXTENSION_TAIL) : @extension_tail + 1)
      end

    end
  end
end
