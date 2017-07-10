#!/usr/bin/env ruby
require 'gtk3'

class HeaderBarWindow < Gtk::Window
  def initialize
    super

    self.border_width = 10
    self.window_position = :center
    set_default_size 400, 200
    signal_connect('delete-event') { Gtk.main_quit }

    hb = Gtk::HeaderBar.new
    hb.show_close_button = true
    hb.title = 'HeaderBar Demo'
    self.titlebar = hb

    button = Gtk::Button.new icon_name: 'mail-send-receive-symbolic'
    hb.pack_end button

    box = Gtk::Box.new :horizontal
    box.style_context.add_class('linked')

    button = Gtk::Button.new icon_name: 'go-previous-symbolic'
    box.add button

    button = Gtk::Button.new icon_name: 'go-next-symbolic'
    box.add button

    hb.pack_start box

    add Gtk::TextView.new
  end
end

win = HeaderBarWindow.new
win.show_all

Gtk.main
