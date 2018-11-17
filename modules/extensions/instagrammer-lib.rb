check_gem_installed('mini_magick')
check_gem_installed('vmstat')

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

def igprocess pics, threads

  dir=dirslash($current_set + $instagram_image_directory)
  $threads = []
  thread_count = 0
  pics.sort.each do |original|
    thread_count = thread_count + 1
    $threads << Thread.new { 
      igify original
    }
    if thread_count >= $instagram_threads
        sleep 0.1
        puts ".. waiting for free threads.."
        $threads.each { |thr| thr.join }
        thread_count = 0
    end
  end
  sleep 0.1
  puts ".. finishing last threads"
  $threads.each { |thr| thr.join }
end


def igify original, dir=dirslash($current_set + $instagram_image_directory), threads=$instagram_threads
  unless $dir_checked == true && Dir.exists?(dir) == true  
    FileUtils.mkdir_p(dir)
  end
  $dir_checked = true
  destination = dir + $instagram_suffix + "#{original.split('/').last}"
  
  if File.exists?(destination) && $instagram_skip_if_exists == 'yes'
    puts "IG     :: Skipping (Exists) :: " + filename(original)
  else
    igactual original, destination
  end
end


def igactual original, destination
  puts "Making     :: " + filename(original)

  computed_size = $instagram_image_size.to_s + 'x' + $instagram_image_size.to_s
  computed_oversized = ($instagram_image_size * 1.3).to_s + 'x' + ($instagram_image_size * 1.3).to_s  + '!'
  computed_crop = computed_size + '+' + ($instagram_image_size * 0.15 ).to_i.to_s + '+' + ($instagram_image_size * 0.15 ).to_i.to_s


  image = MiniMagick::Image.open(original)    
  image.resize computed_size
  tmpforeground = "/tmp/togig-foreground-" + filename(original)
  image.write tmpforeground
  testimage = MiniMagick::Image.open(tmpforeground)
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
  tmpbackground = "/tmp/togig-background-" + filename(original)

  image.write tmpbackground

  first_image  = MiniMagick::Image.new(tmpbackground)
  second_image = MiniMagick::Image.new(tmpforeground)
  result = first_image.composite(second_image) do |c|
    c.compose "Over"    # OverCompositeOp
    c.gravity "center" # copy second_image onto first_image from (20, 20)
  end
  File.delete(tmpforeground)
  File.delete(tmpbackground)
  result.write destination
end
