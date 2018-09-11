Not sure that this is ready for prime time but here you go anyway.

If you are checking it out here's the bottom line.

The tool is made up of "modules".  There are CORE, EXTENTION and CUSTOM modules.  

CORE and EXTENSION are part of the codebase.  CUSTOM are modules someone else might add.

CORE modules are special. They are auto installed.

EXTENSIONS are user installed through the system.. custom still working out.

An extension has 3 files checked into the repo.

- MODULE-lib.rb contains some setup and methods
- MODULE-actions.rb contains the code that executes.
- MODULE-default-settings.rb user settings setup with default values

Much to do:
- tidy up default methods so that the installer displays useful stuff after installing a module
- make import work outside of the settings for me / linux
- support multiple non raw image types, e.g. tiff, png.

