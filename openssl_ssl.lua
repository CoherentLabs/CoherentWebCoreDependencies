project 'OpenSSL_SSL'
	configuration '*Static'
		kind 'StaticLib'
	configuration 'not *Static'
		kind 'SharedLib'
	configuration '*'
	language 'C++'
	uuid '6D02854E-075D-42BA-9218-A5C89D47F417'

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
		'*.h',
		'inc32/*.h',
		-- private headers
		'crypto/md5/*.h',
		'crypto/sha/*.h',
		'crypto/ripemd/*.h',
		'crypto/des/*.h',
		'crypto/rc2/*.h',
		'crypto/rc4/*.h',
		'crypto/bf/*.h',
		'crypto/idea/*.h',
		'crypto/cast/*.h',
		'crypto/ripemd/*.h',
		'crypto/aes/*.h',
		'crypto/camellia/*.h',
		'crypto/seed/*.h',
		'crypto/modes/*.h',
		'crypto/bn/*.h',
		'crypto/dsa/*.h',
		'crypto/ec/*.h',
		'crypto/ecdh/*.h',
		'crypto/ecdsa/*.h',
		'crypto/bio/*.h',
		'crypto/objects/*.h',
		'crypto/evp/*.h',
		'crypto/asn1/*.h',
		'crypto/x509v3/*.h',
		'crypto/cms/*.h',
		'crypto/conf/*.h',
		'crypto/ui/*.h',
		'crypto/whrlpool/*.h',
		-- sources
		'ssl/s2_meth.c',
		'ssl/s2_srvr.c',
		'ssl/s2_clnt.c',
		'ssl/s2_lib.c',
		'ssl/s2_enc.c',
		'ssl/s2_pkt.c',
		'ssl/s3_meth.c',
		'ssl/s3_srvr.c',
		'ssl/s3_clnt.c',
		'ssl/s3_lib.c',
		'ssl/s3_enc.c',
		'ssl/s3_pkt.c',
		'ssl/s3_both.c',
		'ssl/s3_cbc.c',
		'ssl/s23_meth.c',
		'ssl/s23_srvr.c',
		'ssl/s23_clnt.c',
		'ssl/s23_lib.c',
		'ssl/s23_pkt.c',
		'ssl/t1_meth.c',
		'ssl/t1_srvr.c',
		'ssl/t1_clnt.c',
		'ssl/t1_lib.c',
		'ssl/t1_enc.c',
		'ssl/d1_meth.c',
		'ssl/d1_srvr.c',
		'ssl/d1_clnt.c',
		'ssl/d1_lib.c',
		'ssl/d1_pkt.c',
		'ssl/d1_both.c',
		'ssl/d1_enc.c',
		'ssl/d1_srtp.c',
		'ssl/ssl_lib.c',
		'ssl/ssl_err2.c',
		'ssl/ssl_cert.c',
		'ssl/ssl_sess.c',
		'ssl/ssl_ciph.c',
		'ssl/ssl_stat.c',
		'ssl/ssl_rsa.c',
		'ssl/ssl_asn1.c',
		'ssl/ssl_txt.c',
		'ssl/ssl_algs.c',
		'ssl/bio_ssl.c',
		'ssl/ssl_err.c',
		'ssl/kssl.c',
		'ssl/tls_srp.c',
		'ssl/t1_reneg.c',
	}
	
	configuration 'Debug*'
		defines {
			'_DEBUG',
		}
	configuration 'not Debug*'
		defines {
			'NDEBUG'
		}
	configuration '*'
	
	defines {
		'OPENSSL_THREADS',
		'LIBSSH2_HAVE_ZLIB',
		'L_ENDIAN',
		'OPENSSL_NO_RC5',
		'OPENSSL_NO_MD2',
		'OPENSSL_NO_KRB5',
		'OPENSSL_NO_JPAKE',
	}
	
	configuration '*Static'
		defines { 'OPENSSL_NO_DYNAMIC_ENGINE' }
	configuration 'not *Static'
		defines { 'OPENSSL_NO_STATIC_ENGINE', 'OPENSSL_USE_APPLINK' }
	configuration '*'
	
	includedirs {
		'.',
		'inc32',
		'crypto',
		'crypto/md5',
		'crypto/sha',
		'crypto/ripemd',
		'crypto/des',
		'crypto/rc2',
		'crypto/rc4',
		'crypto/bf',
		'crypto/idea',
		'crypto/cast',
		'crypto/ripemd',
		'crypto/aes',
		'crypto/camellia',
		'crypto/seed',
		'crypto/modes',
		'crypto/bn',
		'crypto/dsa',
		'crypto/ec',
		'crypto/ecdh',
		'crypto/ecdsa',
		'crypto/bio',
		'crypto/objects',
		'crypto/evp',
		'crypto/asn1',
		'crypto/x509v3',
		'crypto/cms',
		'crypto/conf',
		'crypto/ui',
		'crypto/whrlpool',
	}
	
	links {
		'OpenSSL_Crypto'
	}
	
	if os.is('windows') then
		defines {
			'MK1MF_BUILD',
			'WIN32_LEAN_AND_MEAN',
			'DSO_WIN32',
			'OPENSSL_SYSNAME_WIN32',
			'_CRT_SECURE_NO_DEPRECATE'
		}
		
		links {
			'ws2_32',
			'crypt32'
		}
		
		prebuildcommands {
			 'copy "..\\CoherentThirdPartyFiles\\ssleay32.def" "ms\\SSLEAY32.def" /Y',
		}
		
		configuration 'not *Static'
			linkoptions { '/def:ms/SSLEAY32.def' }
		configuration '*'
	end
