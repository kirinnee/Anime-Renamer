describe "AnimeRenamer" do
	subject(:renamer) {AnimeRenamer::Renamer.new}
	describe 'rename' do
		it 'should extract two digit numbers and return `name + episode + number padded`' do
			expect(renamer.rename("Madoka_12_lol", "Madoka", 2)).to eq "Madoka Episode 12"
		end

		it "should extract two digit number and pad them" do
			expect(renamer.rename("Madoka_1_lol", "Madoka", 3)).to eq "Madoka Episode 001"
		end

		it 'should return original episode if no numbers are found' do
			expect(renamer.rename "Madoka OP ", "Madoka", 2).to eq "Madoka OP [1280x720]"
		end
	end

	describe "get_file_with_extension" do
		it 'should only return files with the correct extension' do
			expect(renamer.get_file_with_extension "./files/**/*.*", ".txt").to eq(%w(./files/a.txt ./files/b.txt ./files/c.txt))
		end
	end

end
