project 'pthread'
	configuration '*Static'
		kind 'SharedLib'
	configuration 'not *Static'
		kind 'SharedLib'
	configuration '*'
	language 'C++'
	uuid '73E9D062-C94E-4BAF-AD98-E03E56BA69F0'

	flags {
		'Unicode', 'Symbols'
	}
	
	configuration 'Release*'
		flags {
			'Optimize'
		}
	configuration '*'
	
	targetdir '../Build/%{cfg.platform}/%{cfg.shortname}'
	objdir '../BuildIntermediate/%{cfg.platform}/%{cfg.shortname}'
	
	files {
		'pthread.c'
	}
	
	configuration 'Debug*'
		defines { '_DEBUG' }
		flags {
			'Symbols'
		}
	configuration 'not Debug*'
		defines {
			'NDEBUG'
		}
		flags  {
			'EnableSSE2', 'OptimizeSpeed', 'SEH', 'NoFramePointer'
		}
	configuration '*'
		defines {
			'__CLEANUP_C'
		}
			
	includedirs {
		'.',
	}
	
	if os.is('windows') then
		defines {
			'PTW32_BUILD',
			'_CRT_SECURE_NO_DEPRECATE',
		}
		links {
			'ws2_32'
		}
		buildoptions
		{
			'/wd4996'
		}
		configuration 'not Debug*'
			buildoptions
			{
				'/Ot', '/Ob1', '/Ox', '/Oi','/Oy', '/GT', '/GL', '/Zo'
			}
	end

	