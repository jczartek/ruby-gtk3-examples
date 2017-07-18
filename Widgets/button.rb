require 'gtk3'

class ButtonWindow < Gtk::Window
  def initialize
    super 'Button Demo'
    self.window_position = :center
    self.border_width = 10
    signal_connect('delete-event') { Gtk.main_quit }

    hbox = Gtk::Box.new :horizontal, 6
    add hbox

    button = Gtk::Button.new label: 'Click Me'
    button.signal_connect('clicked') { puts '"Click me" button was clicked'}
    hbox.pack_start button, expand: true, fill: true

    button = Gtk::Button.new label: '_Open'
    button.use_underline = true
    button.signal_connect('clicked') { puts '"Open" button was clicked'}
    hbox.pack_start button, expand: true, fill: true

    button = Gtk::Button.new label: '_Close'
    button.use_underline = true
    button.signal_connect('clicked') do
      puts '"Closing application'
      Gtk.main_quit
    end
    hbox.pack_start button, expand: true, fill: true
  end
end


win = ButtonWindow.new
win.show_all

Gtk.main
