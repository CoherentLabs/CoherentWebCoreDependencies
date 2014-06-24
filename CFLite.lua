project 'CFLite'
	configuration '*Static'
		kind 'SharedLib'
	configuration 'not *Static'
		kind 'SharedLib'
	configuration '*'
	language 'C++'
	uuid '63F4572B-7FBB-44AE-8E80-7B52CA8535DD'

	flags {
		'Unicode'
	}
	
	configuration 'Release*'
		flags {
			'Optimize', 'EnableSSE2', 'OptimizeSpeed', 'SEH', 'NoFramePointer'
		}
	configuration '*'
	
	targetdir '../Build/%{cfg.platform}/%{cfg.shortname}'
	objdir '../BuildIntermediate/%{cfg.platform}/%{cfg.shortname}'
	
	files {
		'*.c'
	}
	
	configuration 'Debug*'
		defines { '_DEBUG', 'DEBUG' }
	configuration 'not Debug*'
		defines {
			'NDEBUG'
		}
	configuration '*'
		defines {
			'__i386__',
			'CFLITELIB_EXPORTS',
			'__STDC_LIMIT_MACROS',
			'CF_BUILDING_CF',
			'U_DISABLE_RENAMING'
		}
	
	includedirs {
		'./include',
		'../icu4c-53_1/source/common',
		'../pthreads/include/pthreads',
		'../icu4c-53_1/source/i18n',
		'./include/c99',
		'./include/CoreFoundation/GNUCompatibility',
		'.',
		'../include/unicode',
		'../include/objc4',
		'../include/pthreads'
	}
	
	if os.is('windows') then
		defines {
			'WIN32_LEAN_AND_MEAN',
			'DEPLOYMENT_TARGET_WINDOWS',
			'_WIN32_WINNT=0x0500',
			'WINVER=0x0500',
			'_CRT_SECURE_NO_DEPRECATE',
			'_SCL_SECURE_NO_DEPRECATE',
		}
		links {
			'libicuuc',
			'libicuin',
			'pthread',
			'netapi32',
			'ole32',
			'ws2_32',
			'rpcrt4'
		}
		buildoptions {
			'/wd4996', '/TP'
		}
	end

	