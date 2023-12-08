# Web Application

>**Learning outcome:**
>
>You design and build user-friendly, full-stack web applications.
>
>**Clarification:**
>
>**User friendly:** You apply basic User experience testing and development techniques.
>
>**Full-stack:** You design and build a full stack application using commonly accepted front end (Javascript-based framework) and back end techniques (e.g. Object Relational Mapping) choosing and implementing relevant communication protocols and addressing asynchronous communication issues

## Frontend
To improve the user experience on my website, I've created some elements with tailwind css. The following images are made tailwind css.

#### Login page

![](DIV-login.png)  


#### Register page
the Login page and the Register page look quite similar. This is to enhance the UX.

![](register.png)

#### Landing page after login

This is the landing page after the user logs in. This user already has a set of audio bites, and the user can add these to a board, or they can delete them. This page also allows the user to add multiple (.mp3) files to the board. at the bottom of the page, the user gets greeted with their name (yes the name in this instance is `string`). 

The Component that stays the same on every page after login is the sidebar. In the sidebar you can click on different elements to go to a specific page, view your name and logout if necessary.

The component that displays the different soundbites also stays the same across the website.

![](DIV-landingpage.png)

#### Uploading files
The image displays the user uploading files. When the `Upload` button gets pressed, a spinning circle appears to indicate that the application is busy with uploading the files

![](uploading.png)

#### soundboard page

On this page, you can see what files are added to the soundboard. The user has the ability to delete the soundboard, remove files from the board and play the sounds

![](soundboard_board.png)

## Backend

The backend is made in c# with the web api template. The user doesn't directly interact with this page, and the api is normally ran without the UI, but here you can see the different endpoints that are set up so the webapp (or other applications) can interact with it.

![API.png](API.png)

In the image below you'll see a request that gets soundboards based on a userid and the data you'll receive is a list with the boardname, the id of that board, the current active sessionid and a list of audiofile related to that board

![boardsgetrequest.png](boardsgetrequest.png)


## UX Testing

For UX Testing, I basically asked my friends to do some actions on the website. I'll watch them perform some actions.
