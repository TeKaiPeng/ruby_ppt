

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("trix")
require("@rails/actiontext")


const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

// console.log("hello"); 

require("../scripts")
require("../stylesheets/frontend") // #如果下次跑不出來，記得要先開☁  ppt [master] ⚡  foreman start -f Procfile.dev

import "controllers"