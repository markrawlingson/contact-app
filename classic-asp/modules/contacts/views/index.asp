<!-- #include virtual="/inc/database.asp" -->
<!-- #include virtual="/modules/contacts/data/contact-repository.asp" -->
<%
    Dim contactRepository_ : Set contactRepository_ = New ContactRepository
%>

<!-- Content -->
<div>
    <!-- Empty Page State -->
    <% If contactRepository_.CountRecords() = 0 Then %>
    <div class="flex flex-col items-center p-10 justify-center h-full">

        <img src="/images/page-state/contacts/empty.svg" alt="No contacts" class="w-1/2">

        <div class="text-2xl font-semibold text-gray-500 dark:text-gray-400 pt-2">
            You don't have any contacts yet
        </div>

        <div class="text-gray-400 dark:text-gray-500">
            Start by adding a new contact
        </div>
        
        <div class="mt-4">
            <a href="/contacts/new" class="bg-orange-500 hover:bg-orange-700 text-white font-semibold py-2 px-4 rounded" rel="modal:open">Add Contact</a>
        </div>
    </div>
    <% End If %>
    <!--/ Empty Page State -->

    <!-- Records -->
    <% Server.Execute("/modules/contacts/views/_contacts.asp") %>
    <!-/- Records -->

</div>

<!-- Sliding pane -->
<div id="sliding-pane" class="fixed z-20 inset-y-0 right-0 w-1/3 bg-white border-l transform translate-x-full transition duration-300 ease-in-out">
    <div class="flex flex-col">

        <div id="close-pane" class="absolute flex items-center justify-end pr-10 text-white w-full max-w-3xl mx-auto pt-6 z-10">
            <i class="fa-solid fa-times cursor-pointer" onclick="closeSlidingPane()"></i>
        </div>

        <!-- Header -->
        <div class="relative w-full h-40 sm:h-48 px-8 sm:px-12 bg-accent-100 dark:bg-accent-700 ng-star-inserted">
            <img class="absolute inset-0 object-cover w-full h-full ng-star-inserted" src="/images/34-640x480.jpg">
        </div>
        <!--/ Header -->

        <!-- Content -->
        <div class="relative flex flex-col flex-auto items-center p-6 pt-0 sm:p-12 sm:pt-0 ng-star-inserted">
            <div class="w-full max-w-3xl"><div class="flex flex-auto items-end -mt-16">
                <div class="flex items-center justify-center w-32 h-32 rounded-full overflow-hidden ring-4 ring-white ring-bg-card">
                    <div class="w-full h-full bg-gray-200 rounded-full overflow-hidden">
                        <div class="flex items-center justify-center w-full h-full text-white text-4xl font-bold">
                            <i class="fa-solid fa-user"></i>
                        </div>
                    </div>
                </div>
                <div class="flex items-center ml-auto mb-1 gap-x-2">
                    <button id="edit-button" class="bg-gray-300 hover:bg-gray-700 text-white font-semibold py-2 px-4 rounded">Edit</button>
                    <button id="delete-button" class="bg-red-500 hover:bg-red-700 text-white font-semibold py-2 px-4 rounded">Delete</button>
                </div>
            </div>

            <div class="flex flex-col items-center mt-6 text-center">
                <div>
                    <span id="contact-first-name" class="text-4xl font-extrabold tracking-tight leading-none"></span> <span id="contact-last-name" class="text-4xl font-extrabold tracking-tight leading-none"></span>
                    <div id="contact-email" class="ml-0.5 font-light text-gray-500 text-secondary"></div>
                    <div id="contact-phone" class="ml-0.5 font-light text-gray-500 text-secondary"></div>
                </div>

            </div>
        </div>
        <!--/ Content -->

    </div>
</div>