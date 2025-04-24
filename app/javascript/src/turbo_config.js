Turbo.config.forms.submitter = "aria-disabled"
Turbo.config.forms.confirm = (message, element, button) => {
    let content = `
    <dialog id="confirm">
        <article>
            <h2>${message}</h2>
            <footer>
                <form method="dialog">
                <button value="cancel" class="secondary">Cancel</button>
                <button value="confirm">Confirm</button>
                </form>
            </footer>
        </article>
    </dialog>
    `;

    document.body.insertAdjacentHTML("beforeend", content)
    let dialog = document.querySelector("#confirm")
    dialog.showModal()

    return new Promise((resolve, reject) => {
        dialog.addEventListener("close", () => {
            resolve(dialog.returnValue == "confirm")
            // dialog.remove()
        })
    })
}