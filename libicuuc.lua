project 'libicuuc'
	configuration '*Static'
		kind 'StaticLib'
	configuration 'not *Static'
		kind 'SharedLib'
	configuration '*'
	language 'C++'
	uuid 'F11F305B-7761-4836-9F59-DF0700C38218'

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
		'common/*.h',
		'common/unicode/*.h',
		-- sources
		'common/*.c',
		'common/*.cpp',
	}
	
	configuration 'Debug*'
		defines {
			'_DEBUG',
			'RBBI_DEBUG'
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
		'U_COMMON_IMPLEMENTATION',
		'U_DISABLE_RENAMING'
	}
	
	includedirs {
	}

	if os.is('windows') then
		defines {
			'_CRT_SECURE_NO_DEPRECATE',
			'WIN32',
		}
		
		prebuildcommands {
			'md "..\\include"',
			'copy "common\\unicode\\*.h" "..\\include\\" /Y'
		}
		
		configuration 'x64'
			defines {
				'WIN64'
			}
		configuration '*'
	end
	
	