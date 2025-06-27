const ExampleActions = {
    append(element) {
        const target = document.querySelector(element.target)
        target.append(element.template.content)
    }
}

class ExampleStream extends HTMLElement {
    constructor() {
        super();
        ExampleActions[this.action](this)
        this.remove();
    }

    get action() {
        return this.getAttribute("action")
    }

    get target() {
        return this.getAttribute("target")
    }

    get template() {
        return this.firstElementChild
    }
}

customElements.define("example-stream", ExampleStream)