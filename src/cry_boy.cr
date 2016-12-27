require "./rom"
require "./cpu"

class CryBoy
  def initialize(rom_path : String)
    @running = true
    @rom = ROM.new rom_path
    @cpu = CPU.new
  end

  def step
  end
end
