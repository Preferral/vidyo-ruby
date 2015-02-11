module Vidyo
  class Room

    attr_accessor(
      :id,
      :name,
      :room_type,
      :owner_name,
      :extension,
      :group_name,
      :url,
      :is_locked,
      :has_pin
    )

    def initialize(params)
      @id         = params.fetch(:room_id)
      @name       = params.fetch(:name)
      @room_type  = params.fetch(:room_type)
      @owner_name = params.fetch(:owner_name)
      @extension  = params.fetch(:extension)
      @group_name = params.fetch(:group_name)
      @url        = params.fetch(:room_mode).fetch(:room_url)
      @is_locked  = params.fetch(:room_mode).fetch(:is_locked)
      @has_pin    = params.fetch(:room_mode).fetch(:has_pin)
    end

  end
end
