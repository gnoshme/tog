check_gem_installed('etc')

require 'etc'
#require 'uri'
#require 'libusb'

# REQUIRED METHODS
def importer_help
  puts "bla bla bla"
end

$set_menu << "import|IMPORT from Camera or SD Card"

def userify string
	user = Etc.getlogin
	return string.gsub('!user', user).gsub('!uid', Etc.getpwnam(user).uid.to_s)
end

def identify_camerazx string
	usbs = exec("lsusb").split("\n")
	clean = URI.unescape(string)
	puts clean
	stringusb = clean.split('[usb:').last.split(']').first
	puts stringusb
	usbsearch = 'Bus ' + stringusb.split(',').first.rjust(3,'0') + ' Device ' + stringusb.split(',').last.rjust(3,'0')
	puts usbsearch
	usbs.each do |usb|
		if usb.include?(usbsearch.to_s)
			puts "asfd:"
			puts usb
		end
	end	

end

def identify_camera string
	xyz = LIBUSB::Context.new
	puts xyz
	puts usb.devices.first
end

def doimport

	menu_array = []
	media_root = userify($default_media_directory)
	medias = Dir.glob(media_root)
	medias.each do |media|
		menu_array << 'Media :: ' +media
	end
     
	camera_root = userify($default_camera_directory)
	cameras = Dir.glob(camera_root)
	cameras.each do |camera|		
		menu_array << 'Cameras :: ' + camera
	end

	choice = (menu_from_array menu_array)
	dir = menu_array[choice.to_i].split(':: ').last
	files = Dir.glob(dirslash(dir) + '**/*').reject {|fn| File.directory?(fn) }
	match_string = $file_types_to_import.upcase
	matches = []
	files.each do |file|
		if File.extname(file)  &&  match_string.include?(File.extname(file).upcase)
			matches << file
			puts "Found :: " + file
		end
	end
	if matches.count > 0
		togprint('h2', 'Ready to Import' )
		togprint('line', 'Matches     :: ' + matches.count.to_s)
		togprint('line', 'Destination :: ' + $current_set + 'raws/')
		togprint('line', 'Import mode :: ' + $copy_or_move_files.upcase)
		are_you_sure 
		clear_screen
		matches.each do |file|
			togprint('line', 'DOING :: ' + $copy_or_move_files.upcase + '  :: ' + filename(file))
			destination = $current_set + 'raws/' + filename(file) 
			if File.exists?(destination)
				togprint('line', "ALREADY EXISTS :: " + filename(file))
			else
				if $copy_or_move_files == 'move'
					FileUtils.mv(file, destination)
				else
					FileUtils.cp(file, destination)
				end
			end
		end
	else
	 	togprint('h2', 'No files found')
	end

end