const slidingPane = document.getElementById('sliding-pane');
var timeoutId;

$(document).ready(function() {

    // Hook into 
    $('#search').on('keyup', debounceGetContacts);

    // Open modal in AJAX callback
    $(document).on("click", 'button[rel="modal:open"]', function(event) {
        event.preventDefault();
        this.blur();
        // Ensure any previous modals are removed from the DOM
        $(".modal").remove();
        $.get($(this).data("url"), function(html) {
            $(html).appendTo('body').modal({
                fadeDuration: 100
            });
            formValidation();
        });
    });

    $(document).on("click", ".contact", function(ev) {
        var contactId = $(this).data("id");
        var status = $(this).data("status");

        // If the contact is open, close it
        if (status === 'open') {
            slidingPane.classList.add('translate-x-full');
            $(this).data("status", "closed");
            return
        }

        // Otherwise, load the contact and open the pane
        $("#contact-first-name").text($(this).find(".firstName").text());
        $("#contact-last-name").text($(this).find(".lastName").text());
        $("#contact-email").text($(this).find(".email").text());
        $("#contact-phone").text($(this).find(".phone").text());

        // Set all the contacts to closed
        $(".contact").data("status", "closed");

        // Set the current contact id
        $(slidingPane).data("id", contactId);

        slidingPane.classList.remove('translate-x-full');
        $(this).data("status", "open");

    });

    // Bind submit event to the form
    $(document).on("submit", "#contact-form", function(ev) {
        ev.preventDefault();
        console.log("test")

        // Store the original button text
        var originalText = $('#contact-button').text();

        // Change button text to a loading symbol
        $('#contact-button').html('<i class="fa-spinner fa-spin"></i>');
        
        // Construct contact object based on form data
        var contact = {
            id: $("#contact-id").val(),
            firstName: $('#first-name').val(),
            lastName: $('#last-name').val(),
            email: $('#email').val(),
            phone: $('#phone').val()
        };

        // Save contact
        saveContact(contact, function() {
            // Restore original button text
            $('#contact-button').html(originalText);
            // Refresh contacts
            getContacts();
        });
    });

    $(document).on("click", "#close-pane", function(ev) {
        slidingPane.classList.toggle('translate-x-full');
        $(".contact").data("status", "closed");
    });

    $(document).on("click", "#delete-button", function(ev) {
        ev.preventDefault();

        deleteContact($(slidingPane).data("id"), function() {
            $(".contact").data("status", "closed");
            // Refresh contacts
            getContacts();
        });
    });

    $(document).on("click", "#edit-button", function(ev) {
        var url = "/contacts/edit?id=" + $(slidingPane).data("id");
        // Ensure any existing modals in the DOM are removed before new one is appended
        $(".modal").remove();
        $.get(url, function(html) {
            $(html).appendTo('body').modal();
        });
        formValidation();
    });
});

var formValidation = () => {
    // Form validation
    $("#contact-form").validate({
        errorClass: "text-red-500",
        rules: {
            "first-name": {
                required: true,
                maxlength: 32
            },
            "last-name": {
                required: true,
                maxlength: 32
            },
            email: {
                required: true,
                email: true,
                maxlength: 32
            },
            phone: {
                required: true,
                maxlength: 15
            }
        },
        messages: {
            "first-name": {
                required: "Please enter your first name",
                maxlength: "First name must be at most 32 characters long"
            },
            "last-name": {
                required: "Please enter your last name",
                maxlength: "Last name must be at most 32 characters long"
            },
            email: {
                required: "Please enter your email address",
                email: "Please enter a valid email address",
                maxlength: "Email must be at most 32 characters long"
            },
            phone: {
                required: "Please enter your phone number",
                phone: true
            }
        }
    });
}

var saveContact = (contact, callback) => {
    console.log(contact)
    $.ajax({
        url: '/modules/contacts/data/save-contact.asp',
        type: 'POST',
        data: contact,
        success: function(response) {
            toastr.success('Contact was saved!', 'Success!')
            // Call the callback function
            if (callback && typeof callback === 'function') {
                callback();
            }
        },
        error: function(xhr, status, error) {
            toastr.error('Something went wrong, the contact was not saved', 'Whoops!')
            // Call the callback function
            if (callback && typeof callback === 'function') {
                callback();
            }
        }
    });
}

var deleteContact = (contactId, callback) => {

    if (contactId === undefined || contactId === null)
    {
        toastr.error('Something went wrong, the contact was not deleted', 'Whoops!')
        return;
    }

    $.ajax({
        url: '/contacts/delete',
        type: 'POST',
        data: { id: contactId },
        success: function(response) {
            toastr.success('Contact was deleted!', 'Success!')
            // Call the callback function
            if (callback && typeof callback === 'function') {
                callback();
            }
        },
        error: function(xhr, status, error) {
            toastr.error('Something went wrong, the contact was not saved', 'Whoops!')
            // Call the callback function
            if (callback && typeof callback === 'function') {
                callback();
            }
        }
    });
}

var getContacts = () => {
    var searchTerm = $('#search').val();
    $.ajax({
        url: '/modules/contacts/views/_contacts.asp?searchTerm=' + encodeURIComponent(searchTerm),
        type: 'GET',
        dataType: 'html',
        success: function(contacts) {
            // Close the modal
            $.modal.close();
            // Close the sliding panel
            slidingPane.classList.add('translate-x-full');
            $('#contacts').parent().empty().append(contacts);
        },
        error: function(xhr, status, error) {
            console.error(xhr.responseText);
        }
    });
}

// Function to trigger getContacts after 500ms of keyup event
debounceGetContacts = () => {
    clearTimeout(timeoutId);
    timeoutId = setTimeout(getContacts, 500);
}