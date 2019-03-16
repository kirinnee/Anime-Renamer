require "anime_renamer/version"

module AnimeRenamer

	class Renamer

		def run(args)
			name = args[0]
			ext = args[1] || ".mkv"
			dir = args[2] || "./**/*.*"
			digits = args[3] || 2
			get_file_with_extension(dir, ext).map {|x| [x, rename(x, name, digits)]}.each do |file|
				p file[0]
				p file[1]
				change_name file[0], file[1]
			end
		end

		def get_file_with_extension(dir, ext)

			Dir.glob(dir).select {|file| File.extname(file) == ext}
		end

		def change_name(file, new_name)
			ext = File.extname file
			File.rename(file, "#{new_name}#{ext}")
		end

		def rename(original, name, digits = 2)
			ext = File.extname original
			basename = File.basename original, ext
			basename.gsub! /\[[^\]]*\]/, ""
			basename.gsub! /\([^)]*\)/, ""
			basename.strip!
			episode, _ = basename.match(/\A.*[^\.0-9]([0-9]{1,#{digits}})[^\.0-9].*\z/i)&.captures
			episode_end, _ = basename.match(/\A.*[^\.0-9]([0-9]{1,#{digits}})\z/i)&.captures
			point5, _ = basename.match(/\A.*[^0-9]([0-9]{1,#{digits}}\.5)[^0-9].*\z/i)&.captures
			point5_end, _ = basename.match(/\A.*[^0-9]([0-9]{1,#{digits}}\.5)\z/i)&.captures
			final_name = episode || episode_end || point5 || point5_end
			return p basename if (final_name).nil?
			p "#{name} Episode #{(final_name).to_s.rjust(digits, "0")}"
		end
	end
end
