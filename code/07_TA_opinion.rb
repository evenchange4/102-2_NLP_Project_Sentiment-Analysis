load "load/func.rb"

training_data = load_training_data("../data/207884_hotel_training.txt")
opinion_dict = load_opinion_dict("../data/dict/opinion.dict.txt")

positive = []
negtive  = []

opinion_dict.each do |opinion|
	opinion_value = 0

	training_data.each_with_index do |comment, index|
		if comment.include?(opinion) 
			if index <= 1500
				opinion_value = opinion_value + 1
			else
				opinion_value = opinion_value - 1
			end 
		end
	end

	if opinion_value >= 0
		positive << opinion
	else
		negtive << opinion
	end
end

f = File.open("../data/dict/opinion2.dict.txt", "w")
positive.each do |t|
	f << "#{t} "
end
f << "\n"
negtive.each do |t|
	f << "#{t} "
end