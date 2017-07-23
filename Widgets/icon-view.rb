require 'gtk3'

class IconViewWindow < Gtk::Window
  def initialize
    super 'IconView Demo'
    self.window_position = :center
    self.default_width  = 200
    self.default_height = 200
    signal_connect('delete-event') { Gtk.main_quit }

    liststore = Gtk::ListStore.new GdkPixbuf::Pixbuf, String
    iconview = Gtk::IconView.new
    iconview.model = liststore
    iconview.pixbuf_column = 0
    iconview.text_column = 1

    ['edit-cut', 'edit-paste', 'edit-copy'].each do |icon|
      pixbuf = Gtk::IconTheme.default.load_icon(icon, 64, 0)
      liststore.set_values(liststore.append, [pixbuf, icon])
    end

    add iconview
  end
end

win = IconViewWindow.new
win.show_all

Gtk.main
