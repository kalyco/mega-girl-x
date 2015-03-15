require 'RMagick'
include Magick

cat = ImageList.new("Cheetah.jpg")
smallcat = cat.minify
smallcat.display
exit
