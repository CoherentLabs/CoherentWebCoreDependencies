project 'LibCURL'
	configuration '*Static'
		kind 'StaticLib'
	configuration 'not *Static'
		kind 'SharedLib'
	configuration '*'
	language 'C++'
	uuid 'A4C2B20C-C876-40F5-BF62-97D5F5557336'

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
		'include/curl/*.h',
		-- private headers
		'lib/*.h',
		'lib/vtls/*.h',
		-- sources
		'lib/*.c',
		'lib/vtls/*.c',
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
			'CURL_STATICLIB'
		}
	configuration 'not *Static'
	configuration '*'
	
	defines {
		'BUILDING_LIBCURL',
		'USE_SSLEAY', -- Use OpenSSL
		'HAVE_CRYPTO_CLEANUP_ALL_EX_DATA',
		'HAVE_OPENSSL_ENGINE_H',
		'USE_OPENSSL',
		'HAVE_LIBSSH2', -- Use LibSSH
		'HAVE_LIBSSH2_H',
		'LIBSSH2_LIBRARY',
		'USE_LIBSSH2',
		'HAVE_ZLIB_H', -- Use ZLib
		'HAVE_ZLIB',
		'HAVE_LIBZ',
	}
	
	includedirs {
		'include',
		'lib',
		'lib/vtls',
		'../zlib-1.2.8',
		'../openssl-1.0.1g/inc32',
		'../libssh2-1.4.3/include'
	}
	
	links {
		'ZLib',
		'OpenSSL_SSL',
		'OpenSSL_Crypto',
		'LibSSH',
	}
	
	if os.is('windows') then
		defines {
			'WIN32',
			'LIBSSH2_WIN32' -- Use LibSSH
		}
		
		links {
			'ws2_32',
			'Wldap32'
		}
	end
	
	
	