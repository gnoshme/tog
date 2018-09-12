check_gem_installed('mini_magick')

require 'mini_magick'

def instagrammer_help
  togprint('p', 'The Instagrammer extension allows you to easily (and even automatically) create IG friendly versions of your final images. ')
  togprint('p', 'The result is an image that has been intelligently stretched to a square using the images overall brightness and content to add the necessary border top or bottom.')
  togprint('p', "If you are using tog workflows, you can also have tog auto generate IG files when you do the last POST step in your workflow.")
  togprint('p', "Poweruser Bonus :: Run 'tog ighere' in ANY directory on your file system and tog will create IG versions of any images found there.")
end

$set_menu << "ig|Create Instagram (IG) Friendly Versions"
if $autocreate_instagram_when_moving_to_finals == 'yes'
	$post_final_tasks << 'igify'
end

def igify original, dir=dirslash($current_set + $instagram_image_directory)


	computed_size = $instagram_image_size.to_s + 'x' + $instagram_image_size.to_s
	computed_oversized = ($instagram_image_size * 1.3).to_s + 'x' + ($instagram_image_size * 1.3).to_s  + '!'
	computed_crop = computed_size + '+' + ($instagram_image_size * 0.15 ).to_i.to_s + '+' + ($instagram_image_size * 0.15 ).to_i.to_s

	if Dir.exists?(dir) == false  
		FileUtils.mkdir_p(dir)
	end

  destination = dir + $instagram_suffix + "#{original.split('/').last}"
  
  if File.exists?(destination) && $instagram_skip_if_exists == 'yes'
    puts "IG     :: Skipping (Exists) :: " + filename(original)
  else
    puts "IG     :: " + filename(original)

    image = MiniMagick::Image.open(original)    
    image.resize computed_size
    image.write "/tmp/foreground.jpg"
    testimage = MiniMagick::Image.open('/tmp/foreground.jpg')
    testimage.colorspace "Gray"
    brightness = testimage["%[mean]"]
    
    if brightness.to_i > 32768
      shade = "white"
    else
      shade = "black"
    end

    image.combine_options do |b|
      b.resize computed_oversized
      b.blur "0x60"
      b.fill shade
      b.colorize "40%"
      b.crop computed_crop

    end
    image.write "/tmp/background.jpg"

    first_image  = MiniMagick::Image.new("/tmp/background.jpg")
    second_image = MiniMagick::Image.new("/tmp/foreground.jpg")
    result = first_image.composite(second_image) do |c|
      c.compose "Over"    # OverCompositeOp
      c.gravity "center" # copy second_image onto first_image from (20, 20)
    end
    result.write destination
  end
end