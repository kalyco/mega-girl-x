var sprite = require('css-sprite');

sprite.create({
  src: ['./desktop/mega_girl_x/media/mega_girl/*.png'],
  out: './dist/img',
  name: 'sprites',
  style: './dist/scss/_sprites.scss',
  cssPath: 'desktop/mega_girl_x/media/mega_girl',
  processor: 'scss'
}, function() {
  console.log('done');
});
