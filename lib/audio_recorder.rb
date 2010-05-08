require 'gst'

class AudioRecorder
  def record
    Gst.init

    pipeline = Gst::Pipeline.new
    alsasrc = Gst::ElementFactory.make("alsasrc")
    spectrum = Gst::ElementFactory.make("spectrum")
    spectrum.set_property('bands', 20)
    fakesink = Gst::ElementFactory.make("fakesink")

    pipeline.add(alsasrc, spectrum, fakesink)
    alsasrc >> spectrum >> fakesink 

    loop = GLib::MainLoop.new(nil, false)
    
    # listen to playback events
    bus = pipeline.bus
    bus.add_watch do |bus, message|
      case message.type
      when Gst::Message::EOS
        loop.quit
      when Gst::Message::ERROR
        p message.parse
        loop.quit
      when Gst::Message::ELEMENT
        p message.structure
        if message.source.class == Gst::ElementSpectrum
          puts "spectrum"
          puts "timestamp: " + message.structure['timestamp'].to_s
        else
          puts "element"
        end

      end
      true
    end

    # start playing
    pipeline.play
    begin
      loop.run
    rescue Interrupt
    ensure
      pipeline.stop
    end
  end

end

rec = AudioRecorder.new
rec.record

