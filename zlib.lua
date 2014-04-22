project 'ZLib'
	configuration '*Static'
		kind 'StaticLib'
	configuration 'not *Static'
		kind 'SharedLib'
	configuration '*'
	language 'C++'
	uuid '5DE9092C-5AAB-4624-800F-0C93BFE85882'

	flags {
		'Unicode'
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
		'zconf.h',
		'zlib.h',
		-- private headers
		'crc32.h',
		'deflate.h',
		'gzguts.h',
		'inffast.h',
		'inffixed.h',
		'inflate.h',
		'inftrees.h',
		'trees.h',
		'zutil.h',
		-- sources
		'adler32.c',
		'compress.c',
		'crc32.c',
		'deflate.c',
		'gzclose.c',
		'gzlib.c',
		'gzread.c',
		'gzwrite.c',
		'inflate.c',
		'infback.c',
		'inftrees.c',
		'inffast.c',
		'trees.c',
		'uncompr.c',
		'zutil.c',
	}
	
	configuration 'Debug*'
		defines { '_DEBUG' }
	configuration 'not Debug*'
		defines {
			'NDEBUG'
		}
	configuration '*'
	
	if os.is('windows') then
		defines {
			'NO_FSEEKO',
			'_CRT_SECURE_NO_DEPRECATE',
			'_CRT_NONSTDC_NO_DEPRECATE',
		}
	end

	configuration 'not *Static'
		defines { 'ZLIB_DLL' }
	configuration '*'

	if os.is('windows') then
		prebuildcommands {
			'echo f | xcopy zconf.h.in zconf.h /Y'
		}
	end
	
	
	