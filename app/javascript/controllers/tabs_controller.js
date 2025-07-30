import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["tab", "panel"]
    static values = {
        current: { type: Number, default: 0 }
    }

    change(event) {
        this.currentValue = this.tabTargets.indexOf(event.target)
    }

    currentValueChanged(newValue, oldValue) {
        if (oldValue !== undefined) {
            this.tabTargets[oldValue].classList.remove("active-tab")
            this.panelTargets[oldValue].classList.add("hidden")
        }
        this.tabTargets[newValue].classList.add("active-tab")
        this.panelTargets[newValue].classList.remove("hidden")
    }
}