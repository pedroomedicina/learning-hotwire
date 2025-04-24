class WordCount extends HTMLElement {
    connectedCallback() {
        this.target = document.getElementById(this.getAttribute("target"));
        if (this.target !== null) {
            this.countWords();
            this.counter = this.countWords.bind(this);
            this.target.addEventListener("keyup", this.counter);
        }
    }

    disconnectedCallback() {
        if (this.target !== null) {
            this.target.removeEventListener("keyup", this.counter)
        }
    }

    countWords() {
        const count = this.target.value.split(/\s+/).filter(word => word.length > 0).length;
        this.textContent = `Words: ${count}`;
    }
}

customElements.define("word-count", WordCount)