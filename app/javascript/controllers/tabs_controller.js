import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static classes = ["activeTab", "inactiveTab", "panelVisible", "panelHidden"]
    static targets = ["tab", "panel"]
    static values = {
        current: { type: Number, default: 0 }
    }

    change(event) {
        this.currentValue = event.params.index ? parseInt(event.params.index) : this.tabTargets.indexOf(event.target)
        console.log(this.currentValue)
    }

    previous() {
        if (this.currentValue > 0) {
            this.currentValue--;
        }
    }

    next() {
        if (this.currentValue < this.tabTargets.length - 1) {
            this.currentValue++;
        }
    }

    currentValueChanged(newValue, oldValue) {
        if (oldValue !== undefined) {
            this.tabTargets[oldValue].classList.remove(...this.activeTabClassesWithDefault )
            this.panelTargets[oldValue].classList.add(...this.panelHiddenClassesWithDefault)
        }
        this.tabTargets[newValue].classList.add(...this.activeTabClassesWithDefault)
        this.panelTargets[newValue].classList.remove(...this.panelHiddenClassesWithDefault)
    }

    get activeTabClassesWithDefault() {
        return this.activeTabClasses.length > 0 ? this.activeTabClasses : ["active"]
    }

    get panelHiddenClassesWithDefault() {
        return this.panelHiddenClasses.length > 0 ? this.panelHiddenClasses : ["hidden"]
    }
}