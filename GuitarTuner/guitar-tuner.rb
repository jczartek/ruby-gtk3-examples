require 'gtk3'
require 'glib2'
require 'gst'

# Original:
# * https://developer.gnome.org/gnome-devel-demos/3.22/guitar-tuner/guitar-tuner.c


class GTunner < Gtk::ApplicationWindow
  def initialize(app)
    super app

    @frequency = {note_E: 329.63, note_A: 440.00, note_D: 587.33,
                  note_G: 783.99, note_B: 987.00, note_e: 1318.5}

    self.window_position = :center
    self.default_width = 200

    box = Gtk::Box.new :vertical, 5
    box.valign = :center
    box.halign = :center
    add box

    %w{E A G D B e}.each do |e|
      button = Gtk::Button.new label: e
      button.signal_connect('clicked') { play_sound @frequency["note_#{e}".to_sym] }
      box.pack_start(button)
    end
  end

  def play_sound(freq)
    bin  = Gst::Pipeline.new 'pipeline'
    src  = Gst::ElementFactory.make("audiotestsrc", "source")
    sink = Gst::ElementFactory.make("autoaudiosink", "output")

    src.freq = freq
    bin << src << sink
    src >> sink
    bin.play
    GLib::Timeout.add(600) do
      bin.stop
      false
    end
  end
end

app = Gtk::Application.new "org.gtk.GuitarTuner", :flags_none

app.signal_connect "activate" do |app|
  win = GTunner.new app
  win.set_title("Guitar Tuner")
  win.show_all
end

puts app.run
