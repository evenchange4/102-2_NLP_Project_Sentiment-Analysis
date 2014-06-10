def load_opinion_dict(path)
	array = []
	File.open(path).each do |l|
		t = l.split("\n")[0]
		array << t
	end
	return array
end
def load_training_data(path)
	firstline = true
	array = []
	File.open(path).each do |l|
		if firstline
			firstline = false
		else
			t = l.split("\n")[0]
			array << t

			firstline = true
		end
	end
	return array
end