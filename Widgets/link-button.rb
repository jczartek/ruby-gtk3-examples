require 'gtk3'

class LinkButtonWindow < Gtk::Window
  def initialize
    super 'LinkButton Demo'
    self.window_position = :center
    self.border_width = 10
    signal_connect('delete-event') { Gtk.main_quit }

    button = Gtk::LinkButton.new 'http://www.gtk.org'
    button.label = 'Visit Gtk+ Homepage'
    add button
  end
end

win = LinkButtonWindow.new
win.show_all
Gtk.main
