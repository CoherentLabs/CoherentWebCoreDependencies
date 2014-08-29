project 'SQLite'
	configuration '*Static'
		kind 'StaticLib'
	configuration 'not *Static'
		kind 'SharedLib'
	configuration '*'
	language 'C++'
	uuid '28DEC226-8D57-4C29-9CD3-86C2F33EA306'

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
		'*.h',
		-- private headers
		-- sources
		'*.c',
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
	configuration 'not *Static'
	configuration '*'
	
	defines {
		'THREADSAFE=1',
		'SQLITE_THREADSAFE=2',
		'SQLITE_ENABLE_COLUMN_METADATA',
		'SQLITE_DEFAULT_CACHE_SIZE=500',
	}
	
	includedirs {
		'.',
	}
	
	links {
	}
	
	if os.is('windows') then
		defines {
			'_CRT_SECURE_NO_WARNINGS',
			'WIN32',
		}
		
		configuration 'not *Static'
			prebuildcommands {
				'copy "..\\CoherentThirdPartyFiles\\sqlite3_win32.def" "sqlite3.def" /Y'
			}
			
			linkoptions {
				'/def:sqlite3.def'
			}
		configuration 'not Debug*'
			buildoptions
			{
				'/Zo'
			}
		configuration '*'
	end
	
	