#!/usr/bin/env ruby

require 'gtk3'

class ListBoxRowWithData < Gtk::ListBoxRow
  attr_reader :data

  def initialize(data)
    super()

    @data = data
    add Gtk::Label.new data
  end

  def <=>(other)
    @data.downcase <=> other.data.downcase
  end
end

class ListBoxWindow < Gtk::Window
  def initialize
    super 'ListBox Demo'

    self.border_width = 10
    self.window_position = :center
    signal_connect('delete-event') { Gtk.main_quit }

    box_outer = Gtk::Box.new :vertical, 6
    add box_outer

    listbox = Gtk::ListBox.new
    listbox.selection_mode = :none
    box_outer.pack_start listbox, expand: true, fill: true

    row = Gtk::ListBoxRow.new
    hbox = Gtk::Box.new :horizontal, 50
    row.add hbox
    vbox = Gtk::Box.new :vertical
    hbox.pack_start vbox, expand: true, fill: true

    label = Gtk::Label.new 'Automatic Date & Time'
    label.halign = :start
    vbox.pack_start(label, expand: true, fill: true)
    label = Gtk::Label.new 'Requires internet access'
    label.halign = :start
    vbox.pack_start(label, expand: true, fill: true)

    switch = Gtk::Switch.new
    switch.valign = :center
    hbox.pack_start switch

    listbox.add(row)

    row = Gtk::ListBoxRow.new
    hbox = Gtk::Box.new :horizontal, 50
    row.add hbox
    label = Gtk::Label.new 'Enable Automatic Updata'
    label.halign = :start
    check = Gtk::CheckButton.new
    hbox.pack_start label, expand: true, fill: true
    hbox.pack_start check

    listbox.add(row)

    row = Gtk::ListBoxRow.new
    hbox = Gtk::Box.new :horizontal, 50
    row.add hbox

    label = Gtk::Label.new 'Data Format'
    label.halign = :start
    hbox.pack_start label, expand: true, fill: true

    combo = Gtk::ComboBoxText.new
    combo.insert 0, '0', '24-hour'
    combo.insert 1, '1', 'AM/PM'
    hbox.pack_start combo

    listbox.add(row)

    listbox2 = Gtk::ListBox.new
    'This is a sorted ListBox Fail'.split.each { |e| listbox2.add ListBoxRowWithData.new(e) }

    box_outer.pack_start listbox2, expand: true, fill: true
    listbox2.set_sort_func do |row1, row2|
      row1 <=> row2
    end

    listbox2.set_filter_func do |row|
      row.data == 'Fail' ? false : true
    end

    listbox2.signal_connect('row-activated') { |_, row| puts row.data }
  end
end

win = ListBoxWindow.new
win.show_all

Gtk.main
