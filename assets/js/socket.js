// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/web/endpoint.ex":
import {Socket} from "phoenix"

let socket
let $cardEditBtn = $('.js-card-edit')
let $submitBtn = $('.js-card-submit')
let classes = ['.js-card-submit', '.modal-textarea', '.js-card-edit']
let defaultClasses = ['.modal-content-text']

function addClasses($el) {
    let $icon = $el.find('i')
    let $modal = $el.closest('.modal')
    $icon.text('close')
    classes.forEach(c => $modal.find(c).addClass('active'))
    defaultClasses.forEach(c => $modal.find(c).removeClass('active'))
}

function removeClasses($el) {
    let $icon = $el.find('i')
    let $modal = $el.closest('.modal')
    $icon.text('edit')
    classes.forEach(c => $modal.find(c).removeClass('active'))
    defaultClasses.forEach(c => $modal.find(c).addClass('active'))
}

function handleCancelClick($el) {
    let $modal = $el.closest('.modal')
    let $modalText = $modal.find('.modal-content-text').html()
    let $editText = $modal.find('.redactor-layer')
    $editText.html($modalText)
}

function handleSocket($el, cardId) {
    if (!cardId) {
        return
    }

    socket = new Socket("/socket", {params: {card: cardId, token: window.userToken}})
    socket.connect()

    // Now that you are connected, you can join channels with a topic:
    let channel = socket.channel("card:" + cardId, {})
    // Grab modal of this card - need to use it later
    let $modal = $('#modal' + cardId) 

    channel.join()

    channel.on("card_saved", (payload) => {
        $modal.find('.modal-content-text').html(payload.body)
        removeClasses($el)
    })

    $submitBtn.on('click', function() {
        let redactorBody = $modal.find('.redactor-layer').html()
        channel.push("card_saved", {
            body: redactorBody
        })
    })
}

function closeSocket() {
    socket.disconnect()
}

if ($cardEditBtn.length) {
    $cardEditBtn.on('click', function() {
        let $el = $(this)
        let id = $el.attr('id')
        if (!$el.hasClass('active')) {
            handleSocket($el, id)
            addClasses($el)
        } else {
            closeSocket()
            removeClasses($el)
            handleCancelClick($el)
        }
    })
}

export default socket
