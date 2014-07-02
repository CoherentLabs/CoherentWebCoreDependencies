project 'LibICONV'
	configuration '*Static'
		kind 'StaticLib'
	configuration 'not *Static'
		kind 'SharedLib'
	configuration '*'
	language 'C++'
	uuid '3C74EBD3-4925-4642-A47C-9762298C2D6B'

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
		-- private headers
		'lib/relocatable.h',
		-- sources
		'lib/iconv.c',
		'lib/relocatable.c',
		'libcharset/lib/localcharset.c',
	}
	
	configuration 'Debug*'
		defines {
			'_DEBUG',
		}
		flags {
			"Symbols"
		}
	configuration 'not Debug*'
		defines {
			'NDEBUG'
		}
	configuration '*Static'
		defines {
			'COHERENT_STATIC_LIBICONV'
		}
	configuration 'not *Static'
		defines {
			--'LIBICONV_PLUG' -- TODO: define this instead of the above?
		}
	configuration '*'
	
	defines {
		'BUILDING_LIBICONV',
		'BUILDING_LIBCHARSET',
		'HAVE_WCHAR_T=1'
	}
	
	includedirs {
		'.',
		'include',
	}
	
	if os.is('windows') then
		defines {
			'_CRT_SECURE_NO_WARNINGS',
			'LIBDIR=1', -- avoid inclusion of configmake.h file in localcharset.c
			'ICONV_CONST=const',
		}
		
		prebuildcommands {
			'copy "..\\CoherentThirdPartyFiles\\iconv_win32.h" "include\\iconv.h" /Y',
			'copy "..\\CoherentThirdPartyFiles\\localcharset_win32.h" "include\\localcharset.h" /Y',
			'copy "..\\CoherentThirdPartyFiles\\config_win32.h" "include\\config.h" /Y',
		}
	end
	
	
	