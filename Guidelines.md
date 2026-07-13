# Test Automation Solution Development Guidelines

The following guidelines are general and apply **Test Automation Solution** in the *Web* domain. Exceptions to the following rules may be considered, but must be justified and documented based on necessity.

## `Project Structure`

*  `test` -> automated test script code
*  `src` -> libraries developed for the project
*  `resources` -> files required for test execution that are not code

TAS uses a release process based on `Pipfile` for versioning required libraries

- Install **Python 3.12**
- Install **Nodejs 24.14.1**

```
[[source]]
url = "https://pypi.org/simple"
verify_ssl = true
name = "pypi"

[packages]
robotframework = "7.4.2"
robotframework-browser = "19.14.2"
robotframework-requests = "==0.9.7"
jsonschema = "*"

[requires]
python_version = "3.12"
```

```shell
python3 -m pip install --upgrade pip pipenv
```

- Create *virtualenv* from cloned project base folder

```shell
python3 -m pipenv install
```

- Enter into virtualenv

```shell
python3 -m pipenv shell
```

- Install **playwright precondition**

```shell
rfbrowser init
```

## `Coding style`

*  **Always** use unix/linux line terminators (`LF` or `\n`)
*  **Avoid** windows line terminators (`CRLF` or `\r\n`)
*  **Always** use multiple spaces instead of the `tab` character
*  **Always** leave an empty line at the end of the file
*  File names must be all in **lowercase**

## `Test Case`

*  Test cases and related documentation will be written in **English**
*  Any test case tagged as **under_development** is not considered **valid** for **production**
*  The **under_development** tag is used on test cases still in **development**
*  The test case must be:
    - atomic
    - independent
    - focused on a single objective
*  The test case is designed to interact **ONLY** with the portal's *web front-end*
*  Each automated test case must be independent from the execution of others:
    - the **precondition** is used to ensure that the *SUT* has all the environmental conditions to execute the **single** test case
    - the **postcondition** is used to restore all actions performed during the **single** test case (if possible)
    - if the postcondition **cannot restore** the actions performed, this must be notified and documented
*  For execution of test cases, another test case **CANNOT** be used as a precondition
*  The code of a test **CAN** be used to implement the precondition of another test case, **IF** sufficiently atomic
*  The *keywords* of a **precondition** can be saved within the **Test Suite** (except in exceptional cases)
*  The documentation of the **precondition** must describe which *business* steps are used
*  In the documentation of a test case that uses a *precondition*, the *precondition* *keyword* must be **referenced**
*  When developing test cases, logical constructs **CANNOT** be used (e.g., IF, ELSE, LOOP, TRY/EXCEPT)
*  It is mandatory to document test case code and keywords using the `[Documentation]` section

## `Page Object Model`

*  *Test Automation Solution* is dedicated to a single portal
*  Each **.resource** file in the `./src/page_object` folder represents an abstraction for interacting with the web portal
*  The name of each **.resource** file must be representative and concise (max 20 characters recommended)
*  Do not use *underscores* for **.resource** file names
*  **Page Object Models** can be *fragmented* into page components (e.g., calendar into agenda, month, week, etc...)
*  Page components should be saved within a subfolder of `page_object` that has the name of the page object (e.g., `./src/page_object/calendar/agenda.resource`)
*  If a **Page Object Model** component is shareable with other **POMs**, it is promoted to the `page_object` folder
*  The **.resource** files of components generally follow all the rules of the main files
*  In the **Page Object Model** paradigm, pay **attention** to **transition keywords** between pages
*  When in doubt about where to save the **transition keyword**, always save it within the file corresponding to the **starting** page
*  Obviously, there may be special situations regarding **transition keywords** that may require *specific* code engineering

Here is an example of *Test Automation Solution* code as described so far:

```shell
# Page Object Model
src/page_object/calendar.resource
src/page_object/calendar/
src/page_object/calendar/agenda.resource
src/page_object/calendar/mese.resource
src/page_object/calendar/settimana.resource

# Portal test library
src/wsnoc_shared.resource

# Testsuite
test/TestSuite_WebPortal.robot
```

The **Automated Testsuite** has the purpose of:
- file with extension **.robot** will contain test cases
- importing the **centralized** library for the entire portal
- **not necessarily** being a single file because it depends on the test strategy/organization

```
# Import Portal test library
Resource ../src/webportal_shared.resource

Test Case 1
    ...

Test Case 2
    ...
```

The **Portal Test Library** centralizes:
- import of all *Page Object Models* of the portal
- configuration of accessory libraries (e.g., *Browser* timeouts)
- management of **Data Driven Testing** (`to be defined`)
- *keywords* shared among all *Page Object Models* (but it is not recommended to overuse this space)

```
Library    Browser    timeout=30s

# Importing page object model
Resource ./page_object/calendar.resource
Resource ./page_object/dashboard.resource
Resource ./page_object/invoice.resource
....etc

Keyword Shared1
    ...

Keyword Shared2
    ...
```

The **Page Object Model** groups for the modeled page:
- all business *keywords* regarding dispositive actions
- all functional verification *keywords* of the page
- the import of all page components

```
# file calendar.robot

Resource 	./calendar/agenda.robot
Resource 	./calendar/month.robot
Resource 	./calendar/week.robot

Keyword oriented to business1
    ...

Keyword oriented to business2
    ...
```

## `Browser Library Locators`

* Use support variables for **locators** as much as possible
* Primarily use **CSS selectors** and **text-based locators** which are preferred in Playwright/Browser Library
* Avoid using **ID** and **NAME** locators exclusively when they might change frequently
* Locators should be saved in the **Variables** section of the corresponding **POM**
* Locators should not be used directly in the **Test Case** listing
* Consider the complexity of the locator based on the number of **characters**
* CSS selectors should be as specific as needed but not overly complex
* To simplify complex locators, approach by fragmenting into sub-variables
* You can define locators that depend on variables (but not in the *Variables* section)

### Browser Library Specific Recommendations:

* Prefer text-based selectors like `text=Login` or `"Login"` when possible as they're more resilient to UI changes
* Use role-based selectors like `role=button[name="Submit"]` which are more accessible and stable
* Utilize chaining with `>>` for more precise targeting (e.g., `div.container >> button.submit`)
* Take advantage of Browser Library's built-in support for Shadow DOM traversal
* For dynamic content, consider using `[data-testid]` attributes in your application for stable test hooks
* Use `nth=` notation for selecting specific elements from a list rather than complex indexing
* When dealing with iframes, use the `>>> selector` syntax for crossing frame boundaries

## `Keyword`

*  The name of keywords should describe the business action performed and **NOT** the low-level implementation
*  Any keyword tagged as **under_development** is not considered **valid** for **production**
*  The **under_development** tag is used on keywords still in **development**
*  Keywords should be as **atomic** as possible to ensure reusability and testability
*  Keywords should be documented describing the business process for which they are designed
*  Optionally, the documentation should include a technical description of the implemented code
*  Keywords should conclude with a verification of the expected business situation (e.g., welcome message, payment executed,...)
*  Keywords taken from a test case **CAN** be used as a precondition for a test case
*  Only in exceptional cases can keywords be developed in **Python** if there is no **Robot Framework** library that covers the necessary functional area
*  The code for keywords is saved in the `src` subfolder of the test automation project tree
*  In the case of keywords developed in **Python**, debug loggers can be used
*  Debug loggers must normally be deactivated and must generate files that contain the timestamp in the name
*  Along with the keyword code, an **executable** usage example in **Robot Framework** must be released
*  In keyword development, logical constructs can be used (e.g., IF, ELSE, LOOP, TRY/EXCEPT) as long as they are documented if not trivial
*  **Nested** logical constructs cannot be used (e.g., nested loops, nested if, multiple if/else if, etc.)

## `Branching strategy`

*  Code commits must include a concise description of the activity performed
*  If possible, avoid grouping multiple activities into a single commit
*  If development activity on a branch lasts more than **5 days**, realign the branch with the content of dev through a merge from dev to the development branch, managing any conflicts arising from it
*  If the push you are about to make is **unstable**, use a temporary branch with your nickname
*  Temporary branches **must** be destroyed immediately when they fulfill their purpose (e.g., end of activity and push to main branch)
*  If you need to execute a **merge request** to release your code, **avoid** asking for/performing this activity in the afternoon **after 5:00 PM**

![Branching strategy](branch_strategy.png){width=399 height=310}

## `Working roles`

Two roles are planned for the creation of automated test cases:
  - `Technical Test Analyst`, who is responsible for defining the structure of the automated test and preparing the necessary keywords
  - `Test Automation Engineer`, who is responsible for writing the keywords and enriching the existing documentation

## `Test Data`

*  Data refers to information that can influence the **expected result** of the executed test
*  It is not possible to save any type of data in **.robot**, **.resource**, or **.py** code
*  The official support for data storage is **.yaml**
*  Container objects are allowed in **.yaml** but **MUST NOT** have a depth of more than two levels
*  If higher levels are necessary, **evaluate** the data design
*  The **definition** of data **should** map business logic if possible and **not mechanisms** internal to the *test automation solution*
*  Exceptions to the previous rule are allowed but **must** be **evaluated**