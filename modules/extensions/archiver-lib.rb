
# REQUIRED METHODS
def archiver_help
  puts "The Archiver lets you move old sets and organize them into folders.  Before using it you need to create some folders in " + $archives + " that you'll be moving sets to."
end

# CHECK THE BASICS
chkmk $archives

$set_menu << "archive|ARCHIVE this set"


# HELP ITEMS
$power_user_help["archive"] ='Jumps into the Archive dialog'

# DATA ITEMS
$set_roots << $archives + '|*/*'

