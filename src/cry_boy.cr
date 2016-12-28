require "./rom"
require "./mmu"
require "./cpu"

class CryBoy

  def initialize(rom_path : String)
    @running = true
    @rom = ROM.new(rom_path)
    @mmu = MMU.new(@rom)
    @cpu = CPU.new(@mmu)
  end

  def step
  end

end
