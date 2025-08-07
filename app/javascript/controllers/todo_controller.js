import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox"]

  connect() {
    console.log("complete: ", this.complete)
  }

  get complete() {
    return this.checkboxTarget.checked
  }

  get incomplete() {
    return !this.complete
  }
}