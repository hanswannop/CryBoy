class ROM
  @data : Slice(UInt8)
  @name : String
  @cartridge_type : String

  TITLE_OFFSET = 0x134
  TITLE_SIZE = 16
  CARTRIDGE_TYPE_OFFSET = 0x147
  ROM_SIZE_OFFSET = 0x148
  RAM_SIZE_OFFSET = 0x149
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

  def initialize(path : String)
    @data = load_rom(path)
    @name = String.new(@data[TITLE_OFFSET,TITLE_SIZE])
    @cartridge_type = CARTRIDGE_TYPES[@data[CARTRIDGE_TYPE_OFFSET]]
    puts @data
    puts @name
    puts @cartridge_type
    
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
