# Robot Framework Exercises

Test automation exercises using **Robot Framework** and **Browser Library (Playwright)**.

## Project Structure

```
robot-framework-exercises/
│
├── test/                            # Test suites
│   ├── saucedemo.robot              # SauceDemo test cases
│   └── herokuapp.robot              # The Internet (Herokuapp) test cases
│
├── src/                             # Libraries and Page Object Models
│   ├── saucedemo_shared.resource    # SauceDemo shared library
│   ├── herokuapp_shared.resource    # Herokuapp shared library
│   └── page_object/
│       ├── saucedemo/               # SauceDemo POMs
│       │   ├── login.resource
│       │   ├── products.resource
│       │   └── cart.resource
│       └── herokuapp/               # Herokuapp POMs
│           ├── addremove.resource
│           ├── basicauth.resource
│           ├── checkboxes.resource
│           ├── contextmenu.resource
│           ├── dropdown.resource
│           ├── entryadd.resource
│           ├── filedownload.resource
│           ├── fileupload.resource
│           ├── horizontalslider.resource
│           ├── jqueryui.resource
│           ├── keypresses.resource
│           ├── login.resource
│           ├── statuscodes.resource
│           └── tinymce.resource
│
├── resources/                       # Test data and support files
│   ├── downloads/                   # Downloaded files during tests
│   └── saucedemo.yaml               # SauceDemo test data
│
├── .gitignore
├── .robotcode.toml                  # RobotCode VS Code extension configuration
├── .robotidy                        # Robotidy formatter configuration
├── Pipfile                          # Python dependencies
├── robot.toml                       # Robot Framework configuration
└── run.bat                          # Script to run all tests
```

## Tech Stack

- **Python** 3.12
- **Robot Framework** 7.4.2
- **Browser Library** 19.14.2 (Playwright)
- **Node.js** 24.x

## Prerequisites

- Python 3.12
- Node.js 24.x
- pipenv

## Installation

Clone the repository:

```bash
git clone https://github.com/rikon311/robot-framework-exercises.git
cd robot-framework-exercises
```

Install Python dependencies:

```bash
python -m pipenv install
```

Activate virtual environment:

```bash
python -m pipenv shell
```

Install Playwright browsers:

```bash
rfbrowser init
```

## Running Tests

Run all tests:

```bash
python -m robot --outputdir results test/
```

Or use the batch script:

```bash
run.bat
```

Run a specific test suite:

```bash
python -m robot --outputdir results test/saucedemo.robot
python -m robot --outputdir results test/herokuapp.robot
```

## Test Cases

### SauceDemo (https://www.saucedemo.com/)

| Test Case | Description |
|-----------|-------------|
| TC01 - Valid Login | Verifies that a valid user can login and see the product list |
| TC02 - Add Products To Cart | Verifies that two products can be added to the cart |

### The Internet - Herokuapp (https://the-internet.herokuapp.com/)

| Test Case | Description |
|-----------|-------------|
| TC01 - Add & Remove Elements | Verifies add/remove element functionality |
| TC02 - Dropdown | Verifies dropdown selection functionality |
| TC03 - File Upload | Verifies file upload functionality |
| TC04 - Status Codes | Verifies HTTP status codes |
| TC05 - Horizontal Slider | Verifies slider functionality |
| TC06 - Checkboxes | Verifies checkbox interactions |
| TC07 - TinyMCE | Verifies TinyMCE editor functionality |
| TC08 - File Download | Verifies file download functionality |
| TC09 - Entry Ad | Verifies modal popup handling |
| TC10 - Key Presses | Verifies keyboard input detection |
| TC11 - Context Menu | Verifies right-click context menu |
| TC12 - Login | Verifies login form fields |
| TC13 - jQuery UI Menu | Verifies jQuery UI menu and file download |
| TC14 - Basic Auth | Verifies basic authentication |

## Guidelines

This project follows the **Test Automation Solution Development Guidelines** provided by Capgemini, including:

- Page Object Model pattern
- Atomic and independent test cases
- CSS and role-based selectors preferred
- No logical constructs in test cases
- All keywords documented with `[Documentation]`
- Test data stored in `.yaml` files
