# Running Gulp Based Tests

xStorage has introduced a number of tests that use JavaScript based modules
to validate source files (such as testing markdown files for valid syntax).
These tests are orchestrated using [Gulp](http://gulpjs.com/). In order to
allow these tests to be run Gulp and its dependencies must first be installed.
The required steps are detailed below:

1. Install [node.js](https://nodejs.org/en/download/)
1. Open a command prompt and change the directory to the xNetworking repository
1. Run the below commands to install gulp globally and to download the other
    dependencies needed automatically

    npm install gulp --global

    npm install

Once this is done, the Pester tests that require the gulp tasks to run should be
able to complete and provide the appropriate feedback on the build as you develop them.
