# Contact Application

This mixed application demonstrates a cohesive architecture between a .net core 6.0 authentication system that manages registration, registration confirmation, login, and password reset functionality and a classic ASP system that manages CRUD operations for a contact list.

### Architecture

The Classic ASP application features a system that somewhat emulates MVC architecture found in more modern applications, utilizing a "master" page to enable rapid production of page shells, allowing a certain degree of separation of concerns, DRY, and keeping code tight, lean, and organized so that any bugs are more easily solvable.

The database layer is encapsulated via a main database class that is instantiated once and available throughout the application, as well as repository classes that keep much of the interactions with the database mostly isolated from the business and presentation layers.

Parameterized queries are utilized throughout in order to prevent SQL Injection and all external input is sanitized before being sent into the database.

jQuery and Tailwind CSS are utilized for their capability of rapid development of UI/UX components

### Session

Session state is maintained between the .net application and the Classic ASP application via a shared database, with the .net application setting a session variable and then serializing the entire session contents (providing flexibility for potential future data to be passed via this method) before storing them in the database upon login. Session state is retrieved by the classic ASP application via a session bridge whereby a session id defined by the .net application is passed to it which acts as an index for retrieval of session state information for subsequent deserialization and reconstruction. The session id is a GUID which effectively prevents those who might stumble upon the session bridge from randomly hijacking user sessions.

### Additional Touches 

The contact application features a modern UI, empty page states complete with call to action to direct the user what to do next, and filtration.