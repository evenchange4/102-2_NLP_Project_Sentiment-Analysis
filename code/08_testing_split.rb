File.open("../data/211047_hotel_test.txt", "rb").each_with_index do |l, index|
	temp = l.split("|")

	f = File.open("../data/output_test/#{index+1}.txt", "w")
	doc_id = temp[0]
	text = temp[1].force_encoding('UTF-8')
	text_array = text.split(/[，,。.!！\n]/)

	text_array.each do |p|
		if p == "\n" or p ==" " or p ==""
		else
			f << "#{p}\n"
		end 
	end
	f.close
end

# require 'socket'
# require 'builder'
# require 'Nokogiri'

# host = '140.109.19.104'     # The web server
# port = 1501                           # Default HTTP port
# config = {'username'=>"b98705000", "password"=>"b98705000"}
# @socket = TCPSocket.open( host , port)

# File.open("../data/211047_hotel_test.txt", "rb").each do |l|
# 	temp = l.split("|")
# 	doc_id = temp[0]
# 	text = temp[1]
# 	text = text.force_encoding('UTF-8')
# 	p ">> segment \t #{doc_id}\n"
# 	request = "<?xml version=\"1.0\" ?><wordsegmentation version=\"0.1\" charsetcode=\"UTF-8\"><option showcategory=\"1\" /><authentication username=\"#{config['username']}\" password=\"#{config['password']}\" /><text>#{text}</text></wordsegmentation>"

# 	@socket.write( request )
# 	@doc = Nokogiri::XML(@socket.gets)
# 	reault = @doc.css("sentence")
# 	f = File.open("../data/output_test/#{doc_id}.txt", "w")
# 	reault.each {|r| f << "#{r.text}\n"}
# 	f.close

# end