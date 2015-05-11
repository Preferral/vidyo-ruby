module Vidyo
  module AdminApi
    class RoomGetter < Struct.new(:client)

      # TODO: consider caching strategy
      def all
        get_rooms_response = client.soap_client.call(:get_rooms)
        get_rooms_response.body[:get_rooms_response][:room].map { |r| Vidyo::Room.new(r) }
      end

      def find_by_id(room_id)
        get_room_response = client.soap_client.call(:get_room, message: { 'roomID' => room_id })
        Vidyo::Room.new(get_room_response.body[:get_room_response][:room])
      end

      def find_by_extension(extension)
        all.find { |room| room.extension == extension }
      end

    end
  end
end
