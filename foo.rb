# Ruby gtk2 tutorial hello world
# http://ruby-gnome2.osdn.jp/hiki.cgi?tut-gtk-helloworld 
require "gtk3"
include Gtk

# signals - GLib::Instantiable objects can respond to gtk signals or x11 signals
win = Gtk::Window.new
win.set_size_request(600, 400)
win.signal_connect("delete_event") { puts "delete event occured" }
win.signal_connect("destroy") do
  puts "destroy event occured"
  Gtk.main_quit
end
win.border_width = 10
win.signal_connect("focus_in_event") { puts "focus in" }


button = Button.new(label: "hi")
button.signal_connect("clicked") { puts "hello world" }
button.signal_connect("button_press_event") { puts "button pressed" }
button.signal_connect("button_release_event") { puts "button released" }
button.signal_connect("key_release_event")  do |widget,event|
  puts "key released"
  print widget.inspect, event.inspect
end
button.set_size_request(100,50)

drawarea = DrawingArea.new
f = Frame.new
drawarea.signal_connect("button_press_event") do
  button.signal_emit("clicked")
  puts "drawarea button press"
end
f.signal_connect("button_press_event") do
  button.signal_emit("clicked")
  puts "f button press"
end
# this is the one that is called when the drawarea is clicked - zlevel?
win.signal_connect("button_press_event") do
  button.signal_emit("clicked")
  puts "win button press"
end
f.add(drawarea)
f.border_width = 20

drawarea.set_size_request(300,300)

grid = Grid.new
grid.add(button)
grid.add(f)
win.add(grid)
win.show_all

# win.present will call win.show if hidden, as well as raising it
# in stacking order, giving it keyboard focus, etc
puts Gtk::Box.ancestors

Gtk.main


