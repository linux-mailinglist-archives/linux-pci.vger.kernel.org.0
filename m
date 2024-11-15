Return-Path: <linux-pci+bounces-16809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C679CD6A7
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 06:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302501F22796
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 05:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE5C17C22A;
	Fri, 15 Nov 2024 05:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="gLcrIcKP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iq4jmO6L"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD57D176AB5;
	Fri, 15 Nov 2024 05:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731649602; cv=none; b=Nw/b3e3UFJrXaWgcdu/kYSXUIZp31QCQf+q5cOdebGyg6vKyDa9cSAXuqqpVE4bf1Q/TislRhZ36lVWLIMgfJTtO6IdScVD/ptBve8ungSSDjsIm+BsIm48zh5/jg62vXoyVcMJTihdDYVedweLXLvGvRf9sJ7jjQKXvI0vOgLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731649602; c=relaxed/simple;
	bh=leWzt/xrFjcg4u9bxgDbzWvDHPOOrZF/NcEMBbRriSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pY/8EEkeWemn24bKN45lhLLOGLxzVispCGMDP1XGc4MUzz8N3z7T8FgervDF0JuwNitzY8TLsX6Oy02033P26F3+cp9kSKMd+onnFjRO7AfjW/d8PaKOODy2M4QSGn3oLpvOjJBv2fY1RHCVKEPDNDAbHSh0vVg+vmmtwLikfDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=gLcrIcKP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Iq4jmO6L; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 6E8B0114015A;
	Fri, 15 Nov 2024 00:46:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 15 Nov 2024 00:46:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731649599; x=
	1731735999; bh=KQS6K/mOBwOucc6ITSv6JSX6O9Y50UxuLxtj1lVijiA=; b=g
	LcrIcKPh/ZNS1g6AgJ599ZWmQnV5OgyUdKV7kKrmKgyfbsl00g0SxSRY4KXh8p3b
	F08APbyCGcWAwGWnp0d7oFS0JK55zcaXdFQRgi1gZOEVzk8QcvmcUQyx9JH0YUhu
	us7sSn6VsWnpLaqWFAMnFpi41vU8/Rr9Kbt0cWTcQNEsgK8uVuT0wQbm79CwByjL
	3GgGquv6ng18rs7TUNtCo0brlj2sbilar2T8AahLkPU5lvLWw3hAJS5MJ8spGOaK
	P2Lfb3y8Z8521s5/Yh6y/voBPgIKHsBT0KI2mxoRBIYgI8EO7XrgwRI3zocuPtXl
	QANw9XllyA9Qem9wmxvYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731649599; x=1731735999; bh=K
	QS6K/mOBwOucc6ITSv6JSX6O9Y50UxuLxtj1lVijiA=; b=Iq4jmO6LlGzj3SeeD
	iNI5QJRCtIx8DPKH0tMhiDTMOZEWRp0NfEDdCa/qr/CVV4y0TujvskqhHSIMITRU
	1kkx/S1OrFDmEJ7ncw64zW3lCoZa/DqiXVLvJ+WQzAnctR5Gl+wzmAOQMANCf2xE
	xRyHaQDX7Feo+TKlOHS/YJCL0YJL13fRCNTy9iY1Bc8tWBmwIDDNG7aHhtUJuD2C
	VQW3KjJRmMQqgp8BwwEvu9KQ+vS9hNL6/FQlWKuDQH5PkFOuiCLmjuDrFfdAR8hX
	tu+1SvJRoSj2Yy1YZTrkuz7VnKSR6wbCaVdL7gWfmBaDgydgxvCZ8PQLUmb48LtG
	ZEcBg==
X-ME-Sender: <xms:PuA2Z3tAw-IoR9egLmTdrpmzmer6tafQX6bE9C2qad7gDrfH_64ZNg>
    <xme:PuA2Z4cSa1yOk3r4LVKHadVjcycgRD8Zj10WsFZy0BZZXt_rL7Ibh1ytBMFK9qeGL
    lYXRuqghsU0sb1flog>
X-ME-Received: <xmr:PuA2Z6yFEKqGaKbvplFToip0PCghKftPmgQWd98jT2y0Of-zL_8ppf29ns_1mup7SFNwl-LOKLUe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgt
    ihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtth
    gvrhhnpeeitdefkeetledvleevveeuueejffeugfeuvdetkeevjeejueetudeftefhgfeh
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlh
    hishhtrghirhesrghlihhsthgrihhrvdefrdhmvgdpnhgspghrtghpthhtohepvddtpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehluhhkrghsseifuhhnnhgvrhdruggvpd
    hrtghpthhtohepjhhonhgrthhhrghnrdgtrghmvghrohhnsehhuhgrfigvihdrtghomhdp
    rhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqtgiglhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsjhho
    rhhnfegpghhhsehprhhothhonhhmrghilhdrtghomh
X-ME-Proxy: <xmx:PuA2Z2PelOiiOoQU9_dyk3YXZBtfVOIsM01IUu_Gbxc86QidQgXnVA>
    <xmx:PuA2Z39mt-C8IHKjODE8zDQW4LL9aPKAzncvPlgmr5PU9kYh52kxtA>
    <xmx:PuA2Z2VaJ5SyY05_HygG6ezm2xxYzWKZ-bUNoGStgHPBzY61MNskTQ>
    <xmx:PuA2Z4fMsc1uWHser_iSekicqZv8eZ5reB1uOrYVfh9hujCYYfaD3w>
    <xmx:P-A2ZyefUcMF8EQdcqISWzxAjOGV90mYPL1I7cuRRnbtp-9JoSZ5jnXJ>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 00:46:33 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: lukas@wunner.de,
	Jonathan.Cameron@huawei.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: bjorn3_gh@protonmail.com,
	ojeda@kernel.org,
	tmgross@umich.edu,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	wilfred.mallawa@wdc.com,
	alistair23@gmail.com,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
	aliceryhl@google.com,
	Alistair Francis <alistair@alistair23.me>
Subject: [RFC 2/6] drivers: pci: Change CONFIG_SPDM to a dependency
Date: Fri, 15 Nov 2024 15:46:12 +1000
Message-ID: <20241115054616.1226735-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115054616.1226735-1-alistair@alistair23.me>
References: <20241115054616.1226735-1-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding a Rust SPDM library change SPDM to a
dependency so that the user can select which SPDM library to use at
build time.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/pci/Kconfig |  2 +-
 lib/Kconfig         | 30 +++++++++++++++---------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index f1c39a6477a5..690a2a38cb52 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -128,7 +128,7 @@ config PCI_CMA
 	select CRYPTO_SHA256
 	select CRYPTO_SHA512
 	select PCI_DOE
-	select SPDM
+	depends on SPDM
 	help
 	  Authenticate devices on enumeration per PCIe r6.2 sec 6.31.
 	  A PCI DOE mailbox is used as transport for DMTF SPDM based
diff --git a/lib/Kconfig b/lib/Kconfig
index 68f46e4a72a6..4db9bc8e29f8 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -739,6 +739,21 @@ config LWQ_TEST
 	help
           Run boot-time test of light-weight queuing.
 
+config SPDM
+	bool "SPDM"
+	select CRYPTO
+	select KEYS
+	select ASYMMETRIC_KEY_TYPE
+	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select X509_CERTIFICATE_PARSER
+	help
+	  The Security Protocol and Data Model (SPDM) allows for device
+	  authentication, measurement, key exchange and encrypted sessions.
+
+	  Crypto algorithms negotiated with SPDM are limited to those enabled
+	  in .config.  Drivers selecting SPDM therefore need to also select
+	  any algorithms they deem mandatory.
+
 endmenu
 
 config GENERIC_IOREMAP
@@ -777,18 +792,3 @@ config POLYNOMIAL
 
 config FIRMWARE_TABLE
 	bool
-
-config SPDM
-	tristate
-	select CRYPTO
-	select KEYS
-	select ASYMMETRIC_KEY_TYPE
-	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
-	select X509_CERTIFICATE_PARSER
-	help
-	  The Security Protocol and Data Model (SPDM) allows for device
-	  authentication, measurement, key exchange and encrypted sessions.
-
-	  Crypto algorithms negotiated with SPDM are limited to those enabled
-	  in .config.  Drivers selecting SPDM therefore need to also select
-	  any algorithms they deem mandatory.
-- 
2.47.0


