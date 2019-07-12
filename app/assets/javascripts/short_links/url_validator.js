(function () {
    $(document).ready(function () {
        function validURL(str) {
            const pattern = new RegExp('^(https?:\\/\\/)?' + // protocol
                '((([a-z\\d]([a-z\\d-]*[a-z\\d])*)\\.)+[a-z]{2,}|' + // domain name
                '((\\d{1,3}\\.){3}\\d{1,3}))' + // OR ip (v4) address
                '(\\:\\d+)?(\\/[-a-z\\d%_.~+]*)*' + // port and path
                '(\\?[;&a-z\\d%_.~+=-]*)?' + // query string
                '(\\#[-a-z\\d_]*)?$', 'i'); // fragment locator

            return pattern.test(str);
        }

        $("#submit_url_form").on('submit', function (e) {
                if (!validURL($("#url_input").val())) {
                    e.preventDefault();
                    location.reload()
                }
            }
        );
    });
})();
