# DIV-sound-doc

> This repository is meant to be used for my IP portfolio for SEMESTER 3

## Introduction about my project
I chose to make a soundboard web application.
### Why did I make this decision?
I chose to make a soundboard web application because I wanted to play random songs throughout the discord call to make it _funnier_.
Discord already has a feature built where you can add .mp3 to a soundboard and play it, but the downside with that is,
is that it has limited slots, and you'll have to pay to add more slots. 

### What kind of technologies are used?
The **Frontend** of the application is built in [Next.js](https://nextjs.org/).
The reason I chose this framework is that it has a nice developer experience.
It's easy to implement new features to the web app without destroying the platform.
It also supports Server Side Rendering (SSR).
SSR allows you to render something on the server without putting a load on the end user

The **Backend** of the application is built in C#.
The reason I chose this language is not because I'm already familiar with the language,
but it's because I'm going to work with files and an FTP server.
I want to work with these two new features without learning a whole new language.

The backend provides API endpoints for different functions such as:
- uploading a file
- retrieving files from a board
- retrieving all boards from a user
- registering a user
- authentication
- creating a board
- deleting a board
- etc...

**File hosting** is done with a NGINX and FTP server. I can upload the files with an FTP connection, and I can embed those files with the NGINX server. If the files are correctly placed in the NGINX server, the server NGINX will automatically create hyperlinks 


## Projects
I have created the following two projects:
[DIV-SOUND-FRONTEND](https://git.digitalindividuals.com/rvleeuwen/div-sound-frontend) and the [DIV-SOUND-BACKEND](https://git.digitalindividuals.com/rvleeuwen/div-sound-backend).

### Context
[c4 models](https://digitalindividuals.notion.site/c4-models-1ac93196414b4976902ca32f7205b7a8?pvs=25)

[userstories](https://digitalindividuals.notion.site/Userstories-3a2355e5b7ea44a3b570b9ddacf641c6?pvs=4)

## learning outcomes

- [1 Web Application](./Learning%20Outcomes/1%20Web%20Application.md)
- [2 Software Quality](./Learning%20Outcomes/2%20Software%20Quality.md)
- [3 Agile Method](./Learning%20Outcomes/3%20Agile%20Method.md)
- [4 CICD](./Learning%20Outcomes/4%20CICD.md)
- [5 Cultural differences and ethics](./Learning%20Outcomes/5%20Cultural%20differences%20and%20ethics.md)
- [6 Requirements and design](./Learning%20Outcomes/6%20Requirement%20and%20design.md)
- [7 Business processes](./Learning%20Outcomes/7%20Business%20processes.md)
- [8 Professional](./Learning%20Outcomes/8%20Professional.md)