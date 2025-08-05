import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["todo", "counter"]

  connect() {
    this.counterTarget.textContent = `${this.todoTargets.length}` 
  }

  todoTargetConnected(event) {
    this.updateCounter()
  }
  todoTargetDisconnected(event) {
    this.updateCounter()
  }
  updateCounter() {
    this.counterTarget.textContent = `${this.todoTargets.length}` 
  }
}