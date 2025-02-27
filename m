Return-Path: <linux-pci+bounces-22502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D008A47370
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DF03B66D9
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 03:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BAE1D63E5;
	Thu, 27 Feb 2025 03:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="UaS0wvJl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GTFukQij"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DBF1A5BBC;
	Thu, 27 Feb 2025 03:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625922; cv=none; b=pncyGwpP9/3IDrkN24wp+hrGgasre468uHF1MTk84/v7hBQ7qgsuN4ifRucEpLERCOOGAUk4CPObZdxptp/EQwOSmBOLQtTinxJCPAvXPQW7COYk6RXLBb7pO1z3CJGmdD4ZgCsPrSqhe6NTVCxWXzCvFIlkekzZeB1gmMAiOII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625922; c=relaxed/simple;
	bh=GTfEGM6C7u682dS5iVaYCUXbIIFqCwwWGzke2ksc1JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X99njipnyrhuLdDRR2/OB8DuF1JxKUfJ8ivVb0ZtETYpJpD9AhK4u90JVBEV1c+SnCboSdRcS/NV7coj7w5Xp1L8SHkTDFEtRGtFhLSTI+oVEUV8R333WXhy121v9bTvQkAbzdc0hkmoP4PhgLw8qU7SdZPHe/QZuBi/7YsOJTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=UaS0wvJl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GTFukQij; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4B0CE11401A7;
	Wed, 26 Feb 2025 22:12:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 26 Feb 2025 22:12:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1740625920; x=
	1740712320; bh=//SgTkBvq5QqRs/XyLf61Um2H+GXIpwL4t51TxO5nWw=; b=U
	aS0wvJljS6vQ5FcdZRmy7w+rC7Exz1qOHi/BcLJih3i+2O5XhPV13DzCFR9zplsQ
	TSKuLmepM4wMT8hG6Hd5T7NjxSsbpDgbHQcGcWjmdFvJqpkfu9Mc4eDXutI0jgTh
	kKCArts+Ljju77Wf+ec72PBqZuoOzc2ju4imc3Ost0dAGAOJtAahwieEjRorMF7l
	OqWxYzxxd0D0PriiDR77dR09aqaKsTznU6uuK83hzHv44j7Kvw4T8Y2A6DIfitA9
	szuDogbavCI33WnYsr9tepaedDk5Zj3AoQkIfeCADnlk5ARh+pyir7xj0Vw7fjV+
	48LIlb6EYPoG4EF4PWxsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1740625920; x=1740712320; bh=/
	/SgTkBvq5QqRs/XyLf61Um2H+GXIpwL4t51TxO5nWw=; b=GTFukQijs0Mh3VztB
	qD2z709nTVT3RCDpJVzqo3IyIMjETX5Zn72wLJolmSlfxuggY4cKMpAPVvC5gN5j
	et3kJL1BUmNVRnvfjxyS1jIRvKYEZ13k5q+LHRjtw+pQlo03+DKyY0/mEodbTOW6
	uve0QyCZ5RipXIKkM0e1EIYfW+oXbEulvV5wgkMoeKpB/kKsMwvcLLZhfCexEqbY
	VlgPLigVnWuo3uwFVbCmgz/jtX46ZsH5re/hIjQP80qbWPoBcS+EQQiOyMRLBbT1
	T0EejzXVU4oaeclYrb+TvCVzPP9Xn/pwoXiDjJAEp5j4oeo99qkZAhHIwxy4ZQnx
	qGDCg==
X-ME-Sender: <xms:_9e_Z-sObvW9nW-_d7vfIUCByKFP-DEs02BhT8-YpY4vVPmCV8DQ-Q>
    <xme:_9e_ZzeY3TPYKBMo-5THXVF20K3zM-mbep5a4M5U8jc6j2ul9dO5IViA0OYIjum2e
    Mh60otpe_ovrdP4HKk>
X-ME-Received: <xmr:_9e_Z5yRLyiXLSsGdOBHW0aHWzJ86M4tRb9tLfCMyshr-QWanNGMKTJCTInetBWNtguifjRPYco>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekieefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfuohhrthgvugftvg
    gtihhpvdculdegtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlh
    hishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeitdefkeetledvleevveeu
    ueejffeugfeuvdetkeevjeejueetudeftefhgfehheenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhr
    vdefrdhmvgdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehlihhnuhigqdgtgihlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhukhgrshesfihunhhnvghrrdguvgdprhgtphhtthhopehlihhnuhigqdhptghi
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghhvghlghgrrghssehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhdrtggrmhgvrhhonheshhhu
    rgifvghirdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgu
    rghtihhonhdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:ANi_Z5OTxqF0c-wcqLyZL7c2PA9T5vo7rH6wKDdNMgBqN_Gt-I94YA>
    <xmx:ANi_Z--r6gt0_jdvnMf378XfkB6WUNSNJdpPw1VFjDbauYCWMz2jJA>
    <xmx:ANi_ZxWLniwKBeq7Id1KBu9N2se1bOWBSeVoSeb7UJa3VWhnq0T7kQ>
    <xmx:ANi_Z3enb1BrdR3I4afn2PHZNUusDgdleTiVYfjT2H3WgVDrqNk41A>
    <xmx:ANi_ZxcE2hvkGOdXxMODE_GdPRXtHMtmfS6CzZxi8GO59_PE1Pwrb_sx>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 22:11:54 -0500 (EST)
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
	Alistair Francis <alistair@alistair23.me>
Subject: [RFC v2 16/20] KEYS: Load keyring and certificates early in boot
Date: Thu, 27 Feb 2025 13:09:48 +1000
Message-ID: <20250227030952.2319050-17-alistair@alistair23.me>
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

Work is ongoing to support PCIe device attestation and authentication.
As part of this a PCIe device will provide a certificate chain via the
SPDM protocol to the kernel.

Linux should verify the chain before enabling the device, which means we
need the certificate store ready before arch initilisation (where PCIe
init happens). Move the certificate and keyring init to postcore to
ensure it's loaded before PCIe devices.

This allows us to verify the certificate chain provided by a PCIe device
via SPDM before we enable it.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 certs/system_keyring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 9de610bf1f4b..f3d8ea4f70b4 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -260,7 +260,7 @@ static __init int system_trusted_keyring_init(void)
 /*
  * Must be initialised before we try and load the keys into the keyring.
  */
-device_initcall(system_trusted_keyring_init);
+postcore_initcall(system_trusted_keyring_init);
 
 __init int load_module_cert(struct key *keyring)
 {
@@ -293,7 +293,7 @@ static __init int load_system_certificate_list(void)
 
 	return x509_load_certificate_list(p, size, builtin_trusted_keys);
 }
-late_initcall(load_system_certificate_list);
+postcore_initcall(load_system_certificate_list);
 
 #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
 
-- 
2.48.1


