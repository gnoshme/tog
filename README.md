Time out.. give me a couple of days if you've found this.  Feel free to have a look but it's not stable enough for alpha yet.  Just getting my ducks in a row.

If you are checking it out here's the bottom line.

The tool is made up of "modules".  There are CORE, EXTENTION and CUSTOM modules.  

CORE and EXTENSION are part of the codebase.  CUSTOM are modules someone else might add.

CORE modules are special. They are auto installed.

EXTENSIONS are user installed through the system.. custom still working out.

An extension has 3 files checked into the repo.


- MODULE-lib.rb contains some setup and methods
- MODULE-actions.rb contains the code that executes.
- MODULE-default-settings.rb user settings setup with default values

In terms of MVC think of:
tog is the controller  
