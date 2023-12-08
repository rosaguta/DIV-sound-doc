# Software Quality

>**Learning outcome:**
>
>You use software tooling and methodology that continuously monitors and improve the software quality during software development.
>
>**Clarification:**
>
>**Tooling and methodology:** Carry out, monitor and report on unit integration, regression and system tests, with attention for security and performance aspects, as well as applying static code analysis and code reviews.

## Frontend

### Cypress
For maintaining the software quality, I have set up an End-To-End test in Next.js with [Cypress](https://docs.cypress.io/guides/overview/why-cypress). The reason i chose Cypress because its easy to test the code for multiple browsers (such as firefox and chrome), and it is also possible to integrate this into a gitlab pipeline.

By monitoring if the End-To-End tests still return OK, I can ensure that the code still works / doesn't work
#### cypress in action
![](cypress.gif)

#### (partial) code behind cypress
The following code describes some basic login actions. the first `it` fills out the login form and click on `login`. as a check if the User is authenticated, I added a should operation to check if the string `Hello string` (`Hello <username>`) gets found.

The second `it` operation also fills out the login form with data but the credentials do not exist in my database so the website `should` return `Login failed`

![](cypresslogin.png)

## Backend (API)
I am making these tests because I want to know if the API is ready for deployment. For testing the general use of the application i have chosen for **Integration Tests**, And for some more specific testing i've chosen to run some UnitTests.
### Integration Tests (WIP)
For my backend I have set up some integration Tests regarding testing CRUD functionality. 

#### before and after
I have set up the following `SetUp` and `TearDown` stage
```C#
[SetUp]
public void Setup()
{
    File.Copy("appsettings.test.json", "appsettings.json", true);
    _factory = new WebApplicationFactory<Program>();

    _client = _factory.CreateClient();
}

[TearDown]
public void TearDown()
{
     
    if (_client != null)
    {
        _client.Dispose();
    }

    if (_factory != null)
    {
        _factory.Dispose();
    }
}
```

In the `SetUp` I do a few things:
- i copy the appsettings.test.json over the appsettings.json file so the integration test uses the test database I have set up.
- it creates a webapplicationfactory based on the appsettinsgs.test.json
- it creates a client from that webapplicationfactory

the _client gets used throughout the tests to do some web based actions such as executing get,post,update and delete requests.

In the `TearDown` section i basically perform a cleanup so the _client and _factory don't get left dangling when the tests finish. It's a good best practice for making sure that there are no resources dangling somewhere in the system.
#### Tests
here's a sample of what's in my integration test:
```C#
[Test]
public async Task GetBoardFromBoardid()
{
    // arrange
    int boardid = 102;
    //act
    var response = await _client.GetAsync($"/Boards/{boardid}");
    var responsebody = await response.Content.ReadAsStringAsync();
    Board board = JsonConvert.DeserializeObject<Board>(responsebody);
    //assert
    Assert.NotNull(response);
    Assert.That(response.StatusCode, Is.EqualTo(HttpStatusCode.OK));
    Assert.That(board.name, Is.EqualTo("integration_test"));
}
```
In that example i execute a simple GET request to the `/Boards/{boardid}` endpoint of my API. Then I read the body of the response and put that in a variable. For actually testing if the data that gets returned is correct i check that 

- That response is not null
- That the response statuscode returns statuscode OK (200)
- That the correct board gets returned

here Follows an integration test regarding testing the output of the API:

```C#
[Test]
public async Task CreateBoardF3romUserid_NoUserIdGiven()
{
    string boardname = "ThisGetsNeverAdded";

    var response = await _client.PostAsync($"/Boards?name={boardname}?userid=", null);
    
    Assert.That(response.StatusCode, Is.EqualTo(HttpStatusCode.BadRequest));
}
```
In the codeblock above it executes a POST request to `/Boards` with the following parameters: `?name={boardname}?userid=`. The Test will perform the following check

- It checks that the response.statuscode is equual to `badrequest`.


### unit Tests (WIP)
for now i only have 1 UnitTest for trying to retrieve a user in the Data Access Layer (DAL). 

#### before
I have created the following `SetUp` stage:

```C#
using DALTest;
private IUserDal _testdal { get; set; }
    [SetUp]
    public void SetUp()
    {
        _testdal = new UserDal();
    }
```
in This stage I set up   the Data Access layer for the unit tests that get executed. On the very first line I call the `DALTest` library I made. This library contains some static data that emulates a real database.

#### unit tests
Here follows a test for trying to retrieve a user in the database
```C#
[Test]
public void RegisterTest_AlreadyExists()
{
    var usercollection = new UserCollection(_testdal);
    bool created = usercollection.Register("rose", "van Leeuwen", "string", "Rose@mail.com", "Rose");
    Assert.That(created , Is.EqualTo(false));
}
```
In this Test I've set up the usercollection with the testdal, so it retrieves data from the simulated database. Then I actually execute the `.Register` method for trying to create a user
I check the following

- That the created variable is set to false.

### Jetbrains Qodana (NOT USED)

I've chosen for Qodana for analyzing my code

#### why Qodana?

Qodana performs static code analysis, which means it analyzes the source code without executing the program. It can detect a wide range of issues, such as code smells, potential bugs, security vulnerabilities, and adherence to coding standards. By identifying these issues early in the development process, developers can write cleaner, more maintainable code.

One of the notable features of Qodana is its integration with JetBrains IDEs, allowing developers to run code quality checks directly from the IDE interface. This tight integration simplifies the workflow for developers, making it easier to address code quality issues promptly.

*this is not yet implemented*

### Sonarcloud

I've chosen for Sonarcloud to perfrom some sofware quality checks.

#### Why a code analysis service

These services are handy for setting up coding conventions and checking if there are any bugs in the code that someone wrote. These Services can be particularly usefull for a group of developers. Every Developer has their own way of writing their code, so by setting up a service that checks if the code is maintainable / readable, you restrict the possibilities of ending up with source codes that looks different in every file you open.

#### Why Sonarcloud?

Sonarcloud has the same feature as Jetbrains Qodana: code smells, Reliability checks, security checks, code coverage, maintainablility and duplicate lines check.

i have provided an image of what my first software quality check is

![sonarcloud](sonarcloud.png)

you'll see that the security rating an E(lowest rating) is. this is because I wrote a connectionstring including the password in a file in plain text. Sonar doesn't really like that :p


You'll see in the image below that i have fixed 1 code smells error:

![codesmellsfix.png](codesmellsfix.png)

The fix was:

