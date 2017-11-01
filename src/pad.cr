class Pad

  enum Button
    Left
    Right
    Up
    Down
    A
    B
    Start
    Select
  end

  def initialize()
    @pressed = Array(Bool).new(8, false)
  end

  def press(button : Button)
    @pressed[button.value] = true
  end

  def release(button : Button)
    @pressed[button.value] = false
  end

end         
