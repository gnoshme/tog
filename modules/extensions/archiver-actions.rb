if $menu_select == 'archive'
	  archive_dirs = Dir.glob( $archives + '*' )
	  if archive_dirs.size == 0
	  	togprint('warning', "Hang on a sec.. the archiver is designed to help you archive sets into folders,  e.g. Portraits vs Landscapes etc. or  January, February etc.")
	  	togprint('line', "Please go and create some folders in " + $archives)
	  	cont
	  else

	    choice = menu_from_array archive_dirs
	    destination_dir = archive_dirs[choice]

			if $offer_declutter_during_archive_dialog && $offer_declutter_during_archive_dialog == 'yes' && $declutter_directories.size > 0
	    	choice = yes_no "Do you want to declutter before archiving?"
	    	if choice == 'y'
	    		declutter = 'yes'
	    	else
	    		declutter = 'no'
	    	end	        
	    end

	    puts 
	    puts "Archive       :: " + $current_set
	    puts "to            :: " + destination_dir
	    if declutter == 'yes'
	    puts "Cleanup dirs  :: " + $declutter_directories
	  	end
			puts 

	    are_you_sure

	    if declutter == 'yes'
	    	dodeclutter
	    end
	    togprint('line', 'Started..')
	    FileUtils.mv($current_set.chomp, destination_dir, :verbose => true)
	    togprint('line', 'Finished!')
	    save_current_set(destination_dir, "yes")  
	  end
end