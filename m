Return-Path: <linux-pci+bounces-22487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022BBA47355
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E6C3B0528
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 03:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC2B187858;
	Thu, 27 Feb 2025 03:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="MzWTCVjW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BZcgZO1y"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F86156230;
	Thu, 27 Feb 2025 03:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625814; cv=none; b=UWCvDVv3HeRM8RfOFWQqh/IABudvTsIMCEa8qWwRgfHWbuDNdQitvjzxWNEbsjZoPuH2ssN4ZD77EddIBg0mCNkh3cvHFK8D/ITY03x/686RvmrD7RR2pgLGw0cxoeJGgkb4sY6bJPqN0rsBiRWGZPF3SuydDqC8OVoATBZZMGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625814; c=relaxed/simple;
	bh=k43xiz5nPDEHKcKEhnYdVXPBz4oVjuFkpTQHDNJTzRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XAB5186fTsb/kLtuoYCMc37StkbOapjPxrt/nxH3xSAuKG4v34kXH9NHRx+3nPv0YAT4OnH8IK6nmOOGPDqsSMTZ+6te7swvnS60kUrcoYuHMuV1V8H8zPaQQq53HTjypM3TvmKR1S0XAAwpq0C6yYfbL/v589Suezmyqrvo1p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=MzWTCVjW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BZcgZO1y; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4536625401FB;
	Wed, 26 Feb 2025 22:10:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 26 Feb 2025 22:10:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1740625810; x=1740712210; bh=hQUTYfWHalwJSgp8IozZ6vtvcxBd5eNM
	NXlU+aNvLgQ=; b=MzWTCVjW8lNLUm3l4gcm89D4RuXx8d26DhzAPtZ5didTRDXd
	/h5/HZ2rD3bYyv82Z6yW0EgBzKcM6THSBtNL4iCPEJfzFE3zgug+7yBeCeu3Dfb3
	29vQwY4deaEY9ktLdKSd2QM4/5M8ddBhk0KS5gkSaJIhU+qt+dqOXvfY+s+snCJy
	WUw9iuzdyrjniB0AfD3ug4HgA7cWCSSoKl/S9hzu4K3JnW7WLa1UFwSm6t8jj3Qj
	E63EuipL6opTvOq0FE5wvJSxO83y/YjYTADvcy1JlaEayW3kxF/aZhPyWejzdX1M
	ZlESip6gQ4TF9YFVsJilIDW370qgWBVBt6M6+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740625810; x=
	1740712210; bh=hQUTYfWHalwJSgp8IozZ6vtvcxBd5eNMNXlU+aNvLgQ=; b=B
	ZcgZO1yNcUf1UYM/CLMWtxof5+33l6GcYlhzP2cX12tn9N0imTqj0JbMfiqZ2AGD
	SZz/pysw3qUYCcvxTuMGICIcs98miYos3Pyu6JThCPwQO+22kbIhFKfm1lpKVgbH
	ncDiQSLAduWqsv8v3gy6YXj0omBSXkbG+J158aud/sDUDDkLnZTGo00rCPoIpcmN
	MnunK+c7vKKad4dfk8uqtGNWGdAUZVAcpuWuWU08kj6oHvaQRblGC1YB6x2ul9Pj
	eSDr1e10lyYP6w32+msB+dq0ROIVEzo4ft2pD9fMNJADKVKqr0NsCmkZJg1o/z5a
	bEDLyCYraM034nVspkUWA==
X-ME-Sender: <xms:kde_Z3Ilt6bB2FwUkXoIpP-t8k8fzAKxfLfPR7LdmUisZHG84y3gjA>
    <xme:kde_Z7J5rTDEQMMBuaIsA0PxCbPso2KNtSJzNtejKHxUqaXZIdyN0o2EnEXqBHgOi
    ep5hLFtNUdt-Pi588A>
X-ME-Received: <xmr:kde_Z_sUqxjW3QNI-9EEYpVhnGpJsFKDk7_hissckmyEYJDBrYWqru2bHv6HvIzceAG2USRHiCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekieefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenogfuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhep
    hffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeetlhhishhtrghirh
    cuhfhrrghntghishcuoegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgeqnecu
    ggftrfgrthhtvghrnhepudefveevheeuffdttdfftddtgfekjedvvdetgeehtdeugfehvd
    duudeiudeffeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvpdhnsggprhgtphhtth
    hopedvvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqtgiglhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsseifuhhnnhgv
    rhdruggvpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepjhhonhgrthhhrghnrdgtrghmvghrohhnsehhuhgrfigvihdrtghomhdprhgtphhtth
    hopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpth
    htohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:kde_Zwbd-HtI5ioUHnDZkqVh5DANmjrPqLmv8cxO8Vto7IHyue4HdQ>
    <xmx:kde_Z-ZDVZHtRWUxLegypROWlYMBPFftJGbOAtNQqKq3VzetiI8x9Q>
    <xmx:kde_Z0ApPQmj0EdgwsbrDGXL-dnHl6ubB5uX910V8hW2FKqxMjBI7A>
    <xmx:kde_Z8aht9u5InKSLKl9kSmNMvFsblcP_CXeqCglqbT3r498k-xO3w>
    <xmx:kte_Z7LgtXvx_nXW-93QhBrNarOMpGPSElc1EkaAWxYQDZYzgykPbYNO>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 22:10:03 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lukas@wunner.de,
	linux-pci@vger.kernel.org,
	bhelgaas@google.com,
	Jonathan.Cameron@huawei.com,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org
Cc: boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	ojeda@kernel.org,
	alistair23@gmail.com,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	gary@garyguo.net,
	alex.gaynor@gmail.com,
	benno.lossin@proton.me,
	Dan Williams <dan.j.williams@intel.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [RFC v2 01/20] X.509: Make certificate parser public
Date: Thu, 27 Feb 2025 13:09:33 +1000
Message-ID: <20250227030952.2319050-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227030952.2319050-1-alistair@alistair23.me>
References: <20250227030952.2319050-1-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

The upcoming support for PCI device authentication with CMA-SPDM
(PCIe r6.1 sec 6.31) requires validating the Subject Alternative Name
in X.509 certificates.

High-level functions for X.509 parsing such as key_create_or_update()
throw away the internal, low-level struct x509_certificate after
extracting the struct public_key and public_key_signature from it.
The Subject Alternative Name is thus inaccessible when using those
functions.

Afford CMA-SPDM access to the Subject Alternative Name by making struct
x509_certificate public, together with the functions for parsing an
X.509 certificate into such a struct and freeing such a struct.

The private header file x509_parser.h previously included <linux/time.h>
for the definition of time64_t.  That definition was since moved to
<linux/time64.h> by commit 361a3bf00582 ("time64: Add time64.h header
and define struct timespec64"), so adjust the #include directive as part
of the move to the new public header file <keys/x509-parser.h>.

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 crypto/asymmetric_keys/x509_parser.h | 40 +--------------------
 include/keys/x509-parser.h           | 53 ++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 39 deletions(-)
 create mode 100644 include/keys/x509-parser.h

diff --git a/crypto/asymmetric_keys/x509_parser.h b/crypto/asymmetric_keys/x509_parser.h
index 0688c222806b..39f1521b773d 100644
--- a/crypto/asymmetric_keys/x509_parser.h
+++ b/crypto/asymmetric_keys/x509_parser.h
@@ -5,49 +5,11 @@
  * Written by David Howells (dhowells@redhat.com)
  */
 
-#include <linux/cleanup.h>
-#include <linux/time.h>
-#include <crypto/public_key.h>
-#include <keys/asymmetric-type.h>
-
-struct x509_certificate {
-	struct x509_certificate *next;
-	struct x509_certificate *signer;	/* Certificate that signed this one */
-	struct public_key *pub;			/* Public key details */
-	struct public_key_signature *sig;	/* Signature parameters */
-	char		*issuer;		/* Name of certificate issuer */
-	char		*subject;		/* Name of certificate subject */
-	struct asymmetric_key_id *id;		/* Issuer + Serial number */
-	struct asymmetric_key_id *skid;		/* Subject + subjectKeyId (optional) */
-	time64_t	valid_from;
-	time64_t	valid_to;
-	const void	*tbs;			/* Signed data */
-	unsigned	tbs_size;		/* Size of signed data */
-	unsigned	raw_sig_size;		/* Size of signature */
-	const void	*raw_sig;		/* Signature data */
-	const void	*raw_serial;		/* Raw serial number in ASN.1 */
-	unsigned	raw_serial_size;
-	unsigned	raw_issuer_size;
-	const void	*raw_issuer;		/* Raw issuer name in ASN.1 */
-	const void	*raw_subject;		/* Raw subject name in ASN.1 */
-	unsigned	raw_subject_size;
-	unsigned	raw_skid_size;
-	const void	*raw_skid;		/* Raw subjectKeyId in ASN.1 */
-	unsigned	index;
-	bool		seen;			/* Infinite recursion prevention */
-	bool		verified;
-	bool		self_signed;		/* T if self-signed (check unsupported_sig too) */
-	bool		unsupported_sig;	/* T if signature uses unsupported crypto */
-	bool		blacklisted;
-};
+#include <keys/x509-parser.h>
 
 /*
  * x509_cert_parser.c
  */
-extern void x509_free_certificate(struct x509_certificate *cert);
-DEFINE_FREE(x509_free_certificate, struct x509_certificate *,
-	    if (!IS_ERR(_T)) x509_free_certificate(_T))
-extern struct x509_certificate *x509_cert_parse(const void *data, size_t datalen);
 extern int x509_decode_time(time64_t *_t,  size_t hdrlen,
 			    unsigned char tag,
 			    const unsigned char *value, size_t vlen);
diff --git a/include/keys/x509-parser.h b/include/keys/x509-parser.h
new file mode 100644
index 000000000000..37436a5c7526
--- /dev/null
+++ b/include/keys/x509-parser.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* X.509 certificate parser
+ *
+ * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#ifndef _KEYS_X509_PARSER_H
+#define _KEYS_X509_PARSER_H
+
+#include <crypto/public_key.h>
+#include <keys/asymmetric-type.h>
+#include <linux/cleanup.h>
+#include <linux/time64.h>
+
+struct x509_certificate {
+	struct x509_certificate *next;
+	struct x509_certificate *signer;	/* Certificate that signed this one */
+	struct public_key *pub;			/* Public key details */
+	struct public_key_signature *sig;	/* Signature parameters */
+	char		*issuer;		/* Name of certificate issuer */
+	char		*subject;		/* Name of certificate subject */
+	struct asymmetric_key_id *id;		/* Issuer + Serial number */
+	struct asymmetric_key_id *skid;		/* Subject + subjectKeyId (optional) */
+	time64_t	valid_from;
+	time64_t	valid_to;
+	const void	*tbs;			/* Signed data */
+	unsigned	tbs_size;		/* Size of signed data */
+	unsigned	raw_sig_size;		/* Size of signature */
+	const void	*raw_sig;		/* Signature data */
+	const void	*raw_serial;		/* Raw serial number in ASN.1 */
+	unsigned	raw_serial_size;
+	unsigned	raw_issuer_size;
+	const void	*raw_issuer;		/* Raw issuer name in ASN.1 */
+	const void	*raw_subject;		/* Raw subject name in ASN.1 */
+	unsigned	raw_subject_size;
+	unsigned	raw_skid_size;
+	const void	*raw_skid;		/* Raw subjectKeyId in ASN.1 */
+	unsigned	index;
+	bool		seen;			/* Infinite recursion prevention */
+	bool		verified;
+	bool		self_signed;		/* T if self-signed (check unsupported_sig too) */
+	bool		unsupported_sig;	/* T if signature uses unsupported crypto */
+	bool		blacklisted;
+};
+
+struct x509_certificate *x509_cert_parse(const void *data, size_t datalen);
+void x509_free_certificate(struct x509_certificate *cert);
+
+DEFINE_FREE(x509_free_certificate, struct x509_certificate *,
+	    if (!IS_ERR(_T)) x509_free_certificate(_T))
+
+#endif /* _KEYS_X509_PARSER_H */
-- 
2.48.1


