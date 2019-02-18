function! OpenShEmberFile(fileType)
	if !exists("g:sh_ember_split")
		let g:sh_ember_split="vertical"
	endif

	let fileName = expand('%:t')
	let fileExt = fnamemodify(fileName, ':e')
	let filePath = expand('%:p')
	let isComponent = (filePath =~ "/components/")

	echo a:fileType

	if (isComponent && (a:fileType != "templates" && a:fileType != "components"))
		echo "Doesn't work on component"
		echo "You try to open" a:fileType
		return
	endif

	if ( isComponent )
		if (a:fileType == "templates")
			let filePath = substitute(filePath, "components", "templates/components", 1)
		endif
		if (a:fileType == "components")
			let filePath = substitute(filePath, "templates/components", "components", 1)
			let filePath = substitute(filePath, ".emblem", ".js", 1)
		endif
	endif

	if (filePath =~ "/controllers/")
		let filePath = substitute(filePath, "controllers", a:fileType, 1)
	elseif (filePath =~ "/routes/")
		let filePath = substitute(filePath, "routes", a:fileType, 1)
	elseif (filePath =~ "/templates/")
		let filePath = substitute(filePath, "templates", a:fileType, 1)
		let filePath = substitute(filePath, ".emblem", ".js", 1)
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
		execute "tabedit" filePath
	endif
endfunction
