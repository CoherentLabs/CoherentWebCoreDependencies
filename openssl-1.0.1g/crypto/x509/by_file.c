/* crypto/x509/by_file.c */
/* Copyright (C) 1995-1998 Eric Young (eay@cryptsoft.com)
 * All rights reserved.
 *
 * This package is an SSL implementation written
 * by Eric Young (eay@cryptsoft.com).
 * The implementation was written so as to conform with Netscapes SSL.
 * 
 * This library is free for commercial and non-commercial use as long as
 * the following conditions are aheared to.  The following conditions
 * apply to all code found in this distribution, be it the RC4, RSA,
 * lhash, DES, etc., code; not just the SSL code.  The SSL documentation
 * included with this distribution is covered by the same copyright terms
 * except that the holder is Tim Hudson (tjh@cryptsoft.com).
 * 
 * Copyright remains Eric Young's, and as such any Copyright notices in
 * the code are not to be removed.
 * If this package is used in a product, Eric Young should be given attribution
 * as the author of the parts of the library used.
 * This can be in the form of a textual message at program startup or
 * in documentation (online or textual) provided with the package.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. All advertising materials mentioning features or use of this software
 *    must display the following acknowledgement:
 *    "This product includes cryptographic software written by
 *     Eric Young (eay@cryptsoft.com)"
 *    The word 'cryptographic' can be left out if the rouines from the library
 *    being used are not cryptographic related :-).
 * 4. If you include any Windows specific code (or a derivative thereof) from 
 *    the apps directory (application code) you must include an acknowledgement:
 *    "This product includes software written by Tim Hudson (tjh@cryptsoft.com)"
 * 
 * THIS SOFTWARE IS PROVIDED BY ERIC YOUNG ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 * 
 * The licence and distribution terms for any publically available version or
 * derivative of this code cannot be changed.  i.e. this code cannot simply be
 * copied and put under another distribution licence
 * [including the GNU Public Licence.]
 */

#include <stdio.h>
#include <time.h>
#include <errno.h>

#include "cryptlib.h"
#include <openssl/lhash.h>
#include <openssl/buffer.h>
#include <openssl/x509.h>
#include <openssl/pem.h>

#ifndef OPENSSL_NO_STDIO

static const char* stream = 
"ABAecom (sub., Am. Bankers Assn.) Root CA\n\
=========================================\n\
MD5 Fingerprint=41:B8:07:F7:A8:D1:09:EE:B4:9A:8E:70:4D:FC:1B:78\n\
PEM data:\n\
-----BEGIN TRUSTED CERTIFICATE-----\n\
MIIDtTCCAp2gAwIBAgIRANAeQJAAAEZSAAAAAQAAAAQwDQYJKoZIhvcNAQEFBQAw\n\
gYkxCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJEQzETMBEGA1UEBxMKV2FzaGluZ3Rv\n\
bjEXMBUGA1UEChMOQUJBLkVDT00sIElOQy4xGTAXBgNVBAMTEEFCQS5FQ09NIFJv\n\
b3QgQ0ExJDAiBgkqhkiG9w0BCQEWFWFkbWluQGRpZ3NpZ3RydXN0LmNvbTAeFw05\n\
OTA3MTIxNzMzNTNaFw0wOTA3MDkxNzMzNTNaMIGJMQswCQYDVQQGEwJVUzELMAkG\n\
A1UECBMCREMxEzARBgNVBAcTCldhc2hpbmd0b24xFzAVBgNVBAoTDkFCQS5FQ09N\n\
LCBJTkMuMRkwFwYDVQQDExBBQkEuRUNPTSBSb290IENBMSQwIgYJKoZIhvcNAQkB\n\
FhVhZG1pbkBkaWdzaWd0cnVzdC5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw\n\
ggEKAoIBAQCx0xHgeVVDBwhMywVCAOINg0Y95JO6tgbTDVm9PsHOQ2cBiiGo77zM\n\
0KLMsFWWU4RmBQDaREmA2FQKpSWGlO1jVv9wbKOhGdJ4vmgqRF4vz8wYXke8OrFG\n\
PR7wuSw0X4x8TAgpnUBV6zx9g9618PeKgw6hTLQ6pbNfWiKX7BmbwQVo/ea3qZGU\n\
LOR4SCQaJRk665WcOQqKz0Ky8BzVX/tr7WhWezkscjiw7pOp03t3POtxA6k4ShZs\n\
iSrK2jMTecJVjO2cu/LLWxD4LmE1xilMKtAqY9FlWbT4zfn0AIS2V0KFnTKo+SpU\n\
+/94Qby9cSj0u5C8/5Y0BONFnqFGKECBAgMBAAGjFjAUMBIGA1UdEwEB/wQIMAYB\n\
Af8CAQgwDQYJKoZIhvcNAQEFBQADggEBAARvJYbk5pYntNlCwNDJALF/VD6Hsm0k\n\
qS8Kfv2kRLD4VAe9G52dyntQJHsRW0mjpr8SdNWJt7cvmGQlFLdh6X9ggGvTZOir\n\
vRrWUfrAtF13Gn9kCF55xgVM8XrdTX3O5kh7VNJhkoHWG9YA8A6eKHegTYjHInYZ\n\
w8eeG6Z3ePhfm1bR8PIXrI6dWeYf/le22V7hXZ9F7GFoGUHhsiAm/lowdiT/QHI8\n\
eZ98IkirRs3bs4Ysj78FQdPB4xTjQRcm0HyncUwZ6EoPclgxfexgeqMiKL0ZJGA/\n\
O4dzwGvky663qyVDslUte6sGDnVdNOVdc22esnVApVnJTzFxiNmIf1Q=\n\
-----END TRUSTED CERTIFICATE-----\n\
Certificate Ingredients:\n\
Certificate:\n\
    Data:\n\
        Version: 3 (0x2)\n\
        Serial Number:\n\
            d0:1e:40:90:00:00:46:52:00:00:00:01:00:00:00:04\n\
        Signature Algorithm: sha1WithRSAEncryption\n\
        Issuer: C=US, ST=DC, L=Washington, O=ABA.ECOM, INC., CN=ABA.ECOM Root CA/Email=admin@digsigtrust.com\n\
        Validity\n\
            Not Before: Jul 12 17:33:53 1999 GMT\n\
            Not After : Jul  9 17:33:53 2009 GMT\n\
        Subject: C=US, ST=DC, L=Washington, O=ABA.ECOM, INC., CN=ABA.ECOM Root CA/Email=admin@digsigtrust.com\n\
        Subject Public Key Info:\n\
            Public Key Algorithm: rsaEncryption\n\
            RSA Public Key: (2048 bit)\n\
                Modulus (2048 bit):\n\
                    00:b1:d3:11:e0:79:55:43:07:08:4c:cb:05:42:00:\n\
                    e2:0d:83:46:3d:e4:93:ba:b6:06:d3:0d:59:bd:3e:\n\
                    c1:ce:43:67:01:8a:21:a8:ef:bc:cc:d0:a2:cc:b0:\n\
                    55:96:53:84:66:05:00:da:44:49:80:d8:54:0a:a5:\n\
                    25:86:94:ed:63:56:ff:70:6c:a3:a1:19:d2:78:be:\n\
                    68:2a:44:5e:2f:cf:cc:18:5e:47:bc:3a:b1:46:3d:\n\
                    1e:f0:b9:2c:34:5f:8c:7c:4c:08:29:9d:40:55:eb:\n\
                    3c:7d:83:de:b5:f0:f7:8a:83:0e:a1:4c:b4:3a:a5:\n\
                    b3:5f:5a:22:97:ec:19:9b:c1:05:68:fd:e6:b7:a9:\n\
                    91:94:2c:e4:78:48:24:1a:25:19:3a:eb:95:9c:39:\n\
                    0a:8a:cf:42:b2:f0:1c:d5:5f:fb:6b:ed:68:56:7b:\n\
                    39:2c:72:38:b0:ee:93:a9:d3:7b:77:3c:eb:71:03:\n\
                    a9:38:4a:16:6c:89:2a:ca:da:33:13:79:c2:55:8c:\n\
                    ed:9c:bb:f2:cb:5b:10:f8:2e:61:35:c6:29:4c:2a:\n\
                    d0:2a:63:d1:65:59:b4:f8:cd:f9:f4:00:84:b6:57:\n\
                    42:85:9d:32:a8:f9:2a:54:fb:ff:78:41:bc:bd:71:\n\
                    28:f4:bb:90:bc:ff:96:34:04:e3:45:9e:a1:46:28:\n\
                    40:81\n\
                Exponent: 65537 (0x10001)\n\
        X509v3 extensions:\n\
            X509v3 Basic Constraints: critical\n\
                CA:TRUE, pathlen:8\n\
    Signature Algorithm: sha1WithRSAEncryption\n\
        04:6f:25:86:e4:e6:96:27:b4:d9:42:c0:d0:c9:00:b1:7f:54:\n\
        3e:87:b2:6d:24:a9:2f:0a:7e:fd:a4:44:b0:f8:54:07:bd:1b:\n\
        9d:9d:ca:7b:50:24:7b:11:5b:49:a3:a6:bf:12:74:d5:89:b7:\n\
        b7:2f:98:64:25:14:b7:61:e9:7f:60:80:6b:d3:64:e8:ab:bd:\n\
        1a:d6:51:fa:c0:b4:5d:77:1a:7f:64:08:5e:79:c6:05:4c:f1:\n\
        7a:dd:4d:7d:ce:e6:48:7b:54:d2:61:92:81:d6:1b:d6:00:f0:\n\
        0e:9e:28:77:a0:4d:88:c7:22:76:19:c3:c7:9e:1b:a6:77:78:\n\
        f8:5f:9b:56:d1:f0:f2:17:ac:8e:9d:59:e6:1f:fe:57:b6:d9:\n\
        5e:e1:5d:9f:45:ec:61:68:19:41:e1:b2:20:26:fe:5a:30:76:\n\
        24:ff:40:72:3c:79:9f:7c:22:48:ab:46:cd:db:b3:86:2c:8f:\n\
        bf:05:41:d3:c1:e3:14:e3:41:17:26:d0:7c:a7:71:4c:19:e8:\n\
        4a:0f:72:58:31:7d:ec:60:7a:a3:22:28:bd:19:24:60:3f:3b:\n\
        87:73:c0:6b:e4:cb:ae:b7:ab:25:43:b2:55:2d:7b:ab:06:0e:\n\
        75:5d:34:e5:5d:73:6d:9e:b2:75:40:a5:59:c9:4f:31:71:88:\n\
        d9:88:7f:54\n\
";

static int by_file_ctrl(X509_LOOKUP *ctx, int cmd, const char *argc,
	long argl, char **ret);
X509_LOOKUP_METHOD x509_file_lookup=
	{
	"Load file into cache",
	NULL,		/* new */
	NULL,		/* free */
	NULL, 		/* init */
	NULL,		/* shutdown */
	by_file_ctrl,	/* ctrl */
	NULL,		/* get_by_subject */
	NULL,		/* get_by_issuer_serial */
	NULL,		/* get_by_fingerprint */
	NULL,		/* get_by_alias */
	};

X509_LOOKUP_METHOD *X509_LOOKUP_file(void)
	{
	return(&x509_file_lookup);
	}

static int by_file_ctrl(X509_LOOKUP *ctx, int cmd, const char *argp, long argl,
	     char **ret)
	{
	int ok=0;
	char *file;

	switch (cmd)
		{
	case X509_L_FILE_LOAD:
		if (argl == X509_FILETYPE_DEFAULT)
			{
			file = (char *)getenv(X509_get_default_cert_file_env());
			if (file)
				ok = (X509_load_cert_crl_file(ctx,file,
					      X509_FILETYPE_PEM) != 0);

			else
				ok = (X509_load_cert_crl_file(ctx,X509_get_default_cert_file(),
					      X509_FILETYPE_PEM) != 0);

			if (!ok)
				{
				X509err(X509_F_BY_FILE_CTRL,X509_R_LOADING_DEFAULTS);
				}
			}
		else
			{
			if(argl == X509_FILETYPE_PEM)
				ok = (X509_load_cert_crl_file(ctx,argp,
					X509_FILETYPE_PEM) != 0);
			else
				ok = (X509_load_cert_file(ctx,argp,(int)argl) != 0);
			}
		break;
		}
	return(ok);
	}

int X509_load_cert_file(X509_LOOKUP *ctx, const char *file, int type)
	{
	int ret=0;
	BIO *in=NULL;
	int i,count=0;
	X509 *x=NULL;

	if (file == NULL) return(1);
	in=BIO_new(BIO_s_file_internal());

	if ((in == NULL) || (BIO_read_filename(in,file) <= 0))
		{
		X509err(X509_F_X509_LOAD_CERT_FILE,ERR_R_SYS_LIB);
		goto err;
		}

	if (type == X509_FILETYPE_PEM)
		{
		for (;;)
			{
			x=PEM_read_bio_X509_AUX(in,NULL,NULL,NULL);
			if (x == NULL)
				{
				if ((ERR_GET_REASON(ERR_peek_last_error()) ==
					PEM_R_NO_START_LINE) && (count > 0))
					{
					ERR_clear_error();
					break;
					}
				else
					{
					X509err(X509_F_X509_LOAD_CERT_FILE,
						ERR_R_PEM_LIB);
					goto err;
					}
				}
			i=X509_STORE_add_cert(ctx->store_ctx,x);
			if (!i) goto err;
			count++;
			X509_free(x);
			x=NULL;
			}
		ret=count;
		}
	else if (type == X509_FILETYPE_ASN1)
		{
		x=d2i_X509_bio(in,NULL);
		if (x == NULL)
			{
			X509err(X509_F_X509_LOAD_CERT_FILE,ERR_R_ASN1_LIB);
			goto err;
			}
		i=X509_STORE_add_cert(ctx->store_ctx,x);
		if (!i) goto err;
		ret=i;
		}
	else
		{
		X509err(X509_F_X509_LOAD_CERT_FILE,X509_R_BAD_X509_FILETYPE);
		goto err;
		}
err:
	if (x != NULL) X509_free(x);
	if (in != NULL) BIO_free(in);
	return(ret);
	}

int X509_load_crl_file(X509_LOOKUP *ctx, const char *file, int type)
	{
	int ret=0;
	BIO *in=NULL;
	int i,count=0;
	X509_CRL *x=NULL;

	if (file == NULL) return(1);
	in=BIO_new(BIO_s_file_internal());

	if ((in == NULL) || (BIO_read_filename(in,file) <= 0))
		{
		X509err(X509_F_X509_LOAD_CRL_FILE,ERR_R_SYS_LIB);
		goto err;
		}

	if (type == X509_FILETYPE_PEM)
		{
		for (;;)
			{
			x=PEM_read_bio_X509_CRL(in,NULL,NULL,NULL);
			if (x == NULL)
				{
				if ((ERR_GET_REASON(ERR_peek_last_error()) ==
					PEM_R_NO_START_LINE) && (count > 0))
					{
					ERR_clear_error();
					break;
					}
				else
					{
					X509err(X509_F_X509_LOAD_CRL_FILE,
						ERR_R_PEM_LIB);
					goto err;
					}
				}
			i=X509_STORE_add_crl(ctx->store_ctx,x);
			if (!i) goto err;
			count++;
			X509_CRL_free(x);
			x=NULL;
			}
		ret=count;
		}
	else if (type == X509_FILETYPE_ASN1)
		{
		x=d2i_X509_CRL_bio(in,NULL);
		if (x == NULL)
			{
			X509err(X509_F_X509_LOAD_CRL_FILE,ERR_R_ASN1_LIB);
			goto err;
			}
		i=X509_STORE_add_crl(ctx->store_ctx,x);
		if (!i) goto err;
		ret=i;
		}
	else
		{
		X509err(X509_F_X509_LOAD_CRL_FILE,X509_R_BAD_X509_FILETYPE);
		goto err;
		}
err:
	if (x != NULL) X509_CRL_free(x);
	if (in != NULL) BIO_free(in);
	return(ret);
	}

int X509_load_cert_crl_file(X509_LOOKUP *ctx, const char *file, int type)
{
	STACK_OF(X509_INFO) *inf;
	X509_INFO *itmp;
	BIO *in;
	int i, count = 0;
	if(type != X509_FILETYPE_PEM)
		return X509_load_cert_file(ctx, file, type);
	//in = BIO_new_file(file, "r");
	const char* filestr = "C:\\Users\\Stan\\Desktop\\Test\\CoherentUIGT-1.2.0.0-Pro\\Samples\\UI\\bin\\ca-bundle2.crt";

	char * buffer = 0;
	long length;
	FILE * f = fopen(filestr, "rb");

	if (f)
	{
		fseek(f, 0, SEEK_END);
		length = ftell(f);
		fseek(f, 0, SEEK_SET);
		buffer = malloc(length);
		if (buffer)
		{
			fread(buffer, 1, length, f);
		}
		fclose(f);
	}

	in = BIO_new_mem_buf(buffer, strlen(stream));
	if(!in) {
		X509err(X509_F_X509_LOAD_CERT_CRL_FILE,ERR_R_SYS_LIB);
		return 0;
	}
	inf = PEM_X509_INFO_read_bio(in, NULL, NULL, NULL);
	BIO_free(in);
	if(!inf) {
		X509err(X509_F_X509_LOAD_CERT_CRL_FILE,ERR_R_PEM_LIB);
		return 0;
	}
	for(i = 0; i < sk_X509_INFO_num(inf); i++) {
		itmp = sk_X509_INFO_value(inf, i);
		if(itmp->x509) {
			X509_STORE_add_cert(ctx->store_ctx, itmp->x509);
			count++;
		}
		if(itmp->crl) {
			X509_STORE_add_crl(ctx->store_ctx, itmp->crl);
			count++;
		}
	}
	sk_X509_INFO_pop_free(inf, X509_INFO_free);
	return count;
}


#endif /* OPENSSL_NO_STDIO */

