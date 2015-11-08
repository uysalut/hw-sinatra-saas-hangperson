class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  def guess letter
    raise(ArgumentError) if (letter == '') || (letter == nil ) || !(letter =~ /[a-zA-Z]/i)
    letter = letter.downcase
    return false if (guesses.include? letter) || (wrong_guesses.include? letter)
    if word.include? letter
      @guesses << letter
      return true
    else
      @wrong_guesses << letter
      return true
    end
  end
  
  def word_with_guesses
    result = ""
    @word.each_char do |let|
      if (@guesses.include? let)
        result << let
      else
        result << '-'
      end
    end
    result
  end
  
  def check_win_or_lose
    return :lose if @wrong_guesses.length == 7
    win = true
    @word.each_char do |let|
      win = false if !(@guesses.include? let)
    end
    win ? (return :win) : (return :play)
  end
      
  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
