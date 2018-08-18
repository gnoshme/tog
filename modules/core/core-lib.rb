
# REQUIRED METHODS
def core_help
  puts "this is the install core info"
end


def move_jpgs_to_next favor=nil
  if ARGV[0]
    step = ARGV[0].gsub('post','')
  else
    if $menu_select
      step = $menu_select.gsub('post','')
    else
      puts 'Something went wrong'
      exit
    end
  end
  source = full_workflow_path(step)

  if step == workflow_dir_count.to_s
    destination = dirslash(full_path($final_image_directory))
    final_images = true
  else
    destination = dirslash(full_workflow_path(step.to_i + 1))
    final_images = false
  end
  jpgs = Dir.glob(source + '/*.jpg')
  if jpgs.size == 0
    togprint('h2', "There are no files to process / move.")
  else
    if favor
      favor = favor.split(':').last.to_s
      masters = []
      discards = []
      jpgs.each do |jpg|
        if jpg.include?(favor)
          masters << jpg
          discard = jpg.gsub(favor,'')
          discards << discard
        end
      end
      puts "masters"
      puts masters
      puts "discards"
      puts discards
      puts "all"
      puts jpgs

    end
    jpgs.each do |jpg|
      if masters.include?(jpg)
          puts "Accepting Newer Version of   :: " + filename(jpg)
          FileUtils.mv(jpg, destination)
      else 
        if discards.include?(jpg)
          puts "Rejecting  older version of  :: " + filename(jpg)
          #OOPS - NEED DISCARD DIRECTORY
          FileUtils.mv(jpg, $current_set + 'discards/')
        else
          puts 'Moving only version of       :: ' + filename(jpg)
          FileUtils.mv(jpg, destination)
        end
      end
    end
    puts jpgs
    if final_images == true
      togprint('h2', 'Performing Auto-Final tasks')
      (jpgs - discards).each do |jpg|
        $post_final_tasks.each do |task|
          command = task + '("' + destination + jpg.split('/').last + '")'
          #eval(command)
          puts command
        end
      end
   end
  end
end


def createset_action dir_path
	dir_path = dir_path + '/'
  if Dir.exists?(dir_path)
  	togprint('error', "That directory already exists")
  else
    create_set_dirs dir_path
  end
end


def workflow_dir_count
  if $workflow5_directory != ''
    return 5
  else
    if $workflow4_directory != ''
       return 4
    else
      if $workflow3_directory != ''
        return 3
      else
        if $workflow2_directory != ''
          return 2
        else
          if $workflow1_directory != ''
            return 1
          else
            return 0
          end
        end
      end
    end
  end
end



def full_workflow_path step
	 dir = '$workflow' + step.to_s + '_directory'
	 actual = eval(dir)
	 return full_path(actual)
end
# CHECK THE BASICS
chkmk $shoots


# MENU ITEMS
workflow_dir_count.times do |counter|
  real_count = counter + 1
	$set_menu << "post" + real_count.to_s + '|Post Workflow Step ' + real_count.to_s + ' tasks. - POST' + real_count.to_s
end

$global_menu << "new|Create a NEW set"
$global_menu << "find|FIND a set"
$global_menu << "switch|SWITCH to another set in shoots"

# HELP ITEMS
$power_user_help["new"] ='Launches the creating a new set dialog'
$power_user_help["new [SHOOT_CODE]"] ='Creates a new set using SHOOT_CODE in the directory name'
$power_user_help["post1, post2, post3 etc.."] = 'Do workflow cleanup steps for a specific workflow step'
# DATA ITEMS
$set_roots << $shoots + '|*'

