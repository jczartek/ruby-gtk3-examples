require 'gtk3'

class RadioButtonWindow < Gtk::Window
  def initialize
    super 'RadioButton Demo'
    self.window_position = :center
    self.border_width = 10
    signal_connect('delete-event') { Gtk.main_quit }

    hbox = Gtk::Box.new :horizontal, 6
    add hbox

    callback = ->(button, name) {
      state = button.active? ? 'on' : 'off'
      puts "Button #{name} was turned #{state}"
    }

    button1 = Gtk::RadioButton.new label: 'Button 1'
    button1.signal_connect 'toggled', '1', &callback
    hbox.pack_start button1

    button2 = Gtk::RadioButton.new member: button1, label: 'Button 2'
    button2.signal_connect 'toggled', '2', &callback
    hbox.pack_start button2

    button3 = Gtk::RadioButton.new member: button2, label: 'B_utton 3', use_underline: true
    button3.signal_connect 'toggled', '3', &callback
    hbox.pack_start button3
  end
end

win = RadioButtonWindow.new
win.show_all

Gtk.main
