# REQUIRED METHODS
def archiver_help
  togprint('p', "The Archiver lets you move old sets and organize them into folders.  Before using it you need to create some folders in " + $archives + " that you'll be moving sets to.  After that it 'just works'")
  togprint('p', "To change the location of the archive directory,  edit the settings file settings/archiver.rb.")
end

# CHECK THE BASICS
chkmk $archives

$set_menu << "archive|ARCHIVE this set"


# HELP ITEMS
$power_user_help["archive"] ='Jumps into the Archive dialog'

# DATA ITEMS
$set_roots << $archives + '|*/*'

