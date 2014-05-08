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



f1 = File.open("../data/regexp1.txt", "w")
f2 = File.open("../data/regexp2.txt", "w")
f3 = File.open("../data/regexp3.txt", "w")
f4 = File.open("../data/regexp4.txt", "w")

(1..3500).each do |i|
	next if i >= 1501 and i <= 2000
	puts ">> processing \t#{i}.txt document ..."
	File.open("../data/output1/#{i}.txt").each do |l|
		if regexp1.match(l)
			temp = regexp1.match(l)
			f1 << "#{i} #{temp["aspect"]} #{temp["ADV"]} #{temp["opinion"]}\n"
		elsif regexp2.match(l)
			temp = regexp2.match(l)
			f2 << "#{i} #{temp["aspect"]} #{temp["opinion"]}\n"
		end

		if regexp4.match(l)
			temp = regexp4.match(l)
			f3 << "#{i} #{temp["ADV"]} #{temp["opinion"]} #{temp["aspect"]}\n"
		elsif regexp3.match(l)
			temp = regexp3.match(l)
			f4 << "#{i} #{temp["opinion"]} #{temp["aspect"]}\n"
		end
	end
end
f1.close
f2.close
f3.close
f4.close