Return-Path: <linux-pci+bounces-22490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F09A4735C
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21787188E413
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 03:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9369018FDD2;
	Thu, 27 Feb 2025 03:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="WtILr1YJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oNjAUHsA"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01F1182BD;
	Thu, 27 Feb 2025 03:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625837; cv=none; b=Ey8kA7GU/ngjoFMJbJr38C6HTW6YAASxFo/hIje3km9SL07O/fTTOY/QyKc4aMQ4j+md/I2XJhbfhgSZl1r/heFbb5cGhekXgdehPU0DLOOCRsZMiecPaoJDTXL5NxOGQ9wl4+yoo3Q2QisBbucy69lnJloBvLzZ3BJVX5izh/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625837; c=relaxed/simple;
	bh=fNsLaSxDRLFdd3ko7FdqXCu+VNEYbma2oV2sbAhJCSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9+v0cI0yd9OWPrYfmmmysJCLHVy/xyLRErNUCgD0XfV5o0mGcMa6G0+DwsRew5Qdbt5ICSnrv7RNQBXJr0AFxF08ZrkjWFuZC4XR/hraHHWHpmglxBKKGymrt6BxS8wZXJtDWBWOlj8omZnn1GIDpEiVNgyRmm/b/zUWIV5u2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=WtILr1YJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oNjAUHsA; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 827AC2540202;
	Wed, 26 Feb 2025 22:10:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 26 Feb 2025 22:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1740625833; x=1740712233; bh=yMsEzbS3O6lUSMvQC5PcLR6pxn0YYtsN
	YDDhxRiwg6o=; b=WtILr1YJd7SMRdEfow8V3FpBolBQYIRvJKr1pjt8EUCAIxJ7
	Xb98Jr9p7XDIltjgB/2CUIiFSJXEseaVcP9xt5wnqCFyuRN/t0RbE70DGn9cqceK
	F8Wq78YcDooZfh3xS0+LV/3iumf4RjH+1GT5/fetLmF1Li+pc5tn/4t3PhtOQNF4
	K5D+y7MULf3TmIrFvNqLDtNftPQRfSr8UwYekSZUHTE14LrHlkdrpyND5gybQvrT
	a4bHlu4t8cRwtXWlGEm23JhDoNXt5z/NY/7cuYFuMe/bw6oLYf/tAWRoFWlyHes/
	JBMxdmeyZgpO5BvrEeuF6UjKnCierQOXXZxSyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740625833; x=
	1740712233; bh=yMsEzbS3O6lUSMvQC5PcLR6pxn0YYtsNYDDhxRiwg6o=; b=o
	NjAUHsAE7i6No2qZP33a0Z74GX3ADD993Ewh/glZwqwj9ZG5sOR2yKqYu5xstNYg
	nTPrhl7L0VET0T/kVsyDC8IQgs2s11VJ5EMRsnV7ldwyjHCfEIgRXWfdVJn2eRPt
	WSSqCnDqMOET2WqoxDmO0PIElqloUcHpS75PE5p1tvq9i+6dURdQ4KPtIlF1FTaW
	I53kj6vY+F3/f0278jyVK32XOfJfCLbGHqyxoikPORawLOb76iAija0uRScwDWZc
	EvZCTntHLl/S2L0gqWDIjHS+Ecc6wYwaOrxs8zxG6iNp9nmV8HnimKumyw8YcrVO
	DG1rsSNu08yCp2Zrp9qkQ==
X-ME-Sender: <xms:qNe_Zw9KjQug7tUPO9mJFaaB0w3WVpryS8FApIjG_FnURqRF_qEbkg>
    <xme:qNe_Z4sefGvCMzfZrzL74LpdZsQ4ac1xMoFWfTz3jqH7kLzjCE97i89VkyzcbgMtF
    G3UPbGz0liSpo2bSig>
X-ME-Received: <xmr:qNe_Z2A7zvAu1VSqP4hpVMYkylBE_OmlvKVn1BJ3potrC-qrumALX-byBjTQpIveobJqPsgmx5M>
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
X-ME-Proxy: <xmx:qNe_Zwf0ihIgtg04ZlQXAacvrkUzwzzewF3n5qnE3y4FqZhkN5DHUw>
    <xmx:qNe_Z1P1HwG-GqP7GOQjVsBirlg7Cme8Jb4YbnBqnDSKng-jOlS-JA>
    <xmx:qNe_Z6mibtSq7cxd6AZXiGC1sIz_OuTktfsdZ56S5dI3Onys1NW5CA>
    <xmx:qNe_Z3upqM3sVX5F6zug3Mzf3SsMHza6h1UbrGdSuXtsKjCrjeRLpQ>
    <xmx:qde_Z8-X082xE1kmT8N_-uFNOAxxKtfgUIyTtHrArIR5upsgsAKxY3Mr>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 22:10:25 -0500 (EST)
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
Subject: [RFC v2 04/20] certs: Create blacklist keyring earlier
Date: Thu, 27 Feb 2025 13:09:36 +1000
Message-ID: <20250227030952.2319050-5-alistair@alistair23.me>
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
(PCIe r6.2 sec 6.31) requires parsing X.509 certificates upon
device enumeration, which happens in a subsys_initcall().

Parsing X.509 certificates accesses the blacklist keyring:
x509_cert_parse()
  x509_get_sig_params()
    is_hash_blacklisted()
      keyring_search()

So far the keyring is created much later in a device_initcall().  Avoid
a NULL pointer dereference on access to the keyring by creating it one
initcall level earlier than PCI device enumeration, i.e. in an
arch_initcall().

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 certs/blacklist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index 675dd7a8f07a..34185415d451 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -311,7 +311,7 @@ static int restrict_link_for_blacklist(struct key *dest_keyring,
  * Initialise the blacklist
  *
  * The blacklist_init() function is registered as an initcall via
- * device_initcall().  As a result if the blacklist_init() function fails for
+ * arch_initcall().  As a result if the blacklist_init() function fails for
  * any reason the kernel continues to execute.  While cleanly returning -ENODEV
  * could be acceptable for some non-critical kernel parts, if the blacklist
  * keyring fails to load it defeats the certificate/key based deny list for
@@ -356,7 +356,7 @@ static int __init blacklist_init(void)
 /*
  * Must be initialised before we try and load the keys into the keyring.
  */
-device_initcall(blacklist_init);
+arch_initcall(blacklist_init);
 
 #ifdef CONFIG_SYSTEM_REVOCATION_LIST
 /*
-- 
2.48.1


