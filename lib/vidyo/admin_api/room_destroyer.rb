module Vidyo
  module AdminApi
    class RoomDestroyer < Struct.new(:client)

      def destroy_by_id(room_id)
        get_room_response = client.soap_client.call(:delete_room, message: { 'roomID' => room_id })
        get_room_response.body
      end

    end
  end
end
