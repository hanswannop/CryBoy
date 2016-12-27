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
 	puts "code: #{event.code}"
	puts "control: #{event.control}"
   	puts "alt: #{event.alt}"
    	puts "shift: #{event.shift}"
    	puts "system: #{event.system}"
      when SF::Event::KeyReleased
        # Update gamepad state
      when SF::Event::LostFocus
	# Pause emulation
      when SF::Event::GainedFocus
	# Resume emulation
    end
  end

  # Update system state
  cry_boy.step

  # Draw
  window.clear(SF::Color::Black)
  pixel = SF::RectangleShape.new(SF.vector2(SCALE, SCALE))
  160.times do |x|
    144.times do |y|
       pixel.position = SF.vector2(x*SCALE, y*SCALE)
       # Random junk for now, pull from gpu later
       pixel.fill_color = SF.color(noise.rand(256), noise.rand(256), noise.rand(256))
       window.draw(pixel)
    end
  end
  window.display
end
