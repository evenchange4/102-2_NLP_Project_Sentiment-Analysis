# regexp1 = (N)(.)*(ADV)(Vi)
regexp1 = /([[:space:]]*.*[[:space:]]+)(?<aspect>(\p{Han}+))\(N\)([[:space:]]*.*[[:space:]]+)(?<ADV>(\p{Han}+))\(ADV\)[[:space:]](?<opinion>(\p{Han}+))\(Vi\)/
# regexp2 = (N)(.)*(Vi)
regexp2 = /([[:space:]]*.*[[:space:]]+)(?<aspect>(\p{Han}+))\(N\)([[:space:]]*.*[[:space:]]+)(?<opinion>(\p{Han}+))\(Vi\)/
# regexp2 = (N)(.)*(ADV)(Vt)
# regexp2 = /([[:space:]]*.*[[:space:]]+)(?<aspect>(\p{Han}+))\(N\)([[:space:]]*.*[[:space:]]+)(?<ADV>(\p{Han}+))\(ADV\)[[:space:]](?<opinion>(\p{Han}+))\(Vt\)/
# regexp3 = (Vi)(.)*(N)
regexp3 = /([[:space:]]*)(.*)([[:space:]]+)(?<opinion>(\p{Han}*))\(Vi\)([[:space:]]*)(.*)([[:space:]]+)(?<aspect>(\p{Han}*))\(N\)/
# regexp4 = (ADV)(Vi)(.)*(N)
regexp4 = /([[:space:]]*)(.*)([[:space:]]+)(?<ADV>(\p{Han}+))\(ADV\)[[:space:]](?<opinion>(\p{Han}*))\(Vi\)([[:space:]]*)(.*)([[:space:]]+)(?<aspect>(\p{Han}*))\(N\)/



f5 = File.open("../data/regexp5.txt", "w")

# dic = []
# File.open("../data/neg_dic.txt", "rb").each do |t|
# 	dic << t
# end
dic = ["不","沒", "未", "別", "非", "休", "莫", "甭", "無"]

(1..3500).each do |i|
	next if i >= 1501 and i <= 2000
	puts ">> processing \t#{i}.txt document ..."
	File.open("../data/output1/#{i}.txt").each do |l|
		if regexp1.match(l)
			temp = regexp1.match(l)
			flag = false
			dic.each do |t|
				# p "ADV: #{temp["ADV"].encoding}"
				# p "t: #{t.encoding}"
				# test = temp["ADV"].force_encoding("UTF-8")
				if temp["ADV"].include?(t)
					p "#{temp["ADV"]}#{temp["opinion"]}"
					f5 << "#{temp["aspect"]} #{temp["ADV"]}#{temp["opinion"]}\n"
					flag = true
					break
				end
			end
			if !flag
				f5 << "#{temp["aspect"]} #{temp["opinion"]}\n"
			end
		elsif regexp2.match(l)
			temp = regexp2.match(l)
			f5 << "#{temp["aspect"]} #{temp["opinion"]}\n"
		end

		if regexp4.match(l)
			temp = regexp4.match(l)
			flag = false
			dic.each do |t|
				# test = temp["ADV"].force_encoding("UTF-8")
				if temp["ADV"].include?(t)
					f5 << "#{temp["aspect"]} #{temp["ADV"]}#{temp["opinion"]} \n"
					flag = true
					break
				end
			end
			if !flag
				f5 << "#{temp["aspect"]} #{temp["opinion"]} \n"
			end
		elsif regexp3.match(l)
			temp = regexp3.match(l)
			f5 << "#{temp["aspect"]} #{temp["opinion"]} \n"
		end
	end
end
f5.close