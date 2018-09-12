
if $menu_select == 'tether'
	hook_path = togpath('!tog/modules/extensions/tether-hookscript.rb')
	Dir.chdir($current_set + $raw_file_directory)

	if File.exists?($tether_set_info_file)
		tether_state = File.read($tether_set_info_file)
		counter = tether_state.split('|').last
		prefix = tether_state.split('|').first
		if prefix.nil?
			prefix = ""
		end
	else
		if ARGV[1]
			prefix = ARGV[1]
		else
			puts "Prefix to filenames? (Optional - Hit enter to skip)"
			prefix = $stdin.gets.chomp	
		end
		if prefix.nil?
			prefix = ""
		end
		counter = "1"
		File.open($tether_set_info_file, 'w') { |file| file.write(prefix + '|1') }
	end

  cameras = GPhoto2::Camera.all

  if cameras.size > 0
  	togprint('line', "Camera     :: " + cameras.first.model)
  	togprint('line', "Port       :: " + cameras.first.port)
  	togprint('line', "Prefix     :: " + prefix )
  	if $use_camera_filename_or_counter == "counter"
  	togprint('line', "Counter at :: " + counter)
  	end
  	puts

  	if $unmount_before_tether == 'yes'
  		unmount_camera
  	end
		#system('gphoto2 --capture-tethered --hook-script=' + hook_path + ' | grep -v UNKNOWN')
		system('gphoto2 --capture-tethered --hook-script=' + hook_path )
		if $make_sound_on_disconnect == 'yes'
			disconnect_sound
		end
  else
  	togprint('warning', "Could not find camera")
  end

end