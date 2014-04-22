project 'LibSSH'
	configuration '*Static'
		kind 'StaticLib'
	configuration 'not *Static'
		kind 'SharedLib'
	configuration '*'
	language 'C++'
	uuid '239CA832-A00B-4E2A-9603-B53C7C9E9339'

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
		'include/*.h',
		-- private headers
		'src/*.h',
		-- sources
		'src/*.c'
	}
	
	configuration 'Debug*'
		defines {
			'_DEBUG',
			'LIBSSH2DEBUG'
		}
	configuration 'not Debug*'
		defines {
			'NDEBUG'
		}
	configuration '*'
	
	defines {
		'_LIB', -- this is defined for the DLL build, too (?)
		'LIBSSH2_HAVE_ZLIB'
	}
	
	includedirs {
		'include',
		'../zlib-1.2.8',
		'../openssl-1.0.1g/inc32',
	}
	
	links {
		'ZLib'
	}
	
	if os.is('windows') then
		defines {
			'LIBSSH2_WIN32',
		}
		
		includedirs {
			'win32'
		}
		
		links {
			'ws2_32',
		}
		
		configuration 'not *Static'
			links {
				'OpenSSL_Crypto', -- libeay32
				'ZLib'
			}
		configuration '*'
	end
	
	
	