class ROM
  @data : Slice(UInt8)
  @title : String
  @colour : Bool
  @cartridge_type : String
  @rom_size : Int32
  @ram_size : Int32
  @japanese : Bool
  @version : UInt8

  TITLE_OFFSET = 0x134
  TITLE_SIZE = 16
  COLOUR_OFFSET = 0x143
  IS_COLOUR = 0x80
  CARTRIDGE_TYPE_OFFSET = 0x147
  ROM_SIZE_OFFSET = 0x148
  RAM_SIZE_OFFSET = 0x149
  JAPANESE_OFFSET = 0x14A
  VERSION_OFFSET = 0x14C

  # Wonder if a NamedTuple or Enum would be better for this?
  CARTRIDGE_TYPES = {
    0x00 => "ROM_ONLY",
	  0x01 => "ROM_MBC1",
	  0x02 => "ROM_MBC1_RAM",
	  0x03 => "ROM_MBC1_RAM_BATTERY",
	  0x05 => "ROM_MBC2",
	  0x06 => "ROM_MBC2_BATTERY",
	  0x08 => "ROM_RAM",
	  0x09 => "ROM_RAM_BATTERY",
    0x0B => "ROM_MMM01",
	  0x0C => "ROM_MMM01_SRAM",
	  0x0D => "ROM_MMM01_SRAM_BATTERY",
	  0x0F => "ROM_MBC3_TIMER_BATTERY",
	  0x10 => "ROM_MBC3_TIMER_RAM_BATTERY",
	  0x11 => "ROM_MBC3",
	  0x12 => "ROM_MBC3_RAM",
	  0x13 => "ROM_MBC3_RAM_BATTERY",
	  0x19 => "ROM_MBC5",
	  0x1A => "ROM_MBC5_RAM",
	  0x1B => "ROM_MBC5_RAM_BATTERY",
	  0x1C => "ROM_MBC5_RUMBLE",
	  0x1D => "ROM_MBC5_RUMBLE_SRAM",
	  0x1E => "ROM_MBC5_RUMBLE_SRAM_BATTERY",
	  0x1F => "ROM_POCKET_CAMERA",
	  0xFD => "ROM_BANDAI_TAMA5",
	  0xFE => "ROM_HUDSON_HUC3",
	  0xFF => "ROM_HUDSON_HUC1"
  }

  ROM_SIZES = {
    0x00 => 32768,
	  0x01 => 65536,
	  0x02 => 131072,
    0x03 => 262144,
    0x04 => 524288,
    0x05 => 1048576,
    0x06 => 2097152
  }

  RAM_SIZES = {
    0x00 => 0,
	  0x01 => 2048,
	  0x02 => 8192,
    0x03 => 32768,
    0x04 => 131072
  }

  def initialize(path : String)
    @data = load_rom(path)
    @title = String.new(@data[TITLE_OFFSET,TITLE_SIZE])
    puts @data[COLOUR_OFFSET]
    @colour = @data[COLOUR_OFFSET] == IS_COLOUR
    @cartridge_type = CARTRIDGE_TYPES[@data[CARTRIDGE_TYPE_OFFSET]]
    @rom_size = ROM_SIZES[@data[ROM_SIZE_OFFSET]]
    @ram_size = RAM_SIZES[@data[RAM_SIZE_OFFSET]]
    @japanese = @data[JAPANESE_OFFSET] == 0x0
    @version = @data[VERSION_OFFSET]
    
    puts "Title: #{@title}"
    puts "Colour: #{@colour}"
    puts "Cartridge Type: #{@cartridge_type}"
    puts "ROM Size: #{@rom_size/1024}KB"
    puts "RAM Size: #{@ram_size/1024}KB"
    puts "Japanese: #{@japanese}"
    puts "Version: #{@version}"
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
