#!/usr/bin/env ruby
require 'gtk3'

class StackWindow < Gtk::Window
  def initialize
    super 'Stack Demo'

    self.border_width = 10
    self.window_position = :center
    signal_connect('delete-event') { Gtk.main_quit }

    vbox = Gtk::Box.new :vertical, 6
    add vbox

    stack = Gtk::Stack.new
    stack.transition_type = :slide_left_right
    stack.transition_duration = 1000

    checkbutton = Gtk::CheckButton.new 'Click me!'
    stack.add_titled checkbutton, 'check', 'Check Button'

    label = Gtk::Label.new
    label.set_markup '<big>A fancy label</big>'
    stack.add_titled label, 'label', 'A label'

    stack_switcher = Gtk::StackSwitcher.new
    stack_switcher.set_stack stack

    vbox.pack_start stack_switcher, expand: true, fill: true
    vbox.pack_start stack, expand: true, fill: true
  end
end


win = StackWindow.new
win.show_all

Gtk.main
