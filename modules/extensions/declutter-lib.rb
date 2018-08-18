
# REQUIRED METHODS
def declutter_help
  puts "bla bla bla"
end

def dodeclutter
  $declutter_directories.split(',').each do |dir|
		dir = dirslash(dir.strip)
		togprint('h2', "Cleaning up " + dir)
		files = Dir.glob($current_set + dir + '*')
		if files.count == 0
			togprint('p', "Nothing to do")
		else
	  	files.each do |file|
	  		puts "Removing :: " + filename(file)
	  		if $declutter_move_to_tmp_instead_of_delete == 'yes'
	  			FileUtils.mv(file, '/tmp/')
	  		else
	  			FileUtils.rm(file)
	  		end
	  	end 
	  end
	end
	if $declutter_move_to_tmp_instead_of_delete == 'yes'
  	togprint('p', "Note :: Because of your archiver settings, cleaned files have been moved to /tmp,  not actually deleted.  They will be there until your next reboot.")
  end
 end

# CHECK THE BASICS
chkmk $archives

$set_menu << "declutter|DECLUTTER unwanted files from this set"


# HELP ITEMS
$power_user_help["declutter"] ='Jumps into the declutter dialog'

# DATA ITEMS

