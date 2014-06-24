solution 'CoherentWebCoreDependencies'
	configurations { 'Debug', 'Debug Static', 'Release', 'Release Static' }
	platforms { 'x32', 'x64' }
	
	include 'curl-7.36.0/curl.lua'
	include 'icu4c-53_1/source/icu_stubdata.lua'
	include 'icu4c-53_1/source/libicuuc.lua'
	include 'icu4c-53_1/source/libicuin.lua'
	include 'libiconv-1.14/libiconv.lua'
	include 'libssh2-1.4.3/libssh.lua'
	include 'libxml2-2.9.1/libxml2.lua'
	include 'libxslt-1.1.28/libxslt.lua'
	include 'openssl-1.0.1g/openssl_ssl.lua'
	include 'openssl-1.0.1g/openssl_crypto.lua'
	include 'libpng-1.6.10/libpng.lua'
	include 'sqlite-amalgamation-3080403/sqlite.lua'
	include 'zlib-1.2.8/zlib.lua'