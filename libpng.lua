project 'LibPNG'
	configuration '*Static'
		kind 'StaticLib'
	configuration 'not *Static'
		kind 'SharedLib'
	configuration '*'
	language 'C++'
	uuid '986024E0-1959-4A11-8E4F-0181018F612E'

	flags {
		--'Unicode'
	}
	
	configuration 'Release*'
		flags {
			'Optimize'
		}
	configuration '*'
	
	targetdir '../Build/%{cfg.platform}/%{cfg.shortname}'
	objdir '../BuildIntermediate/%{cfg.platform}/%{cfg.shortname}'
	
	files {
		-- public headers
		'png.h',
		'pngconf.h',
		'pnglibconf.h',
		-- private headers
		'pngdebug.h',
		'pnginfo.h',
		'pngpriv.h',
		'pngstruct.h',
		-- sources
		'png.c',
		'pngerror.c',
		'pngget.c',
		'pngmem.c',
		'pngpread.c',
		'pngread.c',
		'pngrio.c',
		'pngrtran.c',
		'pngrutil.c',
		'pngset.c',
		'pngtrans.c',
		'pngwio.c',
		'pngwrite.c',
		'pngwtran.c',
		'pngwutil.c',
	}
	
	configuration 'Debug*'
		defines {
			'_DEBUG',
			'PNG_DEBUG',
		}
		flags {
			"Symbols"
		}
	configuration 'not Debug*'
		defines {
			'NDEBUG'
		}
	configuration '*Static'
	configuration 'not *Static'
		defines {
			'PNG_BUILD_DLL'
		}
	configuration '*'
	
	defines {
	}
	
	includedirs {
		'.',
		'../zlib-1.2.8'
	}
	
	links {
		'ZLib',
	}
	
	if os.is('windows') then
		defines {
			'_CRT_SECURE_NO_WARNINGS'
		}
		
		links {
		}
		
		prebuildcommands {
			'copy "scripts\\pnglibconf.h.prebuilt" "pnglibconf.h" /Y'
		}
	end
	
	
	