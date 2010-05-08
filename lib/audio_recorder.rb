require 'gst'

class AudioRecorder
  def record_wav(loc)
    Gst.init

    pipeline = Gst::Pipeline.new
    alsasrc = Gst::ElementFactory.make("alsasrc")
    audioconvert = Gst::ElementFactory.make("audioconvert")
    audioresample = Gst::ElementFactory.make("audioresample")
    wavenc = Gst::ElementFactory.make("wavenc")
    filesink = Gst::ElementFactory.make("filesink")
    filesink.location = loc

    pipeline.add(alsasrc, audioconvert, audioresample, wavenc, filesink)
    alsasrc >> audioconvert >> audioresample >> wavenc >> filesink

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
rec.record_wav(ARGV.first)

