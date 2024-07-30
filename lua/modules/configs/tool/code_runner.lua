return function()
	require("code_runner").setup({
		mode = "term",
		focus = false,
		term = {
			--  Position to open the terminal, this option is ignored if mode ~= term
			position = "vert", -- bot by default
			-- window size, this option is ignored if mode == tab
			size = 60,
		},
		-- Execute before executing a file
		before_run_filetype = function()
			vim.cmd(":w")
		end,
		filetype = {
			c = {
				"cd $dir &&",
				"clang $fileName",
				"-o $fileNameWithoutExt &&",
				"$dir/$fileNameWithoutExt",
			},
			cpp = {
				"cd $dir &&",
				"clang++ $fileName",
				"-o $fileNameWithoutExt",
                "-std=c++11", -- with c++11 
                "&&",
				"./$fileNameWithoutExt",
			},
			python = "python -u", --TODO: virtual env
			rust = {
				"cd $dir &&",
				"rustc $fileName &&",
				"$dir/$fileNameWithoutExt",
			},
			java = { "cd $dir &&", "javac $fileName &&", "java $fileNameWithoutExt" },
			go = "go run $filename",
		},
	})
end
