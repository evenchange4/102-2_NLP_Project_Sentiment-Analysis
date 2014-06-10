def load_synonymy_dict(path)
	hash = Hash.new { |hash, key| hash[key] = [] }
	File.open(path).each do |l|
		terms = l.split(" ")
		terms.each do |t|
			hash[terms[0]] << t
		end
	end
	return hash
end

def load_opinion_dict(path)
	hash = {"P"=>[], "N"=>[]}
	File.open(path).each_with_index do |l, index|
		if index+1 == 1
			terms = l.split(" ")
			terms.each do |t|
				hash["P"] << t
			end
		else
			terms = l.split(" ")
			terms.each do |t|
				hash["N"] << t
			end			
		end
	end
	return hash
end

synonymy_dict = load_synonymy_dict("../data/dict/synonymy.dict.txt")
opinion2_dict = load_opinion_dict("../data/dict/opinion2.dict.txt")

fresult = File.open("../data/hotel_test_21.out", "w")

(1..1000).each do |i|
	comments = File.open("../data/output_test/#{i}.txt", "rb").readlines
	ckips = File.open("../data/output_test_CKIP/#{i}.txt", "rb").readlines.flatten.join.force_encoding("UTF-8")

	puts "Process #{i} doc..."
	fresult << "#{i} \n"
	aspect_result = {}

	comments.each do |comment|
		comment = comment.force_encoding("UTF-8")
		# puts ">> Processing #{comment}... "
		synonymy_dict.each do |aspect, synonymys|
			value = 0

			synonymys.each do |synonymy|
				next if !ckips.include?("#{synonymy}(N)")

				opinion2_dict["P"].each do |opinion|
					value += 1 if /#{synonymy}(.*)#{opinion}/.match(comment)
					value += 1 if /#{opinion}(.*)#{synonymy}/.match(comment)
				end
				opinion2_dict["N"].each do |opinion|
					# puts "#{synonymy}(.*)#{opinion}" if /#{opinion}(.*)#{synonymy}/.match(comment)
					value -=1 if /#{synonymy}(.*)#{opinion}/.match(comment)
					value -=1 if /#{opinion}(.*)#{synonymy}/.match(comment)
				end				
			end

			if aspect_result.include?(aspect)
				aspect_result[aspect] += value
			else
				aspect_result[aspect] = value
			end
		end
	end
	# p aspect_result
	# # output result
	po = aspect_result.select{|h,v| v > 0 }
	ne = aspect_result.select{|h,v| v < 0 }
	
	p po
	p ne

	po.keys.each do |t|
		fresult << "#{t}\t"
	end
	fresult << "\n"
	
	ne.keys.each do |t|
		fresult << "#{t}\t"
	end
	fresult << "\n"		

	if po.size >= ne.size
		fresult << "1\n"
	else
		fresult << "2\n"
	end
	fresult.flush
end
fresult.close