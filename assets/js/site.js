let site;

$(() => {
    if ($.Redactor) {
        $('textarea').redactor()
    }
    $('.carousel').carousel({indicators: true,noWrap: true});
    $(".button-collapse").sideNav()
    $('.modal').modal();
});

export default site;