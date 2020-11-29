def convertit_tous_fichiers
	puts "Start convertion"
	# 1 - selection un repertoire
	chosen_folder = selectionne_repertoire
	puts "chosen_folder: #{chosen_folder}"
	return if chosen_folder.nil? 
	# 2 - recuperre tous les fichiers du repertoire
	all_files = recupere_les_fichiers(chosen_folder)
	puts all_files.inspect
	# 3 mour chaque fichiers du répertoire l'enregistrée en version précédant
	all_files.each{|file|
		enregistre_un_fichier(file)
	}
end


def selectionne_repertoire
	UI.select_directory(
	  title: "Select Dketchup Directory"
	)
end

def recupere_les_fichiers(chosen_folder)
	Dir.glob("#{chosen_folder}/**/*.skp")
end

def enregistre_un_fichier(file)
	Sketchup.open_file(file, with_status: false)
	model = Sketchup.active_model
	view = Sketchup.active_model.active_view
	new_view = view.zoom_extents
	model.save(file, Sketchup::Model::VERSION_2017)
end