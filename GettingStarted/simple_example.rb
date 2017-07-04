#!/usr/bin/env ruby

require 'gtk3'

win = Gtk::Window.new "Gtk Simple Sample"

win.default_height = 200
win.default_width  = 400
win.window_position = Gtk::WindowPosition::CENTER

win.signal_connect('delete-event') { Gtk.main_quit }
win.show_all

Gtk.main
