class CPU
  def initialize(mmu : MMU)
      # Registers
      @a = 0_u8
      @b = 0_u8
      @c = 0_u8
      @d = 0_u8
      @e = 0_u8
      @h = 0_u8
      @l = 0_u8
      @f = 0_u8 # Status flags
      @sp = 0_u16 # The stack pointer
      @pc = 0_u16 # The program counter
      @mmu = mmu
  end
end
