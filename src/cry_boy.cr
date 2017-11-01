require "./rom"
require "./pad"
require "./mmu"
require "./cpu"

class CryBoy

  getter pad
  getter running
 
  def initialize(rom_path : String)
    @running = true
    @rom = ROM.new(rom_path)
    @pad = Pad.new()
    @mmu = MMU.new(@rom)
    @cpu = CPU.new(@mmu)
  end

  def step
  end

  def pause
    @running = false
  end

  def resume
    @running = true
  end

end
