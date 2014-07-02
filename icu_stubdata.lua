project 'ICUStubData'
	configuration '*Static'
		--kind 'StaticLib'
		kind 'SharedLib'
	configuration 'not *Static'
		kind 'SharedLib'
	configuration '*'
	language 'C++'
	uuid '0E19F904-DE99-4DB3-93E8-FCD54F0FDDFD'

	flags {
		--'Unicode'
	}
	
	configuration 'Release*'
		flags {
			'Optimize'
		}
	configuration '*'
	
	targetdir '../../Build/%{cfg.platform}/%{cfg.shortname}'
	objdir '../../BuildIntermediate/%{cfg.platform}/%{cfg.shortname}'
	
	files {
		-- public headers
		-- private headers
		-- sources
		'stubdata/stubdata.c',
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
			--'U_STATIC_IMPLEMENTATION'
		}
	configuration 'not *Static'
	configuration '*'
	
	defines {
		'STUBDATA_BUILD'
	}
	
	includedirs {
		'common',
	}
	
	if os.is('windows') then
		defines {
			'_CRT_SECURE_NO_DEPRECATE',
			'WIN32',
		}
		
		configuration 'x64'
			defines {
				'WIN64'
			}
		configuration '*'
	end
	
	