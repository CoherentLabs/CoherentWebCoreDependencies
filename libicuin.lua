project 'libicuin'
	configuration '*Static'
		kind 'StaticLib'
	configuration 'not *Static'
		kind 'SharedLib'
	configuration '*'
	language 'C++'
	uuid '2B2D0C5A-A65C-475B-B694-D277CF08FD4A'

	flags {
		'Symbols'
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
		'i18n/*.h',
		'i18n/unicode/*.h',
		-- sources
		'i18n/*.c',
		'i18n/*.cpp',
	}
	
	configuration 'Debug*'
		defines {
			'_DEBUG',
		}
	configuration 'not Debug*'
		defines {
			'NDEBUG'
		}
	configuration '*Static'
		defines {
			'U_STATIC_IMPLEMENTATION'
		}
	configuration 'not *Static'
	configuration '*'
	
	defines {
		'U_ATTRIBUTE_DEPRECATED=',
		'U_I18N_IMPLEMENTATION',
		'U_DISABLE_RENAMING'
	}
	
	includedirs {
		'../include',
		'common',
	}
	
	links {
		'libicuuc'
	}
	
	if os.is('windows') then
		defines {
			'_CRT_SECURE_NO_DEPRECATE',
			'WIN32',
		}
		
		prebuildcommands {
			'md "..\\include"',
			'copy "i18n\\unicode\\*.h" "..\\include\\" /Y'
		}
		
		configuration 'x64'
			defines {
				'WIN64'
			}
		configuration '*'
	end
	
	