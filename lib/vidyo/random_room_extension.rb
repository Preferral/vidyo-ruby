class RandomRoomExtension

  MAX_EXTENSION_TAIL = 9_999_999_999_999_999 # 16 digits

  def initialize(base:)
    @extension_base = base
    @extension_tail = random_extension_tail
  end

  def extension
    @extension_tail ||= random_extension_tail
  end

  def increment!
    @extension_tail = (@extension_tail == MAX_EXTENSION_TAIL ? rand(MAX_EXTENSION_TAIL) : @extension_tail + 1)
  end

  private

  def random_extension_tail
    rand(MAX_EXTENSION_TAIL)
  end


end
