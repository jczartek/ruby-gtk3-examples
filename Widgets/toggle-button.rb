require 'gtk3'

class ToggleButtonWindow < Gtk::Window
  def initialize

    super 'ToggleButton Demo'
    self.window_position = :center
    self.border_width = 10
    signal_connect('delete-event') { Gtk.main_quit }

    hbox = Gtk::Box.new :horizontal, 6
    add hbox

    callback = ->(button, name) {
      state = button.active? ? 'on' : 'off'
      puts "Button #{name} was turned #{state}"
    }

    button = Gtk::ToggleButton.new label: 'Button 1'
    button.signal_connect 'toggled', '1', &callback
    hbox.pack_start button, expand: true, fill: true

    button = Gtk::ToggleButton.new label: 'Button 2'
    button.signal_connect 'toggled', '2', &callback
    hbox.pack_start button, expand: true, fill: true

  end
end


win = ToggleButtonWindow.new
win.show_all

Gtk.main
