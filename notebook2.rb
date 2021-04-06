#!/usr/bin/env ruby
#http://ruby-gnome2.osdn.jp/hiki.cgi?tut-gtk2-contwidg-notebooks
require 'gtk3'

def prev_tab(notebook)
  if notebook.page == 0
    notebook.set_page(notebook.n_pages - 1)
  else
    notebook.prev_page
  end
end
def next_tab(notebook)
  if notebook.page == notebook.n_pages - 1
    notebook.set_page(0)
  else
    notebook.next_page
  end
end

window = Gtk::Window.new(Gtk::Window::TOPLEVEL)
window.set_title  "Paned Notebook & Buttons"
window.border_width = 10
window.signal_connect('delete_event') { Gtk.main_quit }

notebook = Gtk::Notebook.new
notebook.show_tabs = false
prev_pg = Gtk::Button.new("_Previous Tab")
close   = Gtk::Button.new("_Close")
prev_pg.signal_connect( "clicked" ) { prev_tab(notebook) }
close.signal_connect( "clicked" ) { Gtk.main_quit }

(1..4).each do |i|
  label = Gtk::Label.new("Tab %d" % [i])
  button = Gtk::Button.new("_Next")
  button.signal_connect( "clicked" ) { next_tab(notebook) }
  expander = Gtk::Expander.new("You Are Viewing Tab %i" % [i])
  expander.set_expanded(true)
  expander.add(button)
  notebook.append_page(expander, label)
  expander.border_width = 10
end

hbox = Gtk::HBox.new(false, 5)
hbox.pack_end(close,   false, false, 0)
hbox.pack_end(prev_pg, false, false, 0)
paned = Gtk::VPaned.new
paned.pack1(notebook, false, false)
paned.pack2(hbox,     false, false)

window.add(paned)
window.show_all
Gtk.main
