firstline = true
f = File.open("../data/label.txt", "w")
label = 0
File.open("../data/207884_hotel_training.txt", "rb").each do |l|
	if firstline
		# temp = l.split("\n")
		label = l[0]

		# p text.encoding.name 
		firstline = false
	else
		temp2 = l.split("|")
		doc_id = temp2[0]
		f << "#{doc_id} #{label}\n"

		firstline = true
	end
end
f.close
