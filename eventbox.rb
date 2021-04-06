#!/usr/bin/env ruby
#http://ruby-gnome2.osdn.jp/hiki.cgi?tut-gtk2-contwidg-eventbox
require 'gtk3'

def change_label(event, label)
  if event.event_type == Gdk::Event::BUTTON2_PRESS
    if label.text[0].chr == 'D'
      label.text = "I Was Double-Clicked!"
    else
      label.text = "Double-Click Me Again!"
    end
  end
end
window = Gtk::Window.new(Gtk::Window::TOPLEVEL)

window.set_title  "Event Box"
window.border_width = 10
window.set_size_request(200, -1)
# The delete_event is only needed if you plan to
# intercept the destroy / quit with a dialog box.
#
# window.signal_connect('delete_event') { false }
window.signal_connect('destroy') { Gtk.main_quit }

eventbox = Gtk::EventBox.new
label    = Gtk::Label.new('Double-click me!')

# eventbox.set_events(Gdk::Event::BUTTON_PRESS_MASK)
eventbox.events = Gdk::Event::BUTTON_PRESS_MASK

eventbox.add(label)
window.add(eventbox)

### You need to call {{ realize }} only after you add it to the
### top (including) widget.
eventbox.realize
### Only after the {{ EventBox eventbox }} is realized it will
### have an associated {{ Gdk::Window }} (see: "window" below)
# eventbox.window.set_cursor(Gdk::Cursor.new(Gdk::Cursor::HAND1))
eventbox.window.cursor = Gdk::Cursor.new(Gdk::Cursor::HAND1)

eventbox.signal_connect('button_press_event') { |w, e| change_label(e, label) }

window.show_all
Gtk.main
