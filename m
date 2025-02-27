Return-Path: <linux-pci+bounces-22488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E90A47358
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C142188C01F
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 03:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACBD190692;
	Thu, 27 Feb 2025 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="GpwEFAvv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MLSfK1rD"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DAA156230;
	Thu, 27 Feb 2025 03:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625821; cv=none; b=ufgVHqjunJLNJfxM5Vg6rYLyIUa/jW4tn93IxqiizhQR+odx2BAk5NnoEp6W1bCeldzCYT3H7+2E+pWDNCIxQr+8WmVKggi+rIFEoj90R7ButHhw2xNqGJdQDC00ES156+1MJESPcysWQnfM8f8fILVt568DSDFrHtKw36cu99Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625821; c=relaxed/simple;
	bh=lCDrlsJ7HhJkdPJG7tFm1qooclxiQmkLar4cMvx90CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ho5iIbCVYC+d/aM5Ej4iGekFAcQQd5PX8J/Q5Vt63t3gpBVxeKcOzZbylRvqKEeU0rpVm5ToOmchtdhFoaV7Fn5QQKHD7ASX7mUt5MIqswBdbNg+y7MeA4ifDFEVXEnPEybSgMr2tkSQuzrwOsFYPGOpvswhTR7KNArR9EETOK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=GpwEFAvv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MLSfK1rD; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B6CB825401FF;
	Wed, 26 Feb 2025 22:10:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 26 Feb 2025 22:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1740625817; x=1740712217; bh=sJo14WZuKtMDUmj/Mfxd6IPJsbS6o55X
	+TKFuJLW9eY=; b=GpwEFAvvoGDrIOYywA31mz4gIVq0vWfp479GBmoZF+ynk2WN
	tp5hlpjYjBk+Y4PwfxulstMxymyAnk7Wwd6rZ7qoSEhchQZPGXe5hwACbGq9sqXV
	duOnTi2zFn0V4MVV2Qu87IiAY6HMsmb3gGrHzKrz35w+UA4Yt4uxL/7yeFXtYEg9
	Lx/1o+Jg+kOIZQ/pe8v1qd9z7kZcHpxKW6jD250BDVIcjk0QGFgmXVwdfZVbt/um
	PwHMDoEp0wO9G+DG547Lv6HHss9sgP0uyuisv95dpczVB6EztIxAIcTM2ALs1Vyb
	8zMiYguM4GDwArHqFHFJMHqeZMKWE1JQLkXNNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740625817; x=
	1740712217; bh=sJo14WZuKtMDUmj/Mfxd6IPJsbS6o55X+TKFuJLW9eY=; b=M
	LSfK1rDMWvCutLXgsu/lyShqQ/k7vhzuP4tA0c5j5yIvB8f+UlHEnPEW9j4vC0Nj
	uT6Zk2juPrSGvJPT2sDY58l4pJxzdIA2J+/fglzF/frqlHKJ5BZvLSOOQUmNftZE
	v8k7ZVPL6HZQO0Cm/yNIPeMfrj6h1vStPKq6OlB00IdQn2wXH1wIcHpt7OQGF1iK
	WSVQ+EKdJ2ZbdEGvXIVAnVExG0e/18LQfyMOaT/o4R8EJO0RYI44xOOGz+uetj6o
	bidJNM5hsT3+qVbIZSAt2V/umvFhco90K7bXWkqxk0FKIV7XJe/cGsybFs2iaquO
	DbzbM6hyjLqipsgLl+ZjA==
X-ME-Sender: <xms:mde_Z25ALlRcRjtoLTdwC_ivS5eZiaeNMXhyDNuvV2-wFCPMhus8DQ>
    <xme:mde_Z_5e8nZa7fNGU4qgQplIlQuUomL3HY995oPKR4OSUgJmMVT6TtW5SefB7PR8q
    Z4lR8BUaHlUIBqBsKA>
X-ME-Received: <xmr:mde_Z1f-EjSJkX-VrmW7rdDsjNzc0Vt41WojLZxnAAsu1CmOAXm7f6e4t2YHKbMZJqPnP9uL6TM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekieefhecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:mde_ZzLhr2uxxjmbocux3mv9tGZXwhXRf_OT5-c3gjfCeaC0R6FSGQ>
    <xmx:mde_Z6KSkRD5sEapIya5RIUUO_r4WHtra7guQSnvZWy0VHRJ0A_19A>
    <xmx:mde_Z0yX9wEL6MY6b4mgkr8kpmpXBDVkz-WoMIYZvrajggPAASjGrQ>
    <xmx:mde_Z-JEBx30_ZSSjPKf9-5N7t8ZUN8N6I0rOwCywTSb2P3t9ElIUA>
    <xmx:mde_Z64pIgZRNa5aln99dE2uOVFXky4f1WZx4Q3w1vIYXlyvcQ9Pgmmk>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 22:10:11 -0500 (EST)
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
	Alistair Francis <alistair.francis@wdc.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [RFC v2 02/20] X.509: Parse Subject Alternative Name in certificates
Date: Thu, 27 Feb 2025 13:09:34 +1000
Message-ID: <20250227030952.2319050-3-alistair@alistair23.me>
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

Store a pointer to the Subject Alternative Name upon parsing for
consumption by CMA-SPDM.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 9 +++++++++
 include/keys/x509-parser.h                | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index ee2fdab42334..ff1db59d4037 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -572,6 +572,15 @@ int x509_process_extension(void *context, size_t hdrlen,
 		return 0;
 	}
 
+	if (ctx->last_oid == OID_subjectAltName) {
+		if (ctx->cert->raw_san)
+			return -EBADMSG;
+
+		ctx->cert->raw_san = v;
+		ctx->cert->raw_san_size = vlen;
+		return 0;
+	}
+
 	if (ctx->last_oid == OID_keyUsage) {
 		/*
 		 * Get hold of the keyUsage bit string
diff --git a/include/keys/x509-parser.h b/include/keys/x509-parser.h
index 37436a5c7526..8e450befe3b9 100644
--- a/include/keys/x509-parser.h
+++ b/include/keys/x509-parser.h
@@ -36,6 +36,8 @@ struct x509_certificate {
 	unsigned	raw_subject_size;
 	unsigned	raw_skid_size;
 	const void	*raw_skid;		/* Raw subjectKeyId in ASN.1 */
+	const void	*raw_san;		/* Raw subjectAltName in ASN.1 */
+	unsigned	raw_san_size;
 	unsigned	index;
 	bool		seen;			/* Infinite recursion prevention */
 	bool		verified;
-- 
2.48.1


