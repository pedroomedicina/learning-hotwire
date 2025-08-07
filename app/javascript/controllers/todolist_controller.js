import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["counter"]
  static outlets = ["todo"]

  connect() {
    console.log(this.todoOutlets)
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