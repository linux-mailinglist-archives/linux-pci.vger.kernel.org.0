Return-Path: <linux-pci+bounces-22489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FC8A4735A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBEE5188E713
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 03:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCE7156230;
	Thu, 27 Feb 2025 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="Bm65ZSrF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y9gm5yV0"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A427182BD;
	Thu, 27 Feb 2025 03:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625828; cv=none; b=kyJXVtNiY6g7JBOM/86EoWyNWoR3pagNSQX12Ocgi0AMSAxdIR26W90V8JUAtpR5oqKpZVlYyw9VcrxuZe50y9m2xO0iaffcKcgn7cX7i2k2AN5o3HBvIhsGc2QiNcvGjeRHdW8fyBTBaPWI9YPoaVwY2/Tc6xwOBMwGoJnwGnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625828; c=relaxed/simple;
	bh=J0tzL8AvUlaJe55f+04+0KFIyGOTUTniwM5YasfexrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1vhKMU7CwKDZKzrWWx25mQuJV2NftLhIEnp03N18J75rwHj7szMcD5btu/TEk3pJrFYohZHUjneMYVmlCjxqSn86/zghdnMvHFBvjLJ2/3z/JGNR7AjsVn9UuAcBRdMv6SqkHKrL3DnZaGsoFRxpmHeCxD7lyk5UuPO9I7kS0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=Bm65ZSrF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y9gm5yV0; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.stl.internal (Postfix) with ESMTP id 13EA8114017B;
	Wed, 26 Feb 2025 22:10:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Wed, 26 Feb 2025 22:10:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1740625824; x=
	1740712224; bh=OOIx/3ju4JUTdg4HPClHZfHz0j8GooiHo98R2k5DRgo=; b=B
	m65ZSrFc7m+xbba2gV7s/vZgMEkbR/OQ78IBWPzXXQwLbdhWyppfQUuKAezhQhyQ
	6yPhtl0Pv//mmeIcTVgciOzVc9n38GvyvFTPk+Sl9sLT3cbop4wDgnAwmernALBo
	mJ0oHEXe1H8UsXBZ7RNApb4Lwskzclcc68mDLM2qdItA4bJIpSStJU4fN3stXQGI
	Z+KPKOFRyOrvNtDlp1ZciIwY+BXqIu1/UvcKF8fJ6LhPVN6BU28nVBZyZ7o/G6jU
	TbxqEoI0MP1lQJ0icR6NjzbB9bz5iMg+q5SsHekOH/gC+pnqSNLAM+q3wNPqkDsU
	PG5zqwq6VUCMpf/3qUjLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1740625824; x=1740712224; bh=O
	OIx/3ju4JUTdg4HPClHZfHz0j8GooiHo98R2k5DRgo=; b=Y9gm5yV0YiQyv3wK4
	X7nQ17Lg43y0lRNh7dqfx2K+2w8Ck68WV3NGGJETKchiBiDynYXwFEkhH9eUDWuF
	oVG2FNPK0EAfkmeHsR/OyHEc6ipJreuII3268rh8rV4EO3XTL/lirvfH2iI9qIyW
	PtChjHTo95TOruTYx6AtxowW/8t7XmtVA4dVqjVAbJfLfMAAs53BTtx8uwExq9Bb
	e59bdLqhahwBeAakvKm5lM33C5GeiP8zSLVwQfw3QxgglFevtQC1+u9l0wVt/LJ0
	XKLoOHxT006bNSGwFGogSO6IQDq4Ftt3UTH68bh5UmOz8nl/Mjap5SX+l5DB+NkD
	Vf3vw==
X-ME-Sender: <xms:oNe_Z4adlLun0dscObM6mJRZEysPss1T7twQ6YFr2gFnb8OziI22Zw>
    <xme:oNe_ZzaSSxerACPKtiNoe3DEUgAJlfxuwKae9nMI-_vZ8OWkOOklGTofiwzRe6W2P
    jKVRk26UiXDfFvuoYI>
X-ME-Received: <xmr:oNe_Zy8dsmXuoNwtcB5OI-aZYLOqNAnBRKSDBYaP1sclxAFEPT3kVMZ3wTCV1gP0t2yNAjJ5jq4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekieefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenogfuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhep
    hffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihhsthgrihhruc
    fhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucgg
    tffrrghtthgvrhhnpedutddvffeklefhgfefueegiefhkedujedttddukeeiueduudfhtd
    dtfeefveeghfenucffohhmrghinhepughmthhfrdhorhhgnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrg
    hirhdvfedrmhgvpdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheplhhinhhugidqtgiglhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehluhhkrghsseifuhhnnhgvrhdruggvpdhrtghpthhtoheplhhinhhugidqph
    gtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegshhgvlhhgrggrshes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnrdgtrghmvghrohhnse
    hhuhgrfigvihdrtghomhdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouh
    hnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:oNe_ZyoTRkEpvbKUTDpC3i_w3QrQcfzNoQ9DtmntVYGkBbQ_YZkSHw>
    <xmx:oNe_ZzqpCRNr7edHO-IDHilvRrS1RIdsDR2Bc3nw9OpXb5NHC2P2Fw>
    <xmx:oNe_ZwTGhZctrDQ5RhdmheBQf_cffIkqLaxpe-zEKaG_8mh00U-LMA>
    <xmx:oNe_Zzp5Kipth48eIRqOpcsiFSdtEYRbrF1aKD1W9eUfBATTe4nEJA>
    <xmx:oNe_Z_BeJIoXGv9TZHhB_y--ZNjw1ELunm2XLZSgxk2nzxDWp7cdKQ_M>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 22:10:18 -0500 (EST)
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
	Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC v2 03/20] X.509: Move certificate length retrieval into new helper
Date: Thu, 27 Feb 2025 13:09:35 +1000
Message-ID: <20250227030952.2319050-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227030952.2319050-1-alistair@alistair23.me>
References: <20250227030952.2319050-1-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

The upcoming in-kernel SPDM library (Security Protocol and Data Model,
https://www.dmtf.org/dsp/DSP0274) needs to retrieve the length from
ASN.1 DER-encoded X.509 certificates.

Such code already exists in x509_load_certificate_list(), so move it
into a new helper for reuse by SPDM.

Export the helper so that SPDM can be tristate.  (Some upcoming users of
the SPDM libray may be modular, such as SCSI and ATA.)

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 crypto/asymmetric_keys/x509_loader.c | 38 +++++++++++++++++++---------
 include/keys/asymmetric-type.h       |  2 ++
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/crypto/asymmetric_keys/x509_loader.c b/crypto/asymmetric_keys/x509_loader.c
index a41741326998..25ff027fad1d 100644
--- a/crypto/asymmetric_keys/x509_loader.c
+++ b/crypto/asymmetric_keys/x509_loader.c
@@ -4,28 +4,42 @@
 #include <linux/key.h>
 #include <keys/asymmetric-type.h>
 
+ssize_t x509_get_certificate_length(const u8 *p, unsigned long buflen)
+{
+	ssize_t plen;
+
+	/* Each cert begins with an ASN.1 SEQUENCE tag and must be more
+	 * than 256 bytes in size.
+	 */
+	if (buflen < 4)
+		return -EINVAL;
+
+	if (p[0] != 0x30 &&
+	    p[1] != 0x82)
+		return -EINVAL;
+
+	plen = (p[2] << 8) | p[3];
+	plen += 4;
+	if (plen > buflen)
+		return -EINVAL;
+
+	return plen;
+}
+EXPORT_SYMBOL_GPL(x509_get_certificate_length);
+
 int x509_load_certificate_list(const u8 cert_list[],
 			       const unsigned long list_size,
 			       const struct key *keyring)
 {
 	key_ref_t key;
 	const u8 *p, *end;
-	size_t plen;
+	ssize_t plen;
 
 	p = cert_list;
 	end = p + list_size;
 	while (p < end) {
-		/* Each cert begins with an ASN.1 SEQUENCE tag and must be more
-		 * than 256 bytes in size.
-		 */
-		if (end - p < 4)
-			goto dodgy_cert;
-		if (p[0] != 0x30 &&
-		    p[1] != 0x82)
-			goto dodgy_cert;
-		plen = (p[2] << 8) | p[3];
-		plen += 4;
-		if (plen > end - p)
+		plen = x509_get_certificate_length(p, end - p);
+		if (plen < 0)
 			goto dodgy_cert;
 
 		key = key_create_or_update(make_key_ref(keyring, 1),
diff --git a/include/keys/asymmetric-type.h b/include/keys/asymmetric-type.h
index 69a13e1e5b2e..e2af07fec3c6 100644
--- a/include/keys/asymmetric-type.h
+++ b/include/keys/asymmetric-type.h
@@ -84,6 +84,8 @@ extern struct key *find_asymmetric_key(struct key *keyring,
 				       const struct asymmetric_key_id *id_2,
 				       bool partial);
 
+ssize_t x509_get_certificate_length(const u8 *p, unsigned long buflen);
+
 int x509_load_certificate_list(const u8 cert_list[], const unsigned long list_size,
 			       const struct key *keyring);
 
-- 
2.48.1


