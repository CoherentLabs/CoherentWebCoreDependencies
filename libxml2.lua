project 'LibXML2'
	configuration '*Static'
		kind 'StaticLib'
	configuration 'not *Static'
		kind 'SharedLib'
	configuration '*'
	language 'C++'
	uuid '02E51FC3-85F4-4B6A-81D8-924D16562395'

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
		'include/libxml/*.h',
		-- private headers
		-- sources
		'buf.c',
		'c14n.c',
		'catalog.c',
		'chvalid.c',
		'debugXML.c',
		'dict.c',
		'DOCBparser.c',
		'encoding.c',
		'entities.c',
		'error.c',
		'globals.c',
		'hash.c',
		'HTMLparser.c',
		'HTMLtree.c',
		'legacy.c',
		'list.c',
		'nanoftp.c',
		'nanohttp.c',
		'parser.c',
		'parserInternals.c',
		'pattern.c',
		'relaxng.c',
		'SAX2.c',
		'SAX.c',
		'schematron.c',
		'threads.c',
		'tree.c',
		'uri.c',
		'valid.c',
		'xinclude.c',
		'xlink.c',
		'xmlIO.c',
		'xmlmemory.c',
		'xmlreader.c',
		'xmlregexp.c',
		'xmlmodule.c',
		'xmlsave.c',
		'xmlschemas.c',
		'xmlschemastypes.c',
		'xmlunicode.c',
		'xmlwriter.c',
		'xpath.c',
		'xpointer.c',
		'xmlstring.c',
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
			'LIBXML_STATIC', -- Must be defined in apps using static LibXML, too
			'NOLIBTOOL', -- Avoid redefinition warnings for LIBXML_STATIC
			'COHERENT_STATIC_LIBICONV'
		}
	configuration 'not *Static'
		defines {
			'PIC',
			'NOLIBTOOL'
		}
	configuration '*'
	
	defines {
	}
	
	links {
		'LibICONV'
	}
	
	if os.is('windows') then
		defines {
			'_CRT_SECURE_NO_WARNINGS'
		}
		
		includedirs {
			'win32/VC10' -- this must be the first include path so config.h is found here
		}
		
		links {
			'ws2_32'
		}
		
		configuration 'not *Static'
			links {
			}
		configuration 'not Debug*'
			buildoptions
			{
				'/Zo'
			}
		configuration '*'
	end
	
	includedirs {
		'.',
		'include',
		'../libiconv-1.14/include',
	}
	
	