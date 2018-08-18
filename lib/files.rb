# Make any path absolute
def togpath path 
  return path.gsub('!tog',$togpath)
end

def dirslash path
  if path[-1] != '/'
    path = path + '/'
  end
  return path
end

def choose_files dir, filter="all"
  if filter.nil?
    filter = 'all'
  end
  jpgs = Dir.glob(dirslash(dir) + '*.jpg')
  matching = []
  if filter == 'all' 
    matching = jpgs
  else
    if filter
      jpgs.each do |jpg|
        if jpg.include?(filter)
          matching << jpg
        end
      end
    end
  end
  return matching
end

def pathify relpath, mod, postfix=''
  return togpath('!tog/' + relpath + mod + postfix + '.rb') 
end

def full_path relpath
  if $current_set
    return $current_set + relpath
  end    
end

def final_files
  return Dir.glob($current_set + dirslash($final_image_directory) + '/*.jpg')
end

def chkmk dir
  unless Dir.exists?(dir)
    togprint('line', 'CREATING :: ' + dir)
    FileUtils.mkdir_p(dir)
  end
end

def sanitize_filename(filename)
  # Split the name when finding a period which is preceded by some
  # character, and is followed by some character other than a period,
  # if there is no following period that is followed by something
  # other than a period (yeah, confusing, I know)
  fn = filename.split /(?<=.)\.(?=[^.])(?!.*\.[^.])/m

  # We now have one or two parts (depending on whether we could find
  # a suitable period). For each of these parts, replace any unwanted
  # sequence of characters with an underscore
  fn.map! { |s| s.gsub /[^a-z0-9\-]+/i, '_' }
  # Finally, join the parts with a period and return the res ult
  return fn.join '.'
end

def filename full_path
  return full_path.split('/').last
end

def ln_current_set
  ln_remove
  FileUtils.ln_s $current_set, $quicklink
end

# Remove symbolic link
def ln_remove
  if File.symlink?($quicklink)
    FileUtils.rm $quicklink
  end
end