class Player
  attr_reader :x, :y
  def initialize(window, x, y)
    @x, @y = x, y
    @dir = :right
    @vy = 0 #vertical velocity
    # @map = window.map << will use soon
    # Load all animation frames
    @nilness1, @nilness2, @stand, @jump, @shoot1, @shoot2, @stand_r, @jump_r,
    @shoot1_r, @shoot2_r  =
      Image.load_tiles(window, "media/sprite/sprites.png", 50, 105, false)
      # ^ this always points to the frame that is currently drawn
      # this is set in update and used in draw.
    # @shoot = Gosu::Image.new(window, "media/sprite/mega_girl_shoot.png", false)
    # @vel_x = 0.0
    # @vel_y = 0.0
    # @angle = 0.0
    # @score = 0
    # @factor = 1.0
    # @factor_offset = 0
  end
  # def rotate(angle, around_x=0, around_y=0); end
  def draw
    # flip "vertically" (not horizontally?) when facing left
    if @dir == :left then
      @cur_image = @stand_r
      @offset = :left
    else
      @cur_image = @stand
    end
    @cur_image.draw(@x, @y, 1, 1.0)
  end
    # @x = 315.5 @y = 240
  def update(move_x)
    if move_x == 0
      @cur_image = @stand
      # ^ redundant atm. need to draw running images
    # else
    #   @cur_image = (milliseconds / 175 % 2 == 0) ? @walk1 : @walk2
    end
    if (@vy < 0)
      @cur_image = @jump
    end
    # Directional walking, horizontal movement
    if move_x > 0 then
      @dir = :right
      move_x.times
      @x += 5
    end
    if move_x < 0 then
      @dir = :left
      (-move_x).times
      @x -= 5
    end

    # Acceleration/gravity
    # by adding 1 each frame, and (ideally) vy to y, the player jumping curve
    # will the the parabole we want it to be.
    @vy += 1
    # Vertical movement
    if @vy < 0 then
      @vy.times {  @y += 1 } #{ if would_fit(0,1) then
    #else @vy = 0 end }
      # @cur_image = @jump
    end
    if @vy < 0 then
      (-@vy).times { @y -= 1 } #{ if would_fit(0,-1) then
       #else @vy = 0 end }
    end
    def try_to_jump
      @vy -= 20
    end
  end
end
    # if button_down? Gosu::KbUp or button_down? Gosu::GpButton0 then
    #   @cur_image = @jump
    # end

    # def warp(x,y)
    #   @x, @y = x,y
    # end

  # def move
  # @x += @vel_x
  # @y += @vel_y
  # @x %= 640
  # @y %= 480
  # @vel_x *= 0.95
  # # player velocity?
  # @vel_y *= 0.95
  # end

  # def accelerate
  #offset_x and offset_y are functions similar to what people use sin/cos for.
  # ex: if something moves 100 pixels at an angle of 30°
  # @vel_x += Gosu::offset_x(@angle, 0.5)
  # @vel_y += Gosu::offset_y(@angle, 0.5)
  # end

  #player drawn at z=1, above background
  #puts image center at x,y not upper left corner
  # Could the object be placed at x + offs_x/y + offs_y without being stuck?
