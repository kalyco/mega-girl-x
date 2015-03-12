require 'rubygems'
require 'gosu'
include Gosu

module Tiles
  Earth = 1
end

SCREEN_HEIGHT = 1000
SCREEN_WIDTH = 1000
class MegaGirl < Gosu::Window

  def initialize
    super(640, 480, false)
    @background = Gosu::Image.new(self, 'media/landscape.svg')
    @player = Player.new(self)
    @player.warp(320,240)
    @large_font = Gosu::Font.new(self, "Futura", SCREEN_HEIGHT / 20)
  end

  def update
    if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
      @player.turn_left
    end
    if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
      @player.turn_right
    end
    if button_down? Gosu::KbUp or button_down? Gosu::GpButton0 then
      @player.accelerate
    end
    @player_move
  end

  def draw
    @player.draw
    @background.draw(0,0,0);
    def draw_text(x, y, text, font, color)
      font.draw(text, x, y, 3, 1, 1, color)
    end
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end


class Player
  def initialize(window)
    @dir = :right
    #character direction
    @standing, @walk1, @walk2, @jump =
    @image = Gosu::Image.new(window, "media/mega_girl.png", false)
    @cur_image = @standing
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
  end

  def warp(x,y)
    @x, @y = x,y
  end

  def turn_left
    @x-= 4.5
    @dir = :left
  end

  def turn_right
    @x+= 4.5
    @dir = :right
  end

  def move
  @x += @vel_x
  @y += @vel_y
  @x %= 640
  @y %= 480
  @vel_x *= 0.95
  # player velocity?
  @vel_y *= 0.95
  end

  def accelerate
  #offset_x and offset_y are functions similar to what people use sin/cos for.
  # ex: if something moves 100 pixels at an angle of 30°
  @vel_x += Gosu::offset_x(@angle, 0.5)
  @vel_y += Gosu::offset_y(@angle, 0.5)
  end

  def draw
    # flip when facing left
    if @dir == :left then
      offs_x = -25
      factor = -1.0
    else
      offs_x = 25
      factor = 1.0
    end

  #player drawn at z=1, above background
  #puts image center at x,y not upper left corner
  @cur_image.draw(@x + offs_x, @y - 80, 1, factor, 1.0)
  # Could the object be placed at x + offs_x/y + offs_y without being stuck?
  end


end

window = MegaGirl.new.show
window.show
