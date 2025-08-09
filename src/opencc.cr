@[Link("opencc")]
lib LibOpenCC
  alias OpenccT = Void*

  fun opencc_open = opencc_open(config : LibC::Char*) : OpenccT
  fun opencc_convert_utf8 = opencc_convert_utf8(opencc : OpenccT, input : LibC::Char*, length : LibC::SizeT) : LibC::Char*
  fun opencc_convert_utf8_free = opencc_convert_utf8_free(converted : LibC::Char*) : Void
  fun opencc_close = opencc_close(opencc : OpenccT) : Void
end

class OpenCC
  @opencc : LibOpenCC::OpenccT
  @closed = false

  def initialize(config : String)
    @opencc = LibOpenCC.opencc_open(config)
    raise "Failed to initialize OpenCC with config: #{config}" if @opencc.null?
  end

  def convert(text : String) : String
    raise "OpenCC instance has been closed" if @closed

    converted = LibOpenCC.opencc_convert_utf8(@opencc, text, text.bytesize)
    raise "Failed to convert text" if converted.null?

    result = String.new(converted)
    LibOpenCC.opencc_convert_utf8_free(converted)
    result
  end

  def close
    return if @closed
    LibOpenCC.opencc_close(@opencc) unless @opencc.null?
    @closed = true
  end

  def finalize
    close
  end
end
