#!/usr/bin/env ruby

require 'gtk3'
require 'gdk3'

class ColorDrawingArea < Gtk::DrawingArea
  type_register

  def initialize(color)
    super()
    set_size_request 24, 24

    @rgba = Gdk::RGBA.new
    raise "Parsing the color=#{color} is failed." unless @rgba.parse(color)
  end

  # Override existing default handler of 'draw' signal
  def signal_do_draw(cr)
    super
    cr.set_source_rgba *@rgba.to_a
    cr.paint

    return false
  end
end

class FlowBoxWindow < Gtk::Window
  def initialize
    super 'FlowBox Demo'

    self.border_width = 10
    self.window_position = :center
    set_default_size 300, 200
    signal_connect('delete-event') { Gtk.main_quit }

    hb = Gtk::HeaderBar.new
    hb.title = 'FlowBox Box'
    hb.subtitle = 'Sample FlowBox app'
    hb.show_close_button = true
    self.titlebar = hb

    scrolled = Gtk::ScrolledWindow.new
    scrolled.set_policy :never, :automatic

    @flowbox = Gtk::FlowBox.new
    @flowbox.valign = :start
    @flowbox.max_children_per_line = 30
    @flowbox.selection_mode = :none

    scrolled.add @flowbox
    fill_flowbox
    add scrolled
  end

  def fill_flowbox
    colors = ['AliceBlue', 'AntiqueWhite', 'AntiqueWhite1', 'AntiqueWhite2',
              'AntiqueWhite3', 'AntiqueWhite4', 'aqua', 'aquamarine', 'aquamarine1',
              'aquamarine2', 'aquamarine3', 'aquamarine4', 'azure', 'azure1',
              'azure2', 'azure3', 'azure4', 'beige', 'bisque', 'bisque1', 'bisque2',
              'bisque3', 'bisque4', 'black', 'BlanchedAlmond', 'blue', 'blue1', 'blue2',
              'blue3', 'blue4', 'BlueViolet', 'brown', 'brown1', 'brown2', 'brown3',
              'brown4', 'burlywood', 'burlywood1', 'burlywood2', 'burlywood3',
              'burlywood4', 'CadetBlue', 'CadetBlue1', 'CadetBlue2', 'CadetBlue3',
              'CadetBlue4', 'chartreuse', 'chartreuse1', 'chartreuse2', 'chartreuse3',
              'chartreuse4', 'chocolate', 'chocolate1', 'chocolate2', 'chocolate3',
              'chocolate4', 'coral', 'coral1', 'coral2', 'coral3', 'coral4']

    colors.each do |elm|
      button = Gtk::Button.new
      area = ColorDrawingArea.new elm
      button.add area
      @flowbox.add button
    end
  end
end

win = FlowBoxWindow.new
win.show_all

Gtk.main
