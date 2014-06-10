converter = Encoding::Converter.new('UTF-8', 'UTF-16LE')

firstline = true
File.open("../data/207884_hotel_training.txt", "rb").each do |l|
	# l = l.force_encoding('ASCII-8BIT')
	# p l.encoding.name 
	if firstline
		# p l 
		firstline = false
	else
		temp = l.split("|")
		doc_id = temp[0]
		text = temp[1]

		# "\xFF\xFE".force_encoding('UTF-16LE') + converter.convert(@export_s)
		bom = "\uFEFF"
		f = File.open("../data/output1/#{doc_id}.txt", "w:UTF-16LE")
		f << "#{bom.force_encoding('UTF-16LE')}#{text.force_encoding('UTF-16LE')}"
		# f << "#{bom.force_encoding('UTF-16LE')}#{converter.convert(text)}"

		
		# p text.encoding.name 
		f.close
		firstline = true
		break
	end
end