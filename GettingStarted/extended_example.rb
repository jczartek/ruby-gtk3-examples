require 'gtk3'

class MyWindow < Gtk::Window
  def initialize
    super 'Hello World'

    self.default_height = 200
    self.default_width  = 400
    self.window_position = Gtk::WindowPosition::CENTER

    button = Gtk::Button.new :label => "Click Here"
    button.signal_connect('clicked') { puts 'Hello World!' }

    signal_connect('delete-event') { Gtk.main_quit }
    add(button)
  end
end

win = MyWindow.new
win.show_all

Gtk.main
