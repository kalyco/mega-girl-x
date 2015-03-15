require 'rubygems'
require 'gosu'
require 'pry'
require_relative 'player.rb'
include Gosu

SCREEN_HEIGHT = 1000
SCREEN_WIDTH = 1000
class MegaGirl < Gosu::Window
  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false)
    @background_map = Gosu::Image.new(self, 'media/landscape.svg', true)
    @mega_girl = Player.new(self, 120, 150)
  end
  def update
    move_x = 0
    move_x -= 5 if button_down? KbLeft
    move_x += 5 if button_down? KbRight
    @mega_girl.update(move_x)
    # if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
    #   @player.turn_left
    # end
    # if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
    #   @player.turn_right
    # end
    # if button_down? Gosu::KbUp or button_down? Gosu::GpButton0 then
    #   @player.accelerate
    # end
    # @player_move
  end
  def draw
    @mega_girl.draw
    @background_map.draw(0,0,0);
    # def draw_text(x, y, text, font, color)
    #   font.draw(text, x, y, 3, 1, 1, color)
    # end
  end
  def button_down(id)
    if id == Gosu::KbUp then @mega_girl.try_to_jump
      if id == KbEscape then close end
    end
  end
end




window = MegaGirl.new
window.show
