Return-Path: <linux-pci+bounces-9472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FD091D3BE
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 22:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510B21F212E2
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 20:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D03136664;
	Sun, 30 Jun 2024 20:06:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61539381D4;
	Sun, 30 Jun 2024 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719777973; cv=none; b=EvgHc/YAHwAHyfirNXSIWVdt5dunUJxQiAvQJYnoSoiBpCFdOnCbC4MlmvVkCN4KMpsVV6+qRd9IhVU/yBzzKLT/UdSbY13Q2zh8f0QPMDVt04PhhsMMyiIRhHEQpadL/EeEsTbuT8XNAa4Rj++cOnbdXvM6AimB6NY4F1TL7eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719777973; c=relaxed/simple;
	bh=nvGEND9KU89YKufo1/pGPmKcXCfuL8qc5gLyP6nqFXs=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=JjozJoERp0R+xOD4+uDEtIDvN8ghbF7PLLQtvAR5z1MST2SK725dzdhjMIRQl07BYhydfZ+einZIQHcEpZ6KJ/UdkAvyncafHtD0o2LKgYBwgBSeD6l9j0+xDC4ZYDLak4/WP17v/MRM09Um9D7KumfB2hdG0lK2YmzOvKqIkq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 68A2610190FA3;
	Sun, 30 Jun 2024 22:06:08 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 3E23B61DA805;
	Sun, 30 Jun 2024 22:06:08 +0200 (CEST)
X-Mailbox-Line: From 70fb69d212a54ff4828e5be6d0b3d04f1170464d Mon Sep 17 00:00:00 2001
Message-ID: <70fb69d212a54ff4828e5be6d0b3d04f1170464d.1719771133.git.lukas@wunner.de>
In-Reply-To: <cover.1719771133.git.lukas@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 30 Jun 2024 21:40:00 +0200
Subject: [PATCH v2 05/18] crypto: akcipher - Support more than one signature
 encoding
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Cc: <linuxarm@huawei.com>, David Box <david.e.box@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Li, Ming" <ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Alistair Francis <alistair.francis@wdc.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, "Damien Le Moal" <dlemoal@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>, Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>, Sean Christopherson <seanjc@google.com>, Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>, Eric Biggers <ebiggers@google.com>, Stefan Berger <stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Currently only a single default signature encoding is supported per
akcipher.

A subsequent commit will allow a second encoding for ecdsa, namely P1363
alternatively to X9.62.

To accommodate for that, amend struct akcipher_request and struct
crypto_akcipher_sync_data to store the desired signature encoding for
verify and sign ops.

Amend akcipher_request_set_crypt(), crypto_sig_verify() and
crypto_sig_sign() with an additional parameter which specifies the
desired signature encoding.  Adjust all callers.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 crypto/akcipher.c                   |  2 +-
 crypto/asymmetric_keys/public_key.c |  4 ++--
 crypto/internal.h                   |  1 +
 crypto/rsa-pkcs1pad.c               | 11 +++++++----
 crypto/sig.c                        |  6 ++++--
 crypto/testmgr.c                    |  8 +++++---
 crypto/testmgr.h                    |  1 +
 include/crypto/akcipher.h           | 10 +++++++++-
 include/crypto/sig.h                |  6 ++++--
 9 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/crypto/akcipher.c b/crypto/akcipher.c
index e0ff5f4dda6d..785848590606 100644
--- a/crypto/akcipher.c
+++ b/crypto/akcipher.c
@@ -190,7 +190,7 @@ int crypto_akcipher_sync_prep(struct crypto_akcipher_sync_data *data)
 	sg = &data->sg;
 	sg_init_one(sg, buf, mlen);
 	akcipher_request_set_crypt(req, sg, data->dst ? sg : NULL,
-				   data->slen, data->dlen);
+				   data->slen, data->dlen, data->enc);
 
 	crypto_init_wait(&data->cwait);
 	akcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP,
diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index 3474fb34ded9..00f70835359f 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -368,7 +368,7 @@ static int software_key_eds_op(struct kernel_pkey_params *params,
 		if (!issig)
 			break;
 		ret = crypto_sig_sign(sig, in, params->in_len,
-				      out, params->out_len);
+				      out, params->out_len, params->encoding);
 		break;
 	default:
 		BUG();
@@ -452,7 +452,7 @@ int public_key_verify_signature(const struct public_key *pkey,
 		goto error_free_key;
 
 	ret = crypto_sig_verify(tfm, sig->s, sig->s_size,
-				sig->digest, sig->digest_size);
+				sig->digest, sig->digest_size, sig->encoding);
 
 error_free_key:
 	kfree_sensitive(key);
diff --git a/crypto/internal.h b/crypto/internal.h
index 63e59240d5fb..268315b13ccd 100644
--- a/crypto/internal.h
+++ b/crypto/internal.h
@@ -41,6 +41,7 @@ struct crypto_akcipher_sync_data {
 	void *dst;
 	unsigned int slen;
 	unsigned int dlen;
+	const char *enc;
 
 	struct akcipher_request *req;
 	struct crypto_wait cwait;
diff --git a/crypto/rsa-pkcs1pad.c b/crypto/rsa-pkcs1pad.c
index cd501195f34a..c8aa68511849 100644
--- a/crypto/rsa-pkcs1pad.c
+++ b/crypto/rsa-pkcs1pad.c
@@ -285,7 +285,8 @@ static int pkcs1pad_encrypt(struct akcipher_request *req)
 
 	/* Reuse output buffer */
 	akcipher_request_set_crypt(&req_ctx->child_req, req_ctx->in_sg,
-				   req->dst, ctx->key_size - 1, req->dst_len);
+				   req->dst, ctx->key_size - 1, req->dst_len,
+				   NULL);
 
 	err = crypto_akcipher_encrypt(&req_ctx->child_req);
 	if (err != -EINPROGRESS && err != -EBUSY)
@@ -385,7 +386,7 @@ static int pkcs1pad_decrypt(struct akcipher_request *req)
 	/* Reuse input buffer, output to a new buffer */
 	akcipher_request_set_crypt(&req_ctx->child_req, req->src,
 				   req_ctx->out_sg, req->src_len,
-				   ctx->key_size);
+				   ctx->key_size, NULL);
 
 	err = crypto_akcipher_decrypt(&req_ctx->child_req);
 	if (err != -EINPROGRESS && err != -EBUSY)
@@ -442,7 +443,8 @@ static int pkcs1pad_sign(struct akcipher_request *req)
 
 	/* Reuse output buffer */
 	akcipher_request_set_crypt(&req_ctx->child_req, req_ctx->in_sg,
-				   req->dst, ctx->key_size - 1, req->dst_len);
+				   req->dst, ctx->key_size - 1, req->dst_len,
+				   req->enc);
 
 	err = crypto_akcipher_decrypt(&req_ctx->child_req);
 	if (err != -EINPROGRESS && err != -EBUSY)
@@ -574,7 +576,8 @@ static int pkcs1pad_verify(struct akcipher_request *req)
 
 	/* Reuse input buffer, output to a new buffer */
 	akcipher_request_set_crypt(&req_ctx->child_req, req->src,
-				   req_ctx->out_sg, sig_size, ctx->key_size);
+				   req_ctx->out_sg, sig_size, ctx->key_size,
+				   req->enc);
 
 	err = crypto_akcipher_encrypt(&req_ctx->child_req);
 	if (err != -EINPROGRESS && err != -EBUSY)
diff --git a/crypto/sig.c b/crypto/sig.c
index 7645bedf3a1f..79f6d4e92447 100644
--- a/crypto/sig.c
+++ b/crypto/sig.c
@@ -76,7 +76,7 @@ EXPORT_SYMBOL_GPL(crypto_sig_maxsize);
 
 int crypto_sig_sign(struct crypto_sig *tfm,
 		    const void *src, unsigned int slen,
-		    void *dst, unsigned int dlen)
+		    void *dst, unsigned int dlen, const char *enc)
 {
 	struct crypto_akcipher **ctx = crypto_sig_ctx(tfm);
 	struct crypto_akcipher_sync_data data = {
@@ -85,6 +85,7 @@ int crypto_sig_sign(struct crypto_sig *tfm,
 		.dst = dst,
 		.slen = slen,
 		.dlen = dlen,
+		.enc = enc,
 	};
 
 	return crypto_akcipher_sync_prep(&data) ?:
@@ -95,7 +96,7 @@ EXPORT_SYMBOL_GPL(crypto_sig_sign);
 
 int crypto_sig_verify(struct crypto_sig *tfm,
 		      const void *src, unsigned int slen,
-		      const void *digest, unsigned int dlen)
+		      const void *digest, unsigned int dlen, const char *enc)
 {
 	struct crypto_akcipher **ctx = crypto_sig_ctx(tfm);
 	struct crypto_akcipher_sync_data data = {
@@ -103,6 +104,7 @@ int crypto_sig_verify(struct crypto_sig *tfm,
 		.src = src,
 		.slen = slen,
 		.dlen = dlen,
+		.enc = enc,
 	};
 	int err;
 
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 00f5a6cf341a..20148c8b25a0 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4150,11 +4150,12 @@ static int test_akcipher_one(struct crypto_akcipher *tfm,
 			goto free_all;
 		memcpy(xbuf[1], c, c_size);
 		sg_set_buf(&src_tab[2], xbuf[1], c_size);
-		akcipher_request_set_crypt(req, src_tab, NULL, m_size, c_size);
+		akcipher_request_set_crypt(req, src_tab, NULL, m_size, c_size,
+					   vecs->enc);
 	} else {
 		sg_init_one(&dst, outbuf_enc, out_len_max);
 		akcipher_request_set_crypt(req, src_tab, &dst, m_size,
-					   out_len_max);
+					   out_len_max, NULL);
 	}
 	akcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
 				      crypto_req_done, &wait);
@@ -4213,7 +4214,8 @@ static int test_akcipher_one(struct crypto_akcipher *tfm,
 	sg_init_one(&src, xbuf[0], c_size);
 	sg_init_one(&dst, outbuf_dec, out_len_max);
 	crypto_init_wait(&wait);
-	akcipher_request_set_crypt(req, &src, &dst, c_size, out_len_max);
+	akcipher_request_set_crypt(req, &src, &dst, c_size, out_len_max,
+				   vecs->enc);
 
 	err = crypto_wait_req(vecs->siggen_sigver_test ?
 			      /* Run asymmetric signature generation */
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 5350cfd9d325..7e34e3f871a3 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -153,6 +153,7 @@ struct akcipher_testvec {
 	const unsigned char *params;
 	const unsigned char *m;
 	const unsigned char *c;
+	const char *enc;
 	unsigned int key_len;
 	unsigned int param_len;
 	unsigned int m_size;
diff --git a/include/crypto/akcipher.h b/include/crypto/akcipher.h
index 18a10cad07aa..2c2bc19d657f 100644
--- a/include/crypto/akcipher.h
+++ b/include/crypto/akcipher.h
@@ -30,6 +30,8 @@
  *		In case of error where the dst sgl size was insufficient,
  *		it will be updated to the size required for the operation.
  *		For verify op this is size of digest part in @src.
+ * @enc:	For verify op it's the encoding of the signature part of @src.
+ *		For sign op it's the encoding of the signature in @dst.
  * @__ctx:	Start of private context data
  */
 struct akcipher_request {
@@ -38,6 +40,7 @@ struct akcipher_request {
 	struct scatterlist *dst;
 	unsigned int src_len;
 	unsigned int dst_len;
+	const char *enc;
 	void *__ctx[] CRYPTO_MINALIGN_ATTR;
 };
 
@@ -247,17 +250,22 @@ static inline void akcipher_request_set_callback(struct akcipher_request *req,
  * @src_len:	size of the src input scatter list to be processed
  * @dst_len:	size of the dst output scatter list or size of signature
  *		portion in @src for verify op
+ * @enc:	encoding of signature portion in @src for verify op,
+ *		encoding of signature in @dst for sign op,
+ *		NULL for encrypt and decrypt op
  */
 static inline void akcipher_request_set_crypt(struct akcipher_request *req,
 					      struct scatterlist *src,
 					      struct scatterlist *dst,
 					      unsigned int src_len,
-					      unsigned int dst_len)
+					      unsigned int dst_len,
+					      const char *enc)
 {
 	req->src = src;
 	req->dst = dst;
 	req->src_len = src_len;
 	req->dst_len = dst_len;
+	req->enc = enc;
 }
 
 /**
diff --git a/include/crypto/sig.h b/include/crypto/sig.h
index d25186bb2be3..4081029ecc97 100644
--- a/include/crypto/sig.h
+++ b/include/crypto/sig.h
@@ -81,12 +81,13 @@ int crypto_sig_maxsize(struct crypto_sig *tfm);
  * @slen:	source length
  * @dst:	destination obuffer
  * @dlen:	destination length
+ * @enc:	signature encoding
  *
  * Return: zero on success; error code in case of error
  */
 int crypto_sig_sign(struct crypto_sig *tfm,
 		    const void *src, unsigned int slen,
-		    void *dst, unsigned int dlen);
+		    void *dst, unsigned int dlen, const char *enc);
 
 /**
  * crypto_sig_verify() - Invoke signature verification
@@ -99,12 +100,13 @@ int crypto_sig_sign(struct crypto_sig *tfm,
  * @slen:	source length
  * @digest:	digest
  * @dlen:	digest length
+ * @enc:	signature encoding
  *
  * Return: zero on verification success; error code in case of error.
  */
 int crypto_sig_verify(struct crypto_sig *tfm,
 		      const void *src, unsigned int slen,
-		      const void *digest, unsigned int dlen);
+		      const void *digest, unsigned int dlen, const char *enc);
 
 /**
  * crypto_sig_set_pubkey() - Invoke set public key operation
-- 
2.43.0


