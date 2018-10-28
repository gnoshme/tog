check_gem_installed('mini_magick')

if $export_and_resize == 'yes'
	require 'mini_magick'
end

$global_menu << 'export|EXPORT to maintained image repo'

if $try_and_group_set_by_changing_exif == 'yes'
	require 'mini_exiftool'
end

def exporter_help
  togprint('p', "The exporter exports final images from all of your sets to a folder of your choice. This is really useful if you like to use a photo app to view all of your finished work.")
  togprint('p', "Exporter creates a unique and meaningful filename for every image, and doesn't create duplicates between current and archived sets. It also auto-resizes final images so your exported image repo is more manageable.")
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
				pics = Dir.glob(destination_dir +'*.jpg').sort
				if pics.count == 0
					#puts "No Images Found in " + destination_dir
				else
					pics.each do |pic|
						if $try_and_group_set_by_changing_exif == 'yes'
							unless exifdate
								exif = MiniExiftool.new(pic)
								exifdate =  exif.CreateDate
							end 
						end
						uname = set.split('/').last + '-' + dir.gsub('/','-') + '-' + pic.split('/').last
						destination = (dirslash($export_to) + uname)
						if File.exist?(destination )
							puts "already have :: " + filename(pic)
						else
							unless reject_for_filename(filename(pic)) == true
								puts "new          :: " + filename(pic)
								if $use_symbolic_links_instead_of_copy == 'yes'
									FileUtils.ln_s(pic, destination)
								else
									resized_available = false
									if $use_resizer_images_if_available == "yes"
										resized_pic = pic.gsub($final_image_directory, $resized_image_directory = 'resized')
										if File.exist?(resized_pic)
											puts "using resized :: " + filename(pic)
											FileUtils.cp(resized_pic, destination)
											resized_available = true
										end
									end
									unless resized_available
										if $export_and_resize == 'yes'
											puts "resizing     :: " + filename(pic)
											image = MiniMagick::Image.open(pic)
		    							image.resize $export_resize_size
		    							image.format "pic"
		    							image.write destination
		    						else
											FileUtils.cp(pic, destination)
								  	end
									end
								end
							  
								if $try_and_group_set_by_changing_exif == 'yes'
									pic = MiniExiftool.new(pic)
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

# HELP ITEMS

# DATA ITEMS

