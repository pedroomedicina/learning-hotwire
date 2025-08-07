import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["counter"]
  static outlets = ["todo"]

  connect() {
    this.boundUpdate = this.updateCounter.bind(this)
    document.addEventListener("turbo:morph", this.boundUpdate)
  }

  disconnect() {
    document.removeEventListener("turbo:morph", this.boundUpdate)
  }

  todoOutletConnected(element) {
    this.updateCounter()
  }
  todoOutletDisconnected(element) {
    this.updateCounter()
  }
  updateCounter() {
    const completed = this.todoOutlets.filter(todo => todo.complete).length
    this.counterTarget.textContent = `${completed} of ${this.todoOutlets.length} complete` 
  }
}