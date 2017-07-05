require 'gtk3'

class BoxWindow < Gtk::Window
  def initialize
    super 'Box Window'

    self.window_position = :center
    signal_connect('delete-event') { Gtk.main_quit }

    box = Gtk::Box.new :horizontal, 6
    add box

    button1 = Gtk::Button.new label: 'Hello'
    button1.signal_connect('clicked') { puts 'Hello' }
    box.pack_start(button1, expand: true, fill: true)

    button2 = Gtk::Button.new label: 'Goodbye'
    button2.signal_connect('clicked') { puts 'Goodbye' }
    box.pack_start(button2, expand: true, fill: true)

  end
end

win = BoxWindow.new
win.show_all

Gtk.main
