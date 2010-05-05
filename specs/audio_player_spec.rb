require 'lib/audio_player.rb'

describe AudioPlayer do
  before(:each) do
    @player = AudioPlayer.new
    SDL::Mixer.stub!(:play_channel)
  end

  it "should play a tone" do
    SDL::Mixer.should_receive(:play_channel)
    @player.play_tone
  end

end
