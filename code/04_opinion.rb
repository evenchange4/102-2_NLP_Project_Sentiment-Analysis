opinion = Hash.new {|h,k| h[k] = {"P" => 0, "N" => 0 } }
viewed = false
(1..1500).each do |i|
	File.open("../data/output1/#{i}.txt").each do |l|
		l.split(/[[:space:]]/).each do |t|
			if /(ADV)/.match(t)
				term = t.split("(")[0]
				# TF
				if opinion.has_key?(term)
					opinion[term]["P"]  = opinion[term]["P"] + 1
				else
					opinion[term]["P"] = 1
				end
			end
		end
	end
end

(2001..3500).each do |i|
	File.open("../data/output1/#{i}.txt").each do |l|
		l.split(/[[:space:]]/).each do |t|
			if /(ADV)/.match(t)
				term = t.split("(")[0]
				# TF
				if opinion.has_key?(term)
					opinion[term]["N"] = opinion[term]["N"] + 1
				else
					opinion[term]["N"] = 1
				end
			end
		end
	end
end
opinion = opinion.sort_by {|k, v| v["P"] + v["N"]}.reverse

f = File.open("../data/opinion_ADV.txt","w")
opinion.each do |k,v|
	f << "#{k} #{v["P"]} #{v["N"]}\n"
end
f.close
