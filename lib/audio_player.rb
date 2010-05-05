require 'sdl'

class AudioPlayer 
  def play_tone
    SDL.init(SDL::INIT_AUDIO)
    SDL::Mixer.open(44100, SDL::Mixer::DEFAULT_FORMAT, 2, 1024)
    tone = SDL::Mixer::Wave.load('lib/sounds/440Hz_44100Hz_16bit_05sec.wav')
    SDL::Mixer.play_channel(-1, tone, 0)
  end
end
