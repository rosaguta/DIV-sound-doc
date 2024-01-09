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


## UX Testing (GP)

for our group project a member of my team made the following Usability Tests:

**Project name:** Artificial Character Creator (ACC)

**Objective:** The primary goal of this usability testing is to evaluate the user interface and overall usability of ACC to identify areas for improvement.

Number of participants: 1

Date: 12/22/2023

Location: Onsite

Facilitator: Milan de Haart

Note Taker: Milan de Haart

Tasks:

**[ 1 ] Create a new character:**

**Objective:** Test the ease of creating a new character.

**Instructions:** Create a new character based on your own input.

**[ 2 ] Edit an existing character:**

**Objective:** Evaluate the editing functionality for characters.

**Instructions:** Edit the details of the character you created, such as changing the input, name, age, or backstory.

**[ 3 ] View versions of a character:**

**Objective:** Test the versioning feature for characters.

**Instructions:** Explore and view different versions of the character you made.

**[ 4 ] Create a new room:**

**Objective:** Assess the process of creating a new room.

**Instructions:** Create a new room based on your own input.

**[ 5 ] Edit an existing room:**

**Objective:** Test the room editing capabilities.

**Instructions:** Edit the details of the room you created, such as changing the name.

**[ 6 ] View versions of a room:**

**Objective:** Test the versioning feature for rooms.

**Instructions:** Explore and view different versions of the room you made.

**[ 7 ] Add character to a room:**

**Objective:** Evaluate the ability to associate characters with rooms.

**Instructions:** Explore and view different versions of the character you made.

**[ 8 ] View all characters:**

**Objective:** Assess the display and organization of all characters.

**Instructions:** View a list of all characters in the application.

**[ 9 ] Change viewing type of all characters:**

**Objective:** Evaluate the flexibility in displaying characters..

**Instructions:** Change the viewing type of all characters (eg. switch from grid view to list view).

**[ 10 ] View all rooms:**

**Objective:** Assess the display and organization of all rooms.

**Instructions:** View a list of all rooms in the application.

**[ 11 ] Change viewing type of all rooms:**

**Objective:** Evaluate the flexibility in viewing rooms.

**Instructions:** Change the viewing type of all rooms (e.g., switch from grid view to list view).


**Metrics:**

Success rate: 90,9%

Task completion time:

[1]: Create a new character.

40 seconds

[2]: Edit an existing character.

Not completed (1 minute, 16 seconds)

[3]: View versions of a character.

12 seconds

[4]: Create a new room.

48 seconds

[5]: Edit an existing room.

24 seconds

[6]: View versions of a room.

13 seconds

[7]: Add character to a room.

7 seconds

[8]: View all characters.

10 seconds

[9]: Change viewing type of all characters.

20 seconds

[10]: View all rooms.

2 seconds

[11]: Change viewing type of all rooms.

4 seconds

Error rate: 1
Satisfaction rating: 8.5/10

**Observations**

**Common issues:**

Difficult to identify created characters and rooms.

Confusion about the edit button when accessing versions

Unclear indication of which character or room has been edited.

Confusion when saving changes without making any edits.

Images of characters not uniform in size when displayed in lines.


**Positive feedback:**

Appreciation for the loading indicator during character generation.

The ease of adding characters to a room.

Instructions were clear.

**Recommendations**

Consider adding character names to the library view for easier identification.

Clarify the purpose of the "Edit" button in the versions tab, or provide a more intuitive way to edit characters.

Include room names alongside images for better recognition.

Enhance the visual cues to clearly indicate the character/room that has been edited.

Implement a validation mechanism to prevent saving changes without modifications.

Standardize the display of character images for consistent and aesthetically pleasing view.

Provide clearer feedback when certain actions are performed, such as clicking on "Edit" multiple times in the version tab.

**Conclusion**

In conclusion, the usability tests for the Artificial Character Creator (ACC) provided valuable insights into the application's strengths and areas for improvement. Positive feedback highlighted features such as a loading indicator and the ease of linking characters to rooms. However, common issues, including problems identifying created characters and rooms, confusion over the edit button in the versions tab and uneven display of images, point to opportunities for refinement. The recommendations aim to improve the user experience by addressing these identified areas to promote a more intuitive and user-friendly ACC.
