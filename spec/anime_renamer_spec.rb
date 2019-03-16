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
			expect(renamer.rename "Madoka OP [1280x720]", "Madoka", 2).to eq "Madoka OP"
		end

		it 'should not remove whole block if it starts and end with []' do
			expect(renamer.rename "[HorribleSubs] Zombieland Sage 1 [Helvetica]", "ZL", 2).to eq "ZL Episode 01"
		end

		it 'should remove all [] anyways' do
			expect(renamer.rename "[HorribleSubs] OP [1280x720]", "ZL", 2).to eq "OP"
		end

		it 'should not remove whole block if it starts and end iwth ()' do
			expect(renamer.rename "(HorribleSubs) Zombieland Sage 1 (Helvetica)", "ZL", 2).to eq "ZL Episode 01"
		end
		it 'should remove all () anyways' do
			expect(renamer.rename "(HorribleSubs) OP (1280x720)", "ZL", 2).to eq "OP"
		end

	end

	describe "get_file_with_extension" do
		it 'should only return files with the correct extension' do
			expect(renamer.get_file_with_extension "./files/**/*.*", ".txt").to eq(%w(./files/a.txt ./files/b.txt ./files/c.txt))
		end
	end

end
