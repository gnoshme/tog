# INSTAGRAMMER EXTENTION ACTIONS

if $menu_select == 'ig'
  debug(1, "Starting IG Action")
  
  jpgs = choose_files( $current_set + $final_image_directory, ARGV[1])

  jpgs.each do |jpg|  
    igify jpg 
  end
end

if $menu_select == 'ighere'
  jpgs = choose_files( '.', ARGV[1])
  jpgs.each do |jpg|
    igify(jpg, dirslash($instagram_image_directory))
  end
end
