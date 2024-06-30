Return-Path: <linux-pci+bounces-9473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD84591D3C2
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 22:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2511C20B2E
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 20:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F91282F1;
	Sun, 30 Jun 2024 20:15:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8B32110F;
	Sun, 30 Jun 2024 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719778525; cv=none; b=fQ5TqTn2mpytddPBumSWiF/taVxYszRGzqHb/SNmAidjSvE/Q+Hs2/GdjYGVxBO99Dy+9dK1T/HWg7q0JndniHU/unRUjmvUy7rLGLVDIZmh/7ogSIQemQFzmFOELHpPCIduCfAOQU8TZ3evfslBvV6YmiVAXAFTRUiHhwLwPvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719778525; c=relaxed/simple;
	bh=Hojvv9PFyIBTLs/FmH8uB66KIQrGv0vTax6zl3x1V3k=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=jxnSH2C8NOy+2/sAm9vrIjsIF5GJ7q9dYaE1EuKyoiJ4dDIZZyQDPgKn8ZOO4TorecT+OIoPI2Ds3Moa9D3mCRG96ltsyDSFEkvvlWpoU47fcAOb5/z8n1xuRediZ5jxQJBWBl71QMuINEA4usZm7SD07mJWmxxZntIMYgCMVuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 8AE1D101E6A35;
	Sun, 30 Jun 2024 22:08:01 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 33C6D61DA805;
	Sun, 30 Jun 2024 22:08:01 +0200 (CEST)
X-Mailbox-Line: From d143bb81c65064654af926317f69e6578cf0cdb9 Mon Sep 17 00:00:00 2001
Message-ID: <d143bb81c65064654af926317f69e6578cf0cdb9.1719771133.git.lukas@wunner.de>
In-Reply-To: <cover.1719771133.git.lukas@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 30 Jun 2024 21:41:00 +0200
Subject: [PATCH v2 06/18] crypto: ecdsa - Support P1363 signature encoding
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Cc: <linuxarm@huawei.com>, David Box <david.e.box@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Li, Ming" <ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Alistair Francis <alistair.francis@wdc.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, "Damien Le Moal" <dlemoal@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>, Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>, Sean Christopherson <seanjc@google.com>, Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>, Eric Biggers <ebiggers@google.com>, Stefan Berger <stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Alternatively to the X9.62 encoding of ecdsa signatures, which uses
ASN.1 and is already supported by the kernel, there's another common
encoding called P1363.  It stores r and s as the concatenation of two
big endian, unsigned integers.  The name originates from IEEE P1363.

The Security Protocol and Data Model (SPDM) specification prescribes
that ecdsa signatures are encoded according to P1363:

   "For ECDSA signatures, excluding SM2, in SPDM, the signature shall be
    the concatenation of r and s.  The size of r shall be the size of
    the selected curve.  Likewise, the size of s shall be the size of
    the selected curve.  See BaseAsymAlgo in NEGOTIATE_ALGORITHMS for
    the size of r and s.  The byte order for r and s shall be in big
    endian order.  When placing ECDSA signatures into an SPDM signature
    field, r shall come first followed by s."

    (SPDM 1.2.1 margin no 44,
    https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.2.1.pdf)

A subsequent commit introduces an SPDM library to enable PCI device
authentication, so add support for P1363 ecdsa signature verification.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 crypto/asymmetric_keys/public_key.c | 40 +++++++++++++++++------------
 crypto/ecdsa.c                      | 18 ++++++++++---
 crypto/testmgr.h                    | 19 ++++++++++++++
 3 files changed, 58 insertions(+), 19 deletions(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index 00f70835359f..9a6f030a5847 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -104,7 +104,8 @@ software_key_determine_akcipher(const struct public_key *pkey,
 			return -EINVAL;
 		*sig = false;
 	} else if (strncmp(pkey->pkey_algo, "ecdsa", 5) == 0) {
-		if (strcmp(encoding, "x962") != 0)
+		if (strcmp(encoding, "x962") != 0 &&
+		    strcmp(encoding, "p1363") != 0)
 			return -EINVAL;
 		/*
 		 * ECDSA signatures are taken over a raw hash, so they don't
@@ -234,7 +235,6 @@ static int software_key_query(const struct kernel_pkey_params *params,
 	info->key_size = len * 8;
 
 	if (strncmp(pkey->pkey_algo, "ecdsa", 5) == 0) {
-		int slen = len;
 		/*
 		 * ECDSA key sizes are much smaller than RSA, and thus could
 		 * operate on (hashed) inputs that are larger than key size.
@@ -246,21 +246,29 @@ static int software_key_query(const struct kernel_pkey_params *params,
 
 		/*
 		 * Verify takes ECDSA-Sig (described in RFC 5480) as input,
-		 * which is actually 2 'key_size'-bit integers encoded in
-		 * ASN.1.  Account for the ASN.1 encoding overhead here.
-		 *
-		 * NIST P192/256/384 may prepend a '0' to a coordinate to
-		 * indicate a positive integer. NIST P521 never needs it.
+		 * which is actually 2 'key_size'-bit integers.
 		 */
-		if (strcmp(pkey->pkey_algo, "ecdsa-nist-p521") != 0)
-			slen += 1;
-		/* Length of encoding the x & y coordinates */
-		slen = 2 * (slen + 2);
-		/*
-		 * If coordinate encoding takes at least 128 bytes then an
-		 * additional byte for length encoding is needed.
-		 */
-		info->max_sig_size = 1 + (slen >= 128) + 1 + slen;
+		if (strcmp(params->encoding, "x962") == 0) {
+			int slen = len;
+
+			/*
+			 * Account for the ASN.1 encoding overhead here.
+			 *
+			 * NIST P192/256/384 may prepend a '0' to a coordinate
+			 * to indicate a positive integer. NIST P521 does not.
+			 */
+			if (strcmp(pkey->pkey_algo, "ecdsa-nist-p521") != 0)
+				slen += 1;
+			/* Length of encoding the x & y coordinates */
+			slen = 2 * (slen + 2);
+			/*
+			 * If coordinate encoding takes at least 128 bytes then
+			 * an additional byte for length encoding is needed.
+			 */
+			info->max_sig_size = 1 + (slen >= 128) + 1 + slen;
+		} else if (strcmp(params->encoding, "p1363") == 0) {
+			info->max_sig_size = 2 * len;
+		}
 	} else {
 		info->max_data_size = len;
 		info->max_sig_size = len;
diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index 258fffbf623d..8d412dec917f 100644
--- a/crypto/ecdsa.c
+++ b/crypto/ecdsa.c
@@ -139,6 +139,7 @@ static int ecdsa_verify(struct akcipher_request *req)
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
 	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
 	size_t bufsize = ctx->curve->g.ndigits * sizeof(u64);
+	size_t keylen = DIV_ROUND_UP(ctx->curve->nbits, 8);
 	struct ecdsa_signature_ctx sig_ctx = {
 		.curve = ctx->curve,
 	};
@@ -159,10 +160,21 @@ static int ecdsa_verify(struct akcipher_request *req)
 		sg_nents_for_len(req->src, req->src_len + req->dst_len),
 		buffer, req->src_len + req->dst_len, 0);
 
-	ret = asn1_ber_decoder(&ecdsasignature_decoder, &sig_ctx,
-			       buffer, req->src_len);
-	if (ret < 0)
+	if (strcmp(req->enc, "x962") == 0) {
+		ret = asn1_ber_decoder(&ecdsasignature_decoder, &sig_ctx,
+				       buffer, req->src_len);
+		if (ret < 0)
+			goto error;
+	} else if (strcmp(req->enc, "p1363") == 0 &&
+		   req->src_len == 2 * keylen) {
+		ecc_digits_from_bytes(buffer, keylen, sig_ctx.r,
+				      ctx->curve->g.ndigits);
+		ecc_digits_from_bytes(&buffer[keylen], keylen, sig_ctx.s,
+				      ctx->curve->g.ndigits);
+	} else {
+		ret = -EINVAL;
 		goto error;
+	}
 
 	/* if the hash is shorter then we will add leading zeros to fit to ndigits */
 	diff = bufsize - req->dst_len;
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 7e34e3f871a3..6c9eb401ad20 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -674,6 +674,7 @@ static const struct akcipher_testvec ecdsa_nist_p192_tv_template[] = {
 	"\x68\x01\x9d\xba\xce\x83\x08\xef\x95\x52\x7b\xa0\x0f\xe4\x18\x86"
 	"\x80\x6f\xa5\x79\x77\xda\xd0",
 	.c_size = 55,
+	.enc = "x962",
 	.public_key_vec = true,
 	.siggen_sigver_test = true,
 	}, {
@@ -698,6 +699,7 @@ static const struct akcipher_testvec ecdsa_nist_p192_tv_template[] = {
 	"\x4f\x53\x75\xc8\x02\x48\xeb\xc3\x92\x0f\x1e\x72\xee\xc4\xa3\xe3"
 	"\x5c\x99\xdb\x92\x5b\x36",
 	.c_size = 54,
+	.enc = "x962",
 	.public_key_vec = true,
 	.siggen_sigver_test = true,
 	}, {
@@ -722,6 +724,7 @@ static const struct akcipher_testvec ecdsa_nist_p192_tv_template[] = {
 	"\x69\x43\xfd\x48\x19\x86\xcf\x32\xdd\x41\x74\x6a\x51\xc7\xd9\x7d"
 	"\x3a\x97\xd9\xcd\x1a\x6a\x49",
 	.c_size = 55,
+	.enc = "x962",
 	.public_key_vec = true,
 	.siggen_sigver_test = true,
 	}, {
@@ -747,6 +750,7 @@ static const struct akcipher_testvec ecdsa_nist_p192_tv_template[] = {
 	"\xbc\x5a\x1f\x82\x96\x61\xd7\xd1\x01\x77\x44\x5d\x53\xa4\x7c\x93"
 	"\x12\x3b\x3b\x28\xfb\x6d\xe1",
 	.c_size = 55,
+	.enc = "x962",
 	.public_key_vec = true,
 	.siggen_sigver_test = true,
 	}, {
@@ -773,6 +777,7 @@ static const struct akcipher_testvec ecdsa_nist_p192_tv_template[] = {
 	"\xb4\x22\x9a\x98\x73\x3c\x83\xa9\x14\x2a\x5e\xf5\xe5\xfb\x72\x28"
 	"\x6a\xdf\x97\xfd\x82\x76\x24",
 	.c_size = 55,
+	.enc = "x962",
 	.public_key_vec = true,
 	.siggen_sigver_test = true,
 	},
@@ -803,6 +808,7 @@ static const struct akcipher_testvec ecdsa_nist_p256_tv_template[] = {
 	"\x8a\xfa\x54\x93\x29\xa7\x70\x86\xf1\x03\x03\xf3\x3b\xe2\x73\xf7"
 	"\xfb\x9d\x8b\xde\xd4\x8d\x6f\xad",
 	.c_size = 72,
+	.enc = "x962",
 	.public_key_vec = true,
 	.siggen_sigver_test = true,
 	}, {
@@ -829,6 +835,7 @@ static const struct akcipher_testvec ecdsa_nist_p256_tv_template[] = {
 	"\x4a\x77\x22\xec\xc8\x66\xbf\x50\x05\x58\x39\x0e\x26\x92\xce\xd5"
 	"\x2e\x8b\xde\x5a\x04\x0e",
 	.c_size = 70,
+	.enc = "x962",
 	.public_key_vec = true,
 	.siggen_sigver_test = true,
 	}, {
@@ -855,6 +862,7 @@ static const struct akcipher_testvec ecdsa_nist_p256_tv_template[] = {
 	"\xa9\x81\xac\x4a\x50\xd0\x91\x0a\x6e\x1b\xc4\xaf\xe1\x83\xc3\x4f"
 	"\x2a\x65\x35\x23\xe3\x1d\xfa",
 	.c_size = 71,
+	.enc = "x962",
 	.public_key_vec = true,
 	.siggen_sigver_test = true,
 	}, {
@@ -882,6 +890,7 @@ static const struct akcipher_testvec ecdsa_nist_p256_tv_template[] = {
 	"\x19\xfb\x5f\x92\xf4\xc9\x23\x37\x69\xf4\x3b\x4f\x47\xcf\x9b\x16"
 	"\xc0\x60\x11\x92\xdc\x17\x89\x12",
 	.c_size = 72,
+	.enc = "x962",
 	.public_key_vec = true,
 	.siggen_sigver_test = true,
 	}, {
@@ -910,6 +919,7 @@ static const struct akcipher_testvec ecdsa_nist_p256_tv_template[] = {
 	"\x00\xdd\xab\xd4\xc0\x2b\xe6\x5c\xad\xc3\x78\x1c\xc2\xc1\x19\x76"
 	"\x31\x79\x4a\xe9\x81\x6a\xee",
 	.c_size = 71,
+	.enc = "x962",
 	.public_key_vec = true,
 	.siggen_sigver_test = true,
 	},
@@ -944,6 +954,7 @@ static const struct akcipher_testvec ecdsa_nist_p384_tv_template[] = {
 	"\x74\xa0\x0f\xbf\xaf\xc3\x36\x76\x4a\xa1\x59\xf1\x1c\xa4\x58\x26"
 	"\x79\x12\x2a\xb7\xc5\x15\x92\xc5",
 	.c_size = 104,
+	.enc = "x962",
 	.public_key_vec = true,
 	.siggen_sigver_test = true,
 	}, {
@@ -974,6 +985,7 @@ static const struct akcipher_testvec ecdsa_nist_p384_tv_template[] = {
 	"\x4d\xd0\xc6\x6e\xb0\xe9\xfc\x14\x9f\x19\xd0\x42\x8b\x93\xc2\x11"
 	"\x88\x2b\x82\x26\x5e\x1c\xda\xfb",
 	.c_size = 104,
+	.enc = "x962",
 	.public_key_vec = true,
 	.siggen_sigver_test = true,
 	}, {
@@ -1004,6 +1016,7 @@ static const struct akcipher_testvec ecdsa_nist_p384_tv_template[] = {
 	"\xc0\x75\x3e\x23\x5e\x36\x4f\x8d\xde\x1e\x93\x8d\x95\xbb\x10\x0e"
 	"\xf4\x1f\x39\xca\x4d\x43",
 	.c_size = 102,
+	.enc = "x962",
 	.public_key_vec = true,
 	.siggen_sigver_test = true,
 	}, {
@@ -1035,6 +1048,7 @@ static const struct akcipher_testvec ecdsa_nist_p384_tv_template[] = {
 	"\x44\x92\x8c\x86\x99\x65\xb3\x97\x96\x17\x04\xc9\x05\x77\xf1\x8e"
 	"\xab\x8d\x4e\xde\xe6\x6d\x9b\x66",
 	.c_size = 104,
+	.enc = "x962",
 	.public_key_vec = true,
 	.siggen_sigver_test = true,
 	}, {
@@ -1067,6 +1081,7 @@ static const struct akcipher_testvec ecdsa_nist_p384_tv_template[] = {
 	"\x5f\x8d\x7a\xf9\xfb\x34\xe4\x8b\x80\xa5\xb6\xda\x2c\x4e\x45\xcf"
 	"\x3c\x93\xff\x50\x5d",
 	.c_size = 101,
+	.enc = "x962",
 	.public_key_vec = true,
 	.siggen_sigver_test = true,
 	},
@@ -1105,6 +1120,7 @@ static const struct akcipher_testvec ecdsa_nist_p521_tv_template[] = {
 	"\x9f\x0e\x64\xcc\xc4\xe8\x43\xd9\x0e\x1c\xad\x22\xda\x82\x00\x35"
 	"\xa3\x50\xb1\xa5\x98\x92\x2a\xa5\x52",
 	.c_size = 137,
+	.enc = "x962",
 	.public_key_vec = true,
 	.siggen_sigver_test = true,
 	},
@@ -1140,6 +1156,7 @@ static const struct akcipher_testvec ecdsa_nist_p521_tv_template[] = {
 	"\x36\x1a\x31\x03\x42\x02\x5f\x50\xf0\xa2\x0d\x1c\x57\x56\x8f\x12"
 	"\xb7\x1d\x91\x55\x38\xb6\xf6\x34\x65\xc7\xbd",
 	.c_size = 139,
+	.enc = "x962",
 	.public_key_vec = true,
 	.siggen_sigver_test = true,
 	},
@@ -1176,6 +1193,7 @@ static const struct akcipher_testvec ecdsa_nist_p521_tv_template[] = {
 	"\xdb\x8a\x0d\x6a\xc3\xf3\x7a\xd1\xfa\xe7\xa7\xe5\x5a\x94\x56\xcf"
 	"\x8f\xb4\x22\xc6\x4f\xab\x2b\x62\xc1\x42\xb1",
 	.c_size = 139,
+	.enc = "x962",
 	.public_key_vec = true,
 	.siggen_sigver_test = true,
 	},
@@ -1213,6 +1231,7 @@ static const struct akcipher_testvec ecdsa_nist_p521_tv_template[] = {
 	"\xc0\xcb\xaa\x00\x55\xbb\x6a\xb4\x73\x00\xd2\x72\x74\x13\x63\x39"
 	"\xa6\xe5\x25\x46\x1e\x77\x44\x78\xe0\xd1\x04",
 	.c_size = 139,
+	.enc = "x962",
 	.public_key_vec = true,
 	.siggen_sigver_test = true,
 	},
-- 
2.43.0


