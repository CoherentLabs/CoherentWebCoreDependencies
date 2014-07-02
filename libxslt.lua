project 'LibXSLT'
	configuration '*Static'
		kind 'StaticLib'
	configuration 'not *Static'
		kind 'SharedLib'
	configuration '*'
	language 'C++'
	uuid 'D01D5582-8004-4D6C-9D43-9150EF44061E'
	
	configuration 'Release*'
		flags {
			'Optimize'
		}
	configuration '*'
	
	targetdir '../Build/%{cfg.platform}/%{cfg.shortname}'
	objdir '../BuildIntermediate/%{cfg.platform}/%{cfg.shortname}'
	
	files {
		-- public headers
		'libxslt/*.h',
		-- private headers
		-- sources
		'libxslt/*.c',
	}
	
	configuration 'Debug*'
		defines {
			'_DEBUG', 'DEBUG',
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
			'LIBXSLT_STATIC',
			'LIBXML_STATIC',
		}
	configuration 'not *Static'
	configuration '*'
	
	defines {
		'XSLT_REFACTORED',
		'XSLT_REFACTORED_XSLT_NSCOMP'
	}
	
	includedirs {
		'.',
		'../libxml2-2.9.1/include',
		'../libiconv-1.14/include',
	}
	
	links {
		'LibXML2'
	}
	
	if os.is('windows') then
		defines {
			'_CRT_SECURE_NO_WARNINGS',
			'WIN32',
		}
		
		configuration 'not *Static'
			prebuildcommands {
				'copy "..\\CoherentThirdPartyFiles\\libxslt.def" "win32\\libxslt.def" /Y'
			}
		
			linkoptions { '/def:win32/libxslt.def' }
		configuration '*'
	end
	
	