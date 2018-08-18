def save_current_set path, display="no"
  File.open($current_set_file, 'w') { |file| file.write(dirslash(path)) }
  $current_set = path
  ln_current_set
  if display == "yes"
    banner_current_set
  end
end

def check_set
  if Dir.exists?($current_set + dirslash($final_image_directory)) == false
    banner_current_set
    togprint('error', "Final Images Directory is Missing")
    togprint('line', "If this is an older set created before TOG but you want to use")
    togprint('line', "features, you're going to need the final images directory" )
    puts
    array = ["Create Final Image Directory (will make this error go away)", "Create all the TOG directories", "Leave this directory", "Exit"]
    menu_choice = menu_from_array array
    case menu_choice + 1
      when 1
        Dir.mkdir($current_set + dirslash($final_image_directory))
      when 2
        create_set_dirs $current_set
      when 3
        clear_current_set
        exit
      when 4
        exit
    end
    cont
  end
end

def create_set_dirs dir_path
    chkmk(dir_path)    
    chkmk( dir_path + $raw_file_directory)
    chkmk( dir_path + $final_image_directory )
    create_workflow_dirs(dir_path, workflow_dir_count)
    $other_shoot_directories.split(',').each do |dir|
      chkmk( dir_path + dir.strip )
    end

end

def create_workflow_dirs dir_path, workflow_dir_count
  workflow_dir_count.times  do |counter|
    dirname = '$workflow' + (counter + 1).to_s + '_directory'
    dir = dir_path + eval(dirname)
    chkmk(dir)
  end
end

def clear_current_set
  FileUtils.rm($current_set_file)
  $current_set = nil
  ln_remove
end

def load_current_set display="no"
  if File.exists?($current_set_file)
    current_set =  File.read($current_set_file)
    if ! Dir.exists?(current_set)
      return false
    else
      $current_set = current_set
      if display == "yes"
        banner_current_set
      end
      check_set
      return current_set
    end
   end
end

def banner_current_set
  if $current_set.nil?
    togprint('h1', 'CURRENT SET :: None')
  else
    togprint('h1', 'CURRENT SET :: ' + $current_set)
  end
end

def allsets
  dirs = []
  $set_roots.each do |root|
    Dir.chdir(root.split('|').first)
    dirs = dirs + Dir.glob(root.split('|').last).map(&File.method(:realpath)).select {|f| File.directory? f}
  end
  return dirs
end