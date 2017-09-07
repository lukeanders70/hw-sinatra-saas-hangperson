class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def guess(letter)
    raise ArgumentError.new("must be a letter") unless letter =~ /^[abcdefghijklmnopqrstuvwxyz]/i
    letter = letter.downcase
    ret_val = true
    
    if (@guesses =~ /#{letter}/) or (@wrong_guesses =~ /#{letter}/) # if we've already seen letter
      ret_val = false
      
    elsif !(@word =~ /#{letter}/) #if word does not contain letter
      @wrong_guesses = @wrong_guesses + letter
      
    else
      @guesses = @guesses + letter
    end
    
    return ret_val
  end
    
  def word_with_guesses()
    dis = ''
    @word.each_char do |l|
      if (@guesses =~ /#{l}/)
        dis += l
      else
        dis += '-'
      end
    end
    return dis
  end
  
  def check_win_or_lose()
    won = true
    @word.each_char do |l|
      if !(@guesses =~ /#{l}/)
        won = false
      end
    end
    
    if (won)
      return :win
    elsif (@wrong_guesses.length >= 7)
      return :lose
    else
      return :play
    end
  end
    
  
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
