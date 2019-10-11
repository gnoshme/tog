
def exittests	message
	puts "=================================================================================="
	puts "TESTS FAILED"
	puts "=================================================================================="
	puts message
	exit
end

def test_install_notinstalledmods
	allmods["notinstalled"].each do |mod|
		system('tog install ' + mod)
		if ! is_installed(mod)
			exittests("tog install mod failed :: " + mod )
		end
	end
end

def test_exists type, location
	case type
	when "file"
		if ! File.exists?(location)
			exittests "MISSING FILE :: " + location
		end
	end
end

def test_notexists type, location
	case type
	when "file"
		if File.exists?(location)
			exittests "FILE SHOULD NOT BE HERE :: " + location
		end
	end
end
