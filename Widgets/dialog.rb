require 'gtk3'

class DialogExample < Gtk::Dialog
  def initialize(parent)
    super(title: 'My Dialog', parent: parent, flags: :destroy_with_parent,
          buttons: [[Gtk::Stock::CANCEL, :cancel], [Gtk::Stock::OK, :ok]])

    self.default_width = 150
    self.default_height = 100

    label = Gtk::Label.new 'This is a dialog to display additional information'

    box = content_area
    box.add label
    show_all
  end
end

class DialogWindow < Gtk::Window
  def initialize
    super 'Dialog Demo'
    self.window_position = :center
    self.border_width = 6
    signal_connect('delete-event') { Gtk.main_quit }

    button = Gtk::Button.new label: "Open dialog"
    button.signal_connect('clicked') do
      dialog = DialogExample.new self
      response = dialog.run

      case response
      when Gtk::ResponseType::OK
        puts 'OK'
      when Gtk::ResponseType::CANCEL
        puts 'Cancel'
      end

      dialog.destroy
    end
    add button
  end
end

win = DialogWindow.new
win.show_all

Gtk.main
