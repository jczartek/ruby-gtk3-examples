#!/usr/bin/env ruby

require 'gtk3'

class NBWindow < Gtk::Window
  def initialize
    super

    self.border_width = 3
    self.window_position = :center
    signal_connect('delete-event') { Gtk.main_quit }

    nb = Gtk::Notebook.new
    add nb

    page = Gtk::Box.new :vertical
    page.border_width = 10
    page.add Gtk::Label.new('Default Page');
    nb.append_page page, Gtk::Label.new('Plain Title')

    page = Gtk::Box.new :vertical
    page.border_width = 10
    page.add Gtk::Label.new('A page with an image for a title')
    image = Gtk::Image.new icon_name: 'help-about', size: :menu
    nb.append_page page, image
  end
end

win = NBWindow.new
win.show_all

Gtk.main
