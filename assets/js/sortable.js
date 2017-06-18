let sortable
let root = document.querySelector('.sortable')
let existingRoot = document.querySelector('.sortable-existing')
let selector = '#set_ids'
let groupName = 'sets'

if (window.Sortable) {
    if (root) {
        Sortable.create(root, {
            handle: '.sortable-cursor',
            group: groupName,
            sort: false,
        })
    }
    if (existingRoot) {
        Sortable.create(existingRoot, {
            handle: '.sortable-cursor',
            group: groupName,
            sort: false,
            
            onAdd(e) {
                // Make sure inputs are enabled
                $(e.item).children(selector).prop('disabled', false)
            },
            onRemove(e) {
                // Make sure inputs are disabled
                $(e.item).children(selector).prop('disabled', true)
            },
        })
    }
}

export default sortable