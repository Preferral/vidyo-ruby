module Vidyo
  module AdminApi
    class RoomGetter < Struct.new(:client)

      def find_by_id(room_id)
        get_room_response = client.soap_client.call(:get_room, message: { 'roomID' => room_id })
        Vidyo::Room.new(get_room_response.body[:get_room_response][:room])
      end

      def find_by_extension(extension)
        get_rooms_response = client.soap_client.call(:get_rooms)
        retrieved_room_hash = get_rooms_response.body[:get_rooms_response][:room].find do |room|
          room[:extension] == extension
        end
        retrieved_room_hash ? Vidyo::Room.new(retrieved_room_hash) : nil
      end

    end
  end
end
