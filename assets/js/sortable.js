let sortable
let root = document.querySelector('.sortable')
let existingRoot = document.querySelector('.sortable-existing')

if (window.Sortable) {
    if (root) {
        Sortable.create(root, {
            handle: '.sortable-cursor',
            animation: 150,
            group: 'cards'
        })
    }
    if (existingRoot) {
        function removeOrderEl($el) {
            $el.children(".sortable-order").text('')
        }
        function setOrder($el, idx) {
            $el.children(".sortable-order").text(parseInt(idx) + 1)
        }
        function resetInputs($el, disabled = false) {
            $el.children("#set_cards_id").prop('disabled', disabled)
        }
        function orderCards(e, from = false) {
            let list = from ? e.from.children : e.to.children
            if (list.length > 0) {
                Array.from(list).forEach((item, idx) => {
                    const $item = $(item)
                    setOrder($item, idx)
                })
            }
        }
        Sortable.create(existingRoot, {
            handle: '.sortable-cursor',
            animation: 150,
            group: 'cards',
            onAdd(e) {
                // Make sure inputs are enabled then sort via index
                const $item = $(e.item)
                resetInputs($item)
                orderCards(e)
            },
            onRemove(e) {
                // Make sure inputs are disabled then sort via index
                const $item = $(e.item)
                resetInputs($item, true)
                orderCards(e, true) // from will be this list
                removeOrderEl($item)
            },
            onUpdate(e) {
                orderCards(e)
            }
        })
    }
}

export default sortable