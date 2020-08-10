import { Controller } from "stimulus"
// import ax from "axios";
import  Rails  from "@rails/ujs"

export default class extends Controller {
  static targets = [ "heart" ]
  
  favorite() {
    let board_id = this.data.get("board");

    Rails.ajax({   
    //這坨是個物件喔
        url: `/boards/${board_id}/favorite.json`,
        type: 'post', 
        success: (result) => {
          if (result["status"] == true) {
            this.heartTarget.classList.remove("far");
            this.heartTarget.classList.add("fas");
          } else {
            this.heartTarget.classList.remove("fas");
            this.heartTarget.classList.add("far");
          }
        },
        error: (err) => {
          console.log(err);
        }
    })


    // const token = document.querySelector("meta[name=csrf-token]").content;  因為第三行解決了，所以可以助解掉
    // ax.defaults.hearder.common['X-CSRF-Token'] = token;

    // ax.post(`/boards/${board_id}/favorite.json`)
    //   .then((result) => {
    //     if (result.data["status"] == true) {
    //       this.heartTarget.classList.remove("far");
    //       this.heartTarget.classList.add("fas");
    //     } else {
    //       this.heartTarget.classList.remove("fas");
    //       this.heartTarget.classList.add("far");
    //     }
    //   })

      // .catch(function(err)) {
      //   console.log(err);
      // }
  }
}
//   connect() {
//     this.outputTarget.textContent = 'Hello, Stimulus!'
//   }
// }
// favorite(){
//   this.heartTarget.classList.remove("far")
//   this.heartTarget.classList.add("fas")
//   console.log(heartTarget)
//   far->fas
// }
