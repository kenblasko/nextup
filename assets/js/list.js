let list

let existingListElement = document.querySelector('.js-list-existing')
let listElement = document.querySelector('.js-list')
let submitBtn = document.querySelector('.js-submit')
let priorityInputs = document.querySelectorAll('#priority')
let errorBlock = document.querySelector('.js-error-block')

class List { 

    constructor() {
        this.listElement = listElement
        this.existingListElement = existingListElement
        this.priorityInputElements = Array.from(priorityInputs)
        this.list = Array.from(listElement.children).map(item => item.id)
        this.existingList = Array.from(existingListElement.children).map(item => item.id)
        this.addEvents()
    }

    addEvents() {
        const self = this
        this.listElement.addEventListener('click', function(e) {
            const item = e.target.parentNode
            if (item && item.nodeName == "LI" && !(e.target.nodeName == "A")) {
                self.add(item)
            }
        })
        this.existingListElement.addEventListener('click', function(e) {
            const item = e.target.parentNode
            if (item && item.nodeName == "LI" && !(e.target.nodeName == "A"))  {
                self.remove(item)
            }
        })
        this.existingListElement.addEventListener('keyup', function(e) {
            if (e.code.includes('Digit') && e.target.id === "priority") {
                self.validate()
            }
        })

    }

    add(item) {
        this.existingList.push(item.id)
        this.list.splice(this.list.indexOf(item.id), 1)
        this.listElement.removeChild(item)
        this.mutateElement(item)
        this.existingListElement.appendChild(item)
    }

    remove(item) {
        this.list.push(item.id)
        this.existingList.splice(this.existingList.indexOf(item.id), 1)
        this.existingListElement.removeChild(item)
        this.restoreElement(item)
        this.listElement.appendChild(item)
    }

    // Add input priority enabled
    // change + to -
    mutateElement(item) {
        const icon = item.querySelector('i')
        const input = item.querySelector('#priority')
        const inputId = item.querySelector('#cardId')
        icon.innerText = 'remove'
        input.disabled = ""
        inputId.disabled = ""
        input.classList.remove('hide')
    }

    // Add input priority disabled
    // change - to +
    // set input val to null
    restoreElement(item) {
        const icon = item.querySelector('i')
        const input = item.querySelector('#priority')
        const inputId = item.querySelector('#cardId')
        icon.innerText = 'add'
        inputId.disabled = "disabled"
        input.disabled = "disabled"
        input.value = null
        input.classList.add('hide')
    }

    validate() {
        let error = false
        let inputs = Array.from(this.existingListElement.children).map(i => i.querySelector("#priority"))

        for (let i = 0; i < inputs.length - 1; i++) {
            let inputVal = inputs[i].value
            let nextInputVal = inputs[i + 1].value
            if (inputVal === nextInputVal) {
                error = true
                break
            }
        }

        if (error) {
            submitBtn.disabled = "disabled"
            errorBlock.innerText = "Two cards cannot have the same priority."
        } else {
            submitBtn.disabled = ""
            errorBlock.innerText = ""
        }

    }
}

if (existingListElement && listElement) {
    let newList = new List()
}

export default list