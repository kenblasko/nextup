let site;


$(() => {
    if ($.Redactor) {
        $('textarea').redactor()
    }
    $(".button-collapse").sideNav()
});

export default site;