module EY
  module Blooper

    def self.success
      with_bloops do |b|
        sanford(b)
      end
    end

    def self.error
      with_bloops do |b|
        sanford(b)
      end
    end

    def self.sanford(b)
      b.tempo = 180

      sound = b.sound Bloops::SQUARE
      sound.volume = 0.4
      sound.sustain = 0.3
      sound.attack = 0.1
      sound.decay = 0.3

      b.tune sound, "g g + e d - 4 g g + e d - a b g g g b a 4 b + d - b a e f d + d d e g g e a# + c 4 - - d6 g6 + + g6"
    end

    def self.with_bloops
      require 'bloops'

      b = Bloops.new

      yield b

      b.play

      sleep 0.02 while !b.stopped?

    rescue LoadError
      UI.warn "bloopsaphone not found. sad trombone."
    end

  end
end
