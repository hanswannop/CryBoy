class ROM
  @data : Slice(UInt8)
  @name : String

  NAME_OFFSET = 0x134

  def initialize(path : String)
    @data = load_rom(path)
    @name = String.new(@data[NAME_OFFSET,16])
    puts @data
    puts @name
  end

  def load_rom(path : String)
    abort("Could not load ROM from #{path}") unless File.file?(path) 
    File.open(path) do |file|
      data = Slice(UInt8).new file.size.to_i
      file.read data
      return data
    end
  end
end
