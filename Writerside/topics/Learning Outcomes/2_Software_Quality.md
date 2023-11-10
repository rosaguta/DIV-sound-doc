# Software Quality

## Cypress
For maintaining the software quality, I have set up an End-To-End test in Next.js with [Cypress](https://docs.cypress.io/guides/overview/why-cypress). The reason i chose Cypress because its easy to test the code for multiple browsers (such as firefox and chrome), and it is also possible to integrate this into a gitlab pipeline.

By monitoring if the End-To-End tests still return OK, I can ensure that the code still works / doesn't work
### cypress in action
![](cypress.gif)

### (partial) code behind cypress
The following code describes some basic login actions. the first `it` fills out the login form and click on `login`. as a check if the User is authenticated, I added a should operation to check if the string `Hello string` (`Hello <username>`) gets found.

The second `it` operation also fills out the login form with data but the credentials do not exist in my database so the website `should` return `Login failed`

![](cypresslogin.png)

## Jetbrains Qodana

I've chosen for Qodana for analyzing my code

### why Qodana

Qodana performs static code analysis, which means it analyzes the source code without executing the program. It can detect a wide range of issues, such as code smells, potential bugs, security vulnerabilities, and adherence to coding standards. By identifying these issues early in the development process, developers can write cleaner, more maintainable code.

One of the notable features of Qodana is its integration with JetBrains IDEs, allowing developers to run code quality checks directly from the IDE interface. This tight integration simplifies the workflow for developers, making it easier to address code quality issues promptly.

*this is not yet implemented*