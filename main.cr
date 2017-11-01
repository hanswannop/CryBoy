require "crsfml"
require "./src/cry_boy"

abort("No ROM path provided") if ARGV.size == 0
cry_boy = CryBoy.new ARGV[0]
SCALE = 4

window = SF::RenderWindow.new(SF::VideoMode.new(160*SCALE, 144*SCALE), "Cry Boy")
window.vertical_sync_enabled = true 
window.key_repeat_enabled = false

noise = Random.new

# Emulation loop
while window.open?
  # Handle event & input
  while event = window.poll_event
    case event
    when SF::Event::Closed
      window.close
    when SF::Event::KeyPressed
      # Update gamepad state
      case event.code
      when SF::Keyboard::Key::Left
        cry_boy.pad.press(Pad::Button::Left)
      when SF::Keyboard::Key::Right
        cry_boy.pad.press(Pad::Button::Right)
      when SF::Keyboard::Key::Up
        cry_boy.pad.press(Pad::Button::Up)
      when SF::Keyboard::Key::Down
        cry_boy.pad.press(Pad::Button::Down)
      when SF::Keyboard::Key::Quote
        cry_boy.pad.press(Pad::Button::A)
      when SF::Keyboard::Key::Q
        cry_boy.pad.press(Pad::Button::B)
      when SF::Keyboard::Key::A
        cry_boy.pad.press(Pad::Button::Start)
      when SF::Keyboard::Key::O
        cry_boy.pad.press(Pad::Button::Select)
      end
    when SF::Event::KeyReleased
      # Update gamepad state
      case event.code
      when SF::Keyboard::Key::Left
        cry_boy.pad.release(Pad::Button::Left)
      when SF::Keyboard::Key::Right
        cry_boy.pad.release(Pad::Button::Right)
      when SF::Keyboard::Key::Up
        cry_boy.pad.release(Pad::Button::Up)
      when SF::Keyboard::Key::Down
        cry_boy.pad.release(Pad::Button::Down)
      when SF::Keyboard::Key::Quote
        cry_boy.pad.release(Pad::Button::A)
      when SF::Keyboard::Key::Q
        cry_boy.pad.release(Pad::Button::B)
      when SF::Keyboard::Key::A
        cry_boy.pad.release(Pad::Button::Start)
      when SF::Keyboard::Key::O
        cry_boy.pad.press(Pad::Button::Select)
      end
    when SF::Event::LostFocus
      cry_boy.pause      
    when SF::Event::GainedFocus
      cry_boy.resume
    end
  end
  
  if(cry_boy.running)
    # Update system state
    cry_boy.step
    
    window.clear
    # Random junk for now, pull from gpu later
    pixel = SF::RectangleShape.new(SF.vector2(SCALE, SCALE))
    160.times do |x|
      144.times do |y|
         pixel.position = SF.vector2(x*SCALE, y*SCALE)
         pixel.fill_color = SF.color(noise.rand(256), noise.rand(256), noise.rand(256))
         window.draw(pixel)
      end
    end
    window.display
  end
end
