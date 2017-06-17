let list

let existingListElement = document.querySelector('.js-list-existing')
let listElement = document.querySelector('.js-list')

class List { 

    constructor() {
        this.listElement = listElement
        this.existingListElement = existingListElement
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
    }

    add(item) {
        this.existingList.push(item.id)
        this.list.splice(this.list.indexOf(item.id), 1)
        this.listElement.removeChild(item)
        this.mutateElement(item)
        this.existingListElement.appendChild(item)
        // Handle the plus/minus thing and input
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
    // change + to -
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

    }
}

if (existingListElement && listElement) {
    let newList = new List()
}

export default list;