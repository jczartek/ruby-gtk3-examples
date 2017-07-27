require 'gtk3'

class EntryWindow < Gtk::Window
  def initialize
    super 'Entry Demo'
    self.window_position = :center
    self.default_width = 200
    self.default_height = 100
    signal_connect('delete-event') { Gtk.main_quit }

    vbox = Gtk::Box.new :vertical, 6
    add vbox

    timeout_id = 0

    entry = Gtk::Entry.new
    entry.text = 'Hello World'
    vbox.pack_start entry

    hbox = Gtk::Box.new :horizontal, 6
    vbox.pack_start hbox

    check_editable = Gtk::CheckButton.new 'Editable'
    check_editable.signal_connect('toggled') { |btn| entry.editable = btn.active? }
    check_editable.active = true
    hbox.pack_start check_editable, expand: true, fill: true

    check_visible = Gtk::CheckButton.new 'Visible'
    check_visible.signal_connect('toggled') { |btn| entry.visibility = btn.active? }
    check_visible.active = true
    hbox.pack_start check_visible, expand: true, fill: true

    pulse = Gtk::CheckButton.new 'Pulse'
    pulse.signal_connect('toggled') do |btn|
      if btn.active?
        entry.progress_pulse_step = 0.2
        timeout_id = GLib::Timeout.add_seconds(100) { entry.progress_pulse }
      else
        GLib::Source.remove(timeout_id) unless timeout_id.zero?
        timeout_id = 0
        entry.progress_pulse_step = 0
      end
    end
    pulse.active = false
    hbox.pack_start pulse, expand: true, fill: true

    icon = Gtk::CheckButton.new 'Icon'
    icon.signal_connect('toggled') do |btn|
      icon_name = btn.active? ? 'system-search-symbolic' : nil
      entry.set_primary_icon_name icon_name
    end
    icon.active = false
    hbox.pack_start icon, expand: true, fill: true
  end
end

win = EntryWindow.new
win.show_all

Gtk.main
