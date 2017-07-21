require 'gtk3'

class SwitchWindow < Gtk::Window
  def initialize
    super 'Switch Demo'
    self.window_position = :center
    self.border_width = 10
    signal_connect('delete-event') { Gtk.main_quit }

    hbox = Gtk::Box.new :horizontal, 6
    add hbox

    callback = ->(switch, _) {
      state = switch.active? ? 'on' : 'off'
      puts "Switch was turned #{state}"
    }

    switch = Gtk::Switch.new
    switch.signal_connect 'notify::active', &callback
    hbox.pack_start switch, expand: true, fill: true

    switch = Gtk::Switch.new
    switch.signal_connect 'notify::active', &callback
    switch.active = true
    hbox.pack_start switch, expand: true, fill: true
  end
end

win = SwitchWindow.new
win.show_all

Gtk.main
