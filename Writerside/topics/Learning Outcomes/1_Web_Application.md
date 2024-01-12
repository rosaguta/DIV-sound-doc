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

For UX Testing, I gave my friends access to the website and I told them to:

- make an account
- upload files
- create a soundboard
- put the uploaded files in the soundboard
- create a shared instance of the soundboard they just created

here are my notes for from the tests:

![feedback_users.png](feedback_users.png)

I implemented them into the userstory acceptance criterea

![implemented_acceptance_criterea.png](implemented_acceptance_criterea.png)

and here's the implemented feature:

when entering a shared page, you'll be greeted with a prompt where you'll have to give a username/regular name.

![sharedpageprompt.png](sharedpageprompt.png)

after pressing the submit button, you'll be redirected to the shared soundboard page where you can view the connected users:

![sharedboardusers.png](sharedboardusers.png)

## Socket

But you might be asking yourself how do this all sync together between clients. The title gives it away but its by using sockets.

### Why?

I needed a quick and easy way to sync device together without using a third party software. By syncing I meant that if someone presses play on their end of the shared soundboard, It plays an audio file for all the connected users.

### implementation

For this project I used [socket.io](https://socket.io/) for handling clients. Socket.io provides a method to create different rooms. This is exactly what i need for my webapplication. Because I'm using `shared` soundboards, I need a way to keep the clients on that one soundboard.
I also could use just plain websockets for this but this requires me to reinvent the wheel, which isn't ideal.

The socket server isn't too intense on the software side:

```Javascript
const express = require('express');
const http = require('http');
const socketIo = require('socket.io');

const app = express();
const server = http.createServer(app);
const io = socketIo(server, {
    cors: {
        origin: "*" // allowing everyone to interact with this server (This isnt the most secure option but i havent gotten the time to change it)
    }
});
connectedUsers = {} //keeping a list of connected users 

io.on('connection', (socket) => {
    // console.log('A user connected');
    socket.on("joinroom", (room, user) => {
        console.log(user + " connected to " + room)
        connectedUsers[room] = connectedUsers[room] || []; 
        connectedUsers[room].push(user); // storing the connected user into the connectedusers list and storing what room they got connected too
        console.log("Room: "+room+ "\n" +"Userlist:" +connectedUsers[room]+ "\n")
        socket.join(room);
    })
    socket.on("getuserlist", (room) =>{
        console.log("pushing list to " + room)
        console.log("the list in question:" + connectedUsers[room])
        io.to(room).emit("userlist", connectedUsers[room]);
    })
    // custom userdisconnect function to remove it from the connected users list
    socket.on("userdisconnect", (room, user) => {
        console.log("retrieved user: "+user)
        if (connectedUsers[room]) {
            var index = connectedUsers[room].indexOf(user)
            if (index !== -1) { 
                connectedUsers[room].splice(index, 1)
                console.log(user + " Removed from " + room)
                console.log("new list: "+connectedUsers[room])
                io.to(room).emit("userlist",connectedUsers[room])
            }
        }
    });
    // endpoint for pushing an url (in this case an audiofile stored on a webserver) to the room that the request came from
    socket.on("geturl", (url, room) => {
        console.log("a button was pressed")
        console.log("url:", url)
        console.log("room:", room)

        io.to(room).emit('url', url)
    })

});
// starting the server
const PORT = process.env.PORT || 4000;
server.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});

```

### The whole process

When a user goes to a shared soundboard page, They will be greeted by a prompt in which they have to enter their name or something else. Upon pressing submit a request gets made to the `connection` endpoint in which they will be stored.
The user then will view the soundboard page where they can view the title of the soundboard, the audio elements and the connected users. 

The connected users are retrieved by accessing the `getuserlist` endpoint. This endpoint will return a list of connected clients of that room

upon pressing `play` on an audio element, A request gets made to the `geturl` endpoint. This endpoints responsibility is to push the audiourl to the rest of the clients of the same room. This audiourl then gets processed by the clients and put into sound.

