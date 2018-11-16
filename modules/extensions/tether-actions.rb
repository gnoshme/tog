
if $menu_select == 'tether'
	hook_path = togpath('!tog/modules/extensions/tether-hookscript.rb')
	$preview_directory = dirslash($current_set + $tether_preview_image_directory)
	chkmk $preview_directory
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
			puts "Prefix to filenames?"
			prefix = $stdin.gets.chomp	
		end
		if prefix.nil? || prefix == ""
			puts "Prefix required"
			exit
		end
		counter = "1"
		File.open($tether_set_info_file, 'w') { |file| file.write(prefix + '|1') }
	end

  cameras = GPhoto2::Camera.all

  if cameras.size > 0
  	if $unmount_before_tether == 'yes'
  		unmount_camera
  	end
  	togprint('line', "Camera     :: " + cameras.first.model)
  	togprint('line', "Port       :: " + cameras.first.port)
  	togprint('line', "Prefix     :: " + prefix )
  	if $use_camera_filename_or_counter == "counter"
  	togprint('line', "Counter at :: " + counter)
  	end
  	puts
  	camera = cameras.first
  	if $warn_if_iso_more_than > 0 && camera['iso'].value.to_i > $warn_if_iso_more_than
  		togprint('error', 'ISO HIGH :: SET TO ' + camera['iso'].value.to_s)
  	end
  	if $warn_if_not_shooting_raw == 'yes' && ! camera['imagequality'].value.downcase.include?('raw')
  		togprint('error', 'NOT SHOOTING RAW')
  	end
  	if $warn_if_whitebalance_not_flash == 'yes' && ! camera['whitebalance'].value.downcase.include?('flash')
  		togprint('error', 'WHITE BALANCE IS ' + camera['whitebalance'].value.upcase )
  	end

  	loop do
	  	camera.close

			system('gphoto2 --capture-tethered --hook-script=' + hook_path )
			if $make_sound_on_disconnect == 'yes'
				disconnect_sound
				sleep 5
			end
		end
  else
  	togprint('warning', "Could not find camera")
  end

end