check_gem_installed('mini_magick')

if $export_and_resize == 'yes'
	require 'mini_magick'
end

$global_menu << 'export|EXPORT to maintained image repo'

if $try_and_group_set_by_changing_exif == 'yes'
	require 'mini_exiftool'
end
# REQUIRED METHODS
def exporter_help
  puts "bla bla bla"
end
def set_exif string, file
  blurt(2, "EXIF:: " + string + " || " + file )
  exif = MiniExiftool.new(file)
  exif.ModifyDate = string
  exif.DateTimeOriginal = string
  exif.CreateDate = string
  blurt(2, exif.to_hash)
  return exif.save
end

def doexport
	chkmk($export_to)
	dirs = []
	if $export_final_image_directory == 'yes'
		dirs << $final_image_directory
  end
  if $export_extra_directories.size > 0
  	$export_extra_directories.split(',').each do |dir|
  		dirs << dir.strip
  	end	
	end 
	allsets.sort.each do |set|
		if  set.to_s.include?($ignore_sets_where_name_includes)
			togprint('ul', set.upcase)
			puts "REJECTING rule: " + $ignore_sets_where_name_includes
			puts
		else
			puts
			exifdate = nil
			togprint('ul', set.upcase)
			dirs.each do |dir|
				destination_dir = dirslash(set) + dirslash(dir) 
				jpgs = Dir.glob(destination_dir +'*.jpg').sort
				if jpgs.count == 0
					#puts "No Images Found in " + destination_dir
				else
					jpgs.each do |jpg|
						if $try_and_group_set_by_changing_exif == 'yes'
							unless exifdate
								exif = MiniExiftool.new(jpg)
								exifdate =  exif.CreateDate
							end 
						end
						uname = set.split('/').last + '-' + dir.gsub('/','-') + '-' + jpg.split('/').last
						destination = (dirslash($export_to) + uname)
						if File.exist?(destination )
							puts "already have :: " + filename(jpg)
						else
							unless reject_for_filename(filename(jpg)) == true
								puts "new          :: " + filename(jpg)
								if $use_symbolic_links_instead_of_copy == 'yes'
									FileUtils.ln_s(jpg, destination)
								else
									if $export_and_resize == 'yes'
										image = MiniMagick::Image.open(jpg)
		    							image.resize $export_resize_size
		    							image.format "jpg"
		    							image.write destination
		    						else
										FileUtils.cp(jpg, destination)
								  	end
								end
							  
								if $try_and_group_set_by_changing_exif == 'yes'
									pic = MiniExiftool.new(jpg)
									pic.ModifyDate = exifdate
		  						pic.DateTimeOriginal = exifdate
		  						pic.CreateDate = exifdate
		  						pic.save
			  				end
							end
						end
					end
				end
			end
		end 
	end
end

def reject_for_filename filename
	$ignore_files_where_name_includes.split(',').each do |exception|

		if filename.include?(exception.strip)
			puts "rejecting    :: " + filename + ", rule: " + exception
			return true
		end
	end
end

# CHECK THE BASICS
chkmk $archives

# HELP ITEMS
$power_user_help["declutter"] ='Jumps into the declutter dialog'

# DATA ITEMS

