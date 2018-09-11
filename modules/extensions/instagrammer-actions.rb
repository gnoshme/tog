# INSTAGRAMMER EXTENTION ACTIONS

if $menu_select == 'ig'
  debug(1, "Starting IG Action")
  
  pics = choose_files( $current_set + $final_image_directory, ARGV[1])

  pics.each do |pic|  
    igify pic 
  end
end

if $menu_select == 'ighere'
  pics = choose_files( '.', ARGV[1])
  pics.each do |pic|
    igify(pic, dirslash($instagram_image_directory))
  end
end
