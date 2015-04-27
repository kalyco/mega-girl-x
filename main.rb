require 'rubygems'
require 'gosu'
require 'pry'
include Gosu

module Tiles
  Earth = 0
end

GRAVITY = 1.0
SPEED = 5.0

SCREEN_HEIGHT = 1000
SCREEN_WIDTH = 1000

GROUND =


class MegaGirl < Gosu::Window
  attr_reader :map
  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false)
    @sky = Image.new(self, "media/megaground.png", true)
    @map = Map.new(self, "media/map.txt")
    @mega_girl = Player.new(self, 120, 150, @map)
    @camera_x = @camera_y = 0
  end

  def update
    @mega_girl.update
    @camera_x = [[@mega_girl.x - 80, 0].max, @map.width * 50 - 900].min
    @camera_y = [[@mega_girl.y - 370, 0].max, @map.height * 50 - 700].min
  end

  def draw
    @sky.draw(SCREEN_HEIGHT,SCREEN_WIDTH, 0)
    translate(-@camera_x, -@camera_y) do
      @map.draw
      @mega_girl.draw
    end
  end

  def button_down(id)
    case id
    when Gosu::KbLeft
      @mega_girl.move_left(true)
    when Gosu::KbRight
      @mega_girl.move_right(true)
    when Gosu::KbUp
      @mega_girl.try_to_jump
    when Gosu::KbEscape
      close
    end
  end

  def button_up(id)
    case id
    when Gosu::KbLeft
      @mega_girl.move_left(false)
    when Gosu::KbRight
      @mega_girl.move_right(false)
    end
  end
end

class Player

  attr_reader :x, :y
  def initialize(window, x, y, map)
    @x, @y = x, y
    @move_left = false
    @move_right = false
    @dir = :right
    @vy = 0
    @map = map
    @nilness1, @nilness2, @stand, @jump, @shoot1, @shoot2, @stand_r, @jump_r,
    @shoot1_r, @shoot2_r  =
      Image.load_tiles(window, "media/sprite/sprites.png", 50, 105, false)
  end

  def move_left(enabled)
    @move_left = enabled
  end

  def move_right(enabled)
    @move_right = enabled
  end

  # def rotate(angle, around_x=0, around_y=0); end
  def draw
    if @dir == :left
      @cur_image = @stand_r
      offs_x = -25
      @offset = :left
    # elsif @vy < 0
    #   @cur_image = @jump
    else
      @cur_image = @stand
      offs_x = 25
    end
    @cur_image.draw(@x, @y, 1, 1.0)
  end

  def would_fit(offs_x, offs_y)
    # Check at the center/top and center/bottom for map collisions
    not @map.solid?(@x + offs_x, @y + offs_y) and
      not @map.solid?(@x + offs_x, @y + offs_y)
  end

  def update
    if !@move_left && !@move_right
      @cur_image = @stand
    end

    # if (@vy < 0)
    #   @cur_image = @jump
    # end

    if @move_right
      @dir = :right
      @x += SPEED
    end

    if @move_left
      @dir = :left
      @x -= SPEED
    end

    # Acceleration/gravity
    # by adding 1 each frame, and (ideally) vy to y, the player jumping curve
    # will the the parabole we want it to be.

    @vy += GRAVITY
    @y += @vy

    if @vy > 0 then
      @vy.to_i.times { if would_fit(0, 1) then @y += 1 else @vy = 0 end }
    end
    if @vy < 0 then
      (-@vy).to_i.times { if would_fit(0, -1) then @y -= 1 else @vy = 0 end }
    end
  end

  def try_to_jump
    if @map.solid?(@x, @y + 1) then
      @vy = -20
      @cur_image = @jump
    end
  end
end

class Map
  attr_reader :width, :height, :gems

  def initialize(window, filename)
    @tileset = Image.load_tiles(window, "media/test.png", 60, 60, true)
    lines = File.readlines(filename).map { |line| line.chomp }

    @height = lines.size
    @width = lines[0].size
    @tiles = Array.new(@width) do |x|
      Array.new(@height) do |y|
        case lines[y][x, 1]
        when '#'
          Tiles::Earth
        else
          nil
        end
      end
    end
  end

  def draw
    # Very primitive drawing function:
    # Draws all the tiles, some off-screen, some on-screen.
    @height.times do |y|
      @width.times do |x|
        tile = @tiles[x][y]
        if tile
          # Draw the tile with an offset (tile images have some overlap)
          # Scrolling is implemented here just as in the game objects.
          @tileset[tile].draw(x * 50 - 5, y * 50 - 5, 0)
        end
      end
    end
  end

  def solid?(x, y)
    y < 0 || @tiles[x / 50][y / 50]
  end
end

window = MegaGirl.new
window.show
