require 'gtk3'

class SpinButtonWindow < Gtk::Window
  def initialize
    super 'SpinButton Demo'
    self.window_position = :center
    self.border_width = 10
    signal_connect('delete-event') { Gtk.main_quit }

    hbox = Gtk::Box.new :horizontal, 6
    add hbox
    spinbutton = Gtk::SpinButton.new Gtk::Adjustment.new(0, 0, 100, 1, 10, 0)
    hbox.pack_start spinbutton

    check_numeric = Gtk::CheckButton.new 'Numeric'
    check_numeric.signal_connect('toggled') { |b| spinbutton.numeric = b.active? }
    hbox.pack_start check_numeric

    check_ifvalid = Gtk::CheckButton.new 'If Valid'
    check_ifvalid.signal_connect('toggled') { |b| spinbutton.update_policy = b.active? ? :if_valid : :always }
    hbox.pack_start check_ifvalid
  end
end

win = SpinButtonWindow.new
win.show_all

Gtk.main
