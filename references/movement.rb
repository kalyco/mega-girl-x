require 'rubygems'
require 'gosu'
require 'pry'
include Gosu

# SCREEN_HEIGHT = 1000
# SCREEN_WIDTH = 1000
# class MegaGirl < Gosu::Window
#   def initialize
#     super(640, 480, false)
#     @background = Gosu::Image.new(self, 'media/landscape.svg')
#     @player = Player.new(self)
#   end
#
# end
class GameWindow < Gosu::Window
  def initialize(width=1000, height=1000, fullscreen=false)
    super
    self.caption = 'Hello Movement'
    @x = @y = 10
    @draws = 0
    @buttons_down = 0
    @factor = 1
  end
   def update
    if button_down?(Gosu::KbLeft)
      @x -= 1
      @factor = -1
    end
     @x += 1 if button_down?(Gosu::KbRight)
     @y -= 1 if button_down?(Gosu::KbUp)
     @y += 1 if button_down?(Gosu::KbDown)
   end

   def button_down(id)
     close if id == Gosu::KbEscape
     @buttons_down += 1
   end

   def button_up(id)
     @buttons_down -= 1
   end
    def needs_redraw?
     @draws == 0 || @buttons_down > 0
    end
   def draw
     @draws += 1
     @message = Gosu::Image.from_text(
       self, info, Gosu.default_font_name, 30)
     @message.draw(@x, @y, 0)
   end
   private
   def info
     "[x:#{@x};y:#{@y};draws:#{@draws}]"
   end
end
  window = GameWindow.new
  window.show
