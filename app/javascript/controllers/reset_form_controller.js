import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

    reset(event) {
        console.log(event)
        if(event.detail.success) {
            this.element.reset()
            this.element.querySelector('.alert').remove()
        }
    }
}