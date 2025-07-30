import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  connect() {
    this.sortable = new Sortable(this.element, {
        animation: 150,
        ghostClass: "ghost",
        onEnd: this.onEnd.bind(this)
    })
  }

  disconnect() {
    this.sortable?.destroy()
  }

  onEnd(event) {
    const url = event.item.dataset.repositionUrl
    const data = { position: event.newIndex + 1 }
    const csrfToken = document.querySelector("meta[name='csrf-token']").content

    fetch(url, {
      method: "PATCH",
      headers: { "X-CSRF-Token": csrfToken, "Content-Type": "application/json" },
      body: JSON.stringify(data)
    })
  }
}