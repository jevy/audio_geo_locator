class Locator
  @tone_played = false

  def run
    @tones = Array.new
    @player = Speaker.new
    @player.play_tone
    @tone_played = true
  end

  def tone_played?
    @tone_played
  end

  def heard_tones
    @tones
  end
end
