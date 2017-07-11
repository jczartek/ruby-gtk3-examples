require 'gtk3'

class SpinnerWindow < Gtk::Window
  def initialize
    super 'Spinner'

    self.window_position = :center
    self.border_width = 3
    signal_connect('delete-event') { Gtk.main_quit }

    box = Gtk::Box.new :vertical, 10
    spinner = Gtk::Spinner.new

    button = Gtk::ToggleButton.new label: 'Start Spinning'
    button.active = false
    button.signal_connect('toggled') do
      if button.active?
        spinner.start
        button.label = 'Stop Spinning'
      else
        spinner.stop
        button.label = 'Start Spinning'
      end
    end

    box.add button
    box.add spinner

    add box
  end
end

win = SpinnerWindow.new
win.show_all

Gtk.main
