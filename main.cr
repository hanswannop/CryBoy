require "crsfml"

window = SF::RenderWindow.new(SF::VideoMode.new(640, 576), "Cry Boy")
window.vertical_sync_enabled = true 
window.key_repeat_enabled = false

while window.open?
  while event = window.poll_event
    case event
      when SF::Event::Closed
        window.close
      when SF::Event::KeyPressed
 	puts "code: #{event.code}"
	puts "control: #{event.control}"
   	puts "alt: #{event.alt}"
    	puts "shift: #{event.shift}"
    	puts "system: #{event.system}"
      when SF::Event::KeyReleased
        # handle key release
      when SF::Event::LostFocus
	# pause emulation
      when SF::Event::GainedFocus
	# resume emulation
    end
  end
end
