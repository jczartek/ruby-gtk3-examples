require 'gtk3'

class ProgressBarWindow < Gtk::Window
  def initialize
    super 'ProgressBar Demo'

    self.border_width = 10
    self.window_position = :center
    signal_connect('delete-event') { Gtk.main_quit }

    vbox = Gtk::Box.new :vertical, 6
    add vbox

    progressbar = Gtk::ProgressBar.new
    vbox.pack_start progressbar, expand: true, fill: true

    button = Gtk::CheckButton.new 'Show text'
    button.signal_connect('toggled') do |btn|
      progressbar.set_text('test')
      progressbar.set_show_text btn.active?
    end
    vbox.pack_start button, expand: true, fill: true

    button = Gtk::CheckButton.new 'Activity mode'
    button.signal_connect('toggled') do |btn|
      @activity_mode = btn.active?
      if @activity_mode
        progressbar.pulse
      else
        progressbar.fraction = 0.0
      end
    end
    vbox.pack_start button, expand: true, fill: true

    button = Gtk::CheckButton.new 'Right to Left'
    button.signal_connect('toggled') do |btn|
      progressbar.inverted = btn.active?
    end
    vbox.pack_start button, expand: true, fill: true

    @activity_mode = false
    GLib::Timeout.add(50) do
      if @activity_mode
        progressbar.pulse()
      else
        new_value = progressbar.fraction + 0.01
        new_value = 0 if new_value > 1
        progressbar.fraction = new_value
      end
      true
    end
  end
end

win = ProgressBarWindow.new
win.show_all

Gtk.main
