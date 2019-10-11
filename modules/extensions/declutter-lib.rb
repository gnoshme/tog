
# REQUIRED METHODS
def declutter_help
  togprint('p', "The declutter module allows you to delete specific groups of files in your current set on demand.  This is a smart thing to do before archiving, for example, removing any files that have been auto-created, e.g. the Instagram and Resized files.  You can specify other directories to delete, e.g. you might want to clear out PROOF images before archiving to save space.")
  togprint('p', "By default,  the archiver asks if you want to declutter before archiving")
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


$set_menu << "declutter|DECLUTTER unwanted files from this set"


# HELP ITEMS
$power_user_help["declutter"] ='Jumps into the declutter dialog'

# DATA ITEMS

