#############################
########   MAP   ############
#############################
# class Map
#   attr_reader :width, :height , :gems
#     def intialize(window, filename)
#       # load 60*60 tiles 5px overlap in all directions.
#     @tileset = Image.load_tiles(window, "media/block.png", 60, 60, true)
#     lines = File.readlines(filename).map { |line| line.chomp }
#     @height = lines.size
#     @width = lines[0].size
#     end
#   def draw
#   # Very primitive drawing function:
#   # Draws all the tiles, some off-screen, some on-screen.
#   @height.times do |y|
#     @width.times do |x|
#       tile = @tiles[x][y]
#       if tile
#         # Draw the tile with an offset (tile images have some overlap)
#         # Scrolling is implemented here just as in the game objects.
#         @tileset[tile].draw(x * 50 - 5, y * 50 - 5, 0)
#       end
#     end
#   end
#############################
########   MAP   ############
#############################
