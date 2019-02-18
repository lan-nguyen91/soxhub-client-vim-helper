function! OpenShEmberFile(fileType)
	if !exists("g:sh_ember_split")
		let g:sh_ember_split="vertical"
	endif

	let fileName = expand('%:t')
	let fileExt = fnamemodify(fileName, ':e')
	let filePath = expand('%:p')

	if (filePath =~ "/controllers/")
		let filePath = substitute(filePath, "controllers", a:fileType, 1)
	elseif (filePath =~ "/routes/")
		let filePath = substitute(filePath, "routes", a:fileType, 1)
	elseif (filePath =~ "/templates/")
		let filePath = substitute(filePath, "templates", a:fileType, 1)
	endif
	
	if (a:fileType == "templates")
		let filePath = substitute(filePath, fileExt, "emblem", 1)
	endif

	if !filereadable(filePath)
		echo "Not found: " filePath
		return
	endif

	if (g:sh_ember_split == "horizontal")
		execute "split" filePath
	elseif (g:sh_ember_split == "vertical")
		execute "vsplit" filePath
	elseif (g:sh_ember_split == "tab")
		execute "tab" filePath
	endif
endfunction
