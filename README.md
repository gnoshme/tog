DEPENDENCIES
- it will tell you what gems you need if you don't have them, and how to install them but the tether module falls on its face on linux if you don't have packages gphoto2 and libgphoto2-dev installed.


Not sure that this is ready for prime time but here you go anyway.

If you are checking it out here's the bottom line.

The tool is made up of "modules".  There are CORE, EXTENTION and CUSTOM modules.  

CORE and EXTENSION are part of the codebase.  CUSTOM are modules someone else might add.

CORE modules are special. They are auto installed.

EXTENSIONS are user installed through the system.. custom still working out.

GETTING STARTED

- assuming you have ruby installed
- clone the git repo
- run the "tog" executable
- install modules
- it's a good idea to look at the module settings files at this point to understand what it does and what the defaults are.

Most useful if you add tog to your path and start using the command line methods, 

- e.g. tog create my-new-set
- e.g. tog find [part-of-set-name]


PHILOSOPHY

Tog is a workflow power tool.  It assumes you want to be organized,  have a standard way of dealing with your shoot files, and that you have somewhat of a linear process. What I mean by that is that you start off with raw files, then you go through one or more steps to get to final files.  

With that in mind,  tog can help you:

- setup an organized structure for working on a shoot set
- help you move things through the process
- automatically do things to files that you consider "final" (like make Instagram and resized versions)
- archive sets into meaningful groups

DEFAULTS

There are some default settings, and the best way to know what they are is to look at the settings files after installing a module, but here are some basics:

Basics

- ~/shoots # directory where all your current shoots are organized
- ~/archives # directory where you archive shoots.. this should contain subdirectories, e.g. "Landscapes", "Portraits" etc.

Sets:

e.g. if you run "tog create vacation" it will create:

- ~/shoots/01-01-2018-vacation/
- ~/shoots/01-01-2018-vacation/raw-files/
- ~/shoots/01-01-2018-vacation/final-images/
- ~/shoots/01-01-2018-vacation/discards/
- .. and other directories depending on what you want to do for workflow

Other modules if left to default will create:

- ~/shoots/01-01-2018-vacation/instagrammed
- ~/shoots/01-01-2018-vacation/resized


MY OWN WORKFLOW

I work mostly portraits, so here's my workflow to give you an idea of config and settings.  Here are some of my settings, and why:

CORE

- $workflow1_directory = '1-pp' #I export images here from my raw editor
- $workflow2_directory = '2-gimp' #tog moves images here with the post1 step, and I work on them in gimp
- $other_shoot_directories = "proofs" #I make tog auto-create this folder in my set because I use it all the time.

DECLUTTER

$declutter_directories = "proofs, instagramed, resized" #because this is stuff I don't want to archive.

.. because I have two workflow steps between my raw editor (darktable) and images being final.  I export JPGs out of darktable to the first workflow directory,  1-pp.  When I'm done on them there 


MORE ABOUT MODULES

An extension has 3 files checked into the repo.


- MODULE-lib.rb contains some setup and methods
- MODULE-actions.rb contains the code that executes.
- MODULE-default-settings.rb user settings setup with default values

Much to do:

- make import work outside of the settings for me / linux
- support multiple non raw image types, e.g. tiff, png.

MORE COMPLEX STUFF (from core settings)

Just to give you an idea of power, here is some code I use in the post processing steps.   

1) TOG POST FEATURE

If I edit a file in workflow step one,  I save the result with a different file name. 

In the end I may end up with:

- pic1.jpg
- pic2.jpg
- pic2_rt.jpg #retouched version
- pic3.jpg
- pic3_rt.jpg

The following setting tells tog to "favor" files that include _rt
```
def post1
        move_pics_to_next "favor_files_matching:_rt"
end
```

.. so the result will be:

a) passed to workflow step 2:

- pic1.jpg
- pic2_rt.jpg
- pic3_rt.jpg

b) discarded

- pic2.jpg
- pic3.jpg

2) RUBY CODE

You can add any ruby code to the post methods.  In this case I move the pics in the normal way, then put the gimp files somewhere specifc.
```
def post2
        move_pics_to_next
        gimpdir = $current_set + '2-gimp/'
        gimpfilesdir = gimpdir + 'gimpfiles/'
        chkmk( gimpfilesdir )

        gimpfiles = Dir.glob( gimpdir + '*.xcf' )
        gimpfiles.each do |file|
                post_mv(file, gimpfilesdir)
        end
end
```

