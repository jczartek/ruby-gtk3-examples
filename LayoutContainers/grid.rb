#!/usr/bin/env ruby

require 'gtk3'

=begin
Gtk::Grid is a container which arranges its child widgets in rows and columns.
Children are added using Gtk::Grid#attach(). They can span multiple rows or
columns. The Gtk::Grid.attach() method takes five parameters:

  1. The child parameter is the widget to add.
  2. left is the column number to attach the left side of child to.
  3. top indicates the row number to attach the top side of child to.
  4. width and height indicate the number of columns that the child will span,
     and the number of rows that the child will span, respectively.

It is also possible to add a child next to an exisiting child, using
Gtk::Grid#attach_next_to(), which also takes five parameters:

  1. child is the widget to add, as above.
  2. sibiling is an exisiting child widget of self (Gtk::Grid instance) or nil.
     The child widget will be placed next to sibiling, or if sibiling is nil, at
      the beginning or end of the grid.
  3. side is Gtk::PositionType indicating the side of sibiling that child is
     positioned next to.
  4. width and height indicate the number of columns and rows the child widget
     will span, respectively.

Children can be obtained from grid using Gtk::Grid#get_child_at(). The method takes two
parameters indicating the left and top edge of the cell.

Gtk::Grid can be used like a Gtk::Box by just using Gtk::Grid#add(), which will
place children next to each other in the direction determined by the 'orientation'
property (defaults to Gtk::Orientation.HORIZONTAL)
=end

class GridWindow < Gtk::Window
  def initialize
    super 'Grid Example'

    self.window_position = :center
    signal_connect('delete-event') { Gtk.main_quit }

    grid = Gtk::Grid.new
    add grid

    buttons = []
    1.upto(6) { |i| buttons << Gtk::Button.new(label: "Buttons #{i}") }

    grid.add(buttons[0])
    grid.attach(buttons[1], 1, 0, 2, 1)
    grid.attach_next_to(buttons[2], buttons[0], :bottom, 1, 2)
    grid.attach_next_to(buttons[3], buttons[2], :right, 2, 1)
    grid.attach(buttons[4], 1, 2, 1, 1)
    grid.attach_next_to(buttons[5], buttons[4], :right, 1, 1)

    raise "#{buttons[0].to_s} == #{grid.get_child_at(0, 0).to_s}" unless buttons[0] == grid.get_child_at(0, 0)
  end
end

win = GridWindow.new
win.show_all

Gtk.main
