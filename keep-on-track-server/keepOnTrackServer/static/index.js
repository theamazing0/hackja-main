$(document).ready(function () {
    $(document).on(
        'click',
        'button[role="eventsend"]', //! Add Role Here

        function (e) {

            var name = $('#eventnameinput').val()
            var link = $('#eventlinkinput').val()
            var timestarted = $('#eventstarttimeinput').val()


            $.ajax({
                url: "createevent", //! Add URL Here
                method: "GET",
                data: {
                    "name": name,
                    "link": link,
                    "starttime": timestarted //! Add Vals Here
                },
                success: function (result) {
                    $('#createSubmissionBox').html("Creation Complete! The meeting will now be added to your students' calenders!") //! Do Something
                }
            });
        }
    );
});