#! /usr/bin/env ruby
require 'fileutils'
#
# This makes no sense.. resolves as /modules/ not /modules/extensions.. Hum.
$togpath = File.expand_path(File.dirname(File.dirname(__FILE__))) + '/../'

# Load method libraries
#load ($togpath + '/lib/ui.rb')
#load ($togpath + '/lib/files.rb')
#load ($togpath + '/lib/mods.rb')
#load ($togpath + '/lib/sets.rb')
#load ($togpath + '/settings/core.rb')
#load_current_set

load ($togpath + '/settings/tether.rb')

 case ENV['ACTION']
 	
 	when 'init'
 		puts "Initializing Tether Session"
 		puts "===================================================="
 		puts 
 		unless true_if_image_viewer_is_already_running == true
 			puts "Image Preview will open as soon as you shoot an image."
 		end
 		puts "System will BEEP if you get disconnected"
 	
 	when 'download'
 		tether_state = File.read($tether_set_info_file)
 		counter = tether_state.split('|').last
 		prefix = tether_state.split('|').first
 		if prefix.nil?
 			prefix = ""
 		end

 		file_extension = ENV['ARGUMENT'].split('.').last
 		if file_extension == "NEF"
	 		if $use_camera_filename_or_counter == "counter"			 			
	 			new_file = prefix + counter.rjust(4,'0') + '.' + file_extension
	 		else
	 			new_file = prefix + ENV['ARGUMENT']
	 		end
	 		if new_file == ENV['ARGUMENT']
	 			# Nothing to do here
	 		else
		 		if File.exists?(new_file)
		 			puts "WARNING :: FILENAME EXISTS :: Not renaming file"
		 		else
		 			FileUtils.mv(ENV['ARGUMENT'], new_file )
		 			puts "Rename file as " + new_file
		 		end
		 	end
			unless $start.nil?
			  puts "Time: " + (Time.now - $start).to_s
			end  
			$start = Time.now
		end
		if file_extension == "JPG"
			FileUtils.cp(ENV['ARGUMENT'], 'preview.jpg')
	 		puts "Updating preview"
	 	end
		puts

		if $vocalize_every_x_pictures == 'yes'
			if ( counter.to_i / $vocalize_every ) == (counter.to_f / $vocalize_every)
				command = 'say "That is picture number ' + counter.to_s + '"'
				system(command) 
			end
		end
		counter = counter.to_i + 1
		File.open($tether_set_info_file, 'w') { |file| file.write(prefix + '|' + counter.to_s) }
		unless true_if_image_viewer_is_already_running == true
			system($command_to_launch_image_viewer + ' preview.NEF &')
		end
 end
