Return-Path: <linux-pci+bounces-22501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EABEA47378
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BAC018932F6
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 03:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F941A8403;
	Thu, 27 Feb 2025 03:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="jMBhHwdK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mntzwzeK"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF741CCB4A;
	Thu, 27 Feb 2025 03:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625918; cv=none; b=PMtOMV1rGB72QKCUm1d0MaScxxKxJMgC167CG47ji3iJg37Owa99mrN+hu/6uF8kBk3cvZHFdZ16TNxHydYvgrenWMfn6RMiJwccxLbeVZJNb3k+41usLRe52JaLnSer5acHbPHiEKBhDPyKh/R63lMLsWnDOIgg8t9dHiah70U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625918; c=relaxed/simple;
	bh=kdEKjcv9tLEOlyxEKbgWiMdvqbaA3tcI1a3VIRlNCWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9FyHpri8bM+69Qi3CaghJEfe1FFVAmyPe2NTSu6xiDuhxcDH3xkgwZljg9NEOnw/GmrjE6+C7Wf7OARX2yMAdoqj+QMbEkSi9IWOk3m9BPzWnKqIC+FOxtBMIUZECHrblk0Hc1wDxM/8fZpDIsZsMBAdCCsiopDC8RXX6RS9lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=jMBhHwdK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mntzwzeK; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 77B632540099;
	Wed, 26 Feb 2025 22:11:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 26 Feb 2025 22:11:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1740625913; x=
	1740712313; bh=ah6y+4h59cjSbt/gz1fqku9aOGTqXcZ3bO/mST1W1Pc=; b=j
	MBhHwdKeSzTbXD2YvD4zHKODKZuNAVGQKmZ/8VUOtF0+pw5yrwcj/8lLI0jnabY3
	ezRi6jDRDp7IdDFTMgC7J1YHf02Oh+19ZKLDDR7oE7iY7P3qx0YghBVpCQHBMHkg
	BrYzCUu3NUupopkzfEodE3ijSU02EaJVFTBJEDWDmZ/xnbRatnhcToZJdHsfxRlb
	NA+03PRyxpJakcio8aV2zOi3mH/DWpOUXCxgj77M38xj3azvblrbu1gSTpmAqKnw
	1Gqjck9fgTStGoEzYIUv5Q50jN5QkjNpDZfhSyNyTicNI5tbxD/fZO9h2FU3zYKA
	T7765NHw6jgt8PfvS5jcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1740625913; x=1740712313; bh=a
	h6y+4h59cjSbt/gz1fqku9aOGTqXcZ3bO/mST1W1Pc=; b=mntzwzeKhjdgfuMZV
	D/1RCghEYniSW6KGHhDrIieMJKHx4a4TcZwnnwQ8JYTpj4zcxY3YPeDezTNinVGK
	k1R89Z1htwAahJwqly55fVWnDSqj+UQEbCQ6weudifVTtenXDdweA99+OZ6WSbxc
	sXyiT0w8fp+4qufeKEHJ5HqdF53BNTFsuA/5VFBlsmWxRs46h/hu5NDxU7HHd9QU
	9gyjeALaevjn4ih/RjpkKHefNwUl2eNEgW55+AyhXJhr4tIcjkq39Gtcg68bvQmB
	jQpbQpEy9yO4yB9o/GnAJnhk38pZ88s+IIg9KHEcGST3RM/7GKK2wtk6u4JsjqIA
	LHmdw==
X-ME-Sender: <xms:-Ne_Z79hE6jJ2mkiUxR8EUA_0oF8Mo9LAafwAmaOl32_vGuFYBm5hQ>
    <xme:-Ne_Z3tUHACaxpN5JygjXsr3e7SkJiSFshh_RiZSJza36DFI3FZq8MXbdBQ-l8y_u
    r1vmMOKvJyCzrQtUVQ>
X-ME-Received: <xmr:-Ne_Z5DSugLcdBRkUCkntrG4CVR_y1pZG0GR8BrWrLpocJ2mhFo5czd7CdNdAFWW_qS5arfvHQw>
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
X-ME-Proxy: <xmx:-Ne_Z3dzXESeAbqKcyYjqo6qm6OgjTgGo_U0sHg94A9qnmXlupktsg>
    <xmx:-Ne_ZwPYEQsAuB464rjDQD4ymyc3j9YGe4tLp5yoGGt-cVbcVVyBOw>
    <xmx:-Ne_Z5lHVvyahay7v9mcDitkrDlwPBgKm-qoE-JVuBTlFnX41ueqOQ>
    <xmx:-Ne_Z6uDuRYKnApWIFDRkfqULoWwqkHdUQqVMgGA56JbRQRhUAFkiA>
    <xmx:-de_Z8vHAKNwxsZBA_YLcvD0XOOfT642HBjTeEI4XbAT1j3qHVfPIPDg>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 22:11:47 -0500 (EST)
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
Subject: [RFC v2 15/20] crypto: asymmetric_keys - Load certificate parsing early in boot
Date: Thu, 27 Feb 2025 13:09:47 +1000
Message-ID: <20250227030952.2319050-16-alistair@alistair23.me>
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
As part of this a PCIe device will provide a X.509 certificate chain
via the SPDM protocol to the kernel.

Linux should verify the chain before enabling the device, which means we
need the certificate store ready before arch initilisation (where PCIe
init happens). Move the certificate and keyring init to postcore to
ensure it's loaded before PCIe devices.

This patch enables X.509 certificate parsing and asymmetric key support
early in the boot process so that it can be used by the key store and
SPDM to verify the certificate chain provided by a PCIe device
via SPDM before we enable it.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 crypto/asymmetric_keys/asymmetric_type.c | 2 +-
 crypto/asymmetric_keys/x509_public_key.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index ba2d9d1ea235..44ebae5c059c 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -671,5 +671,5 @@ static void __exit asymmetric_key_cleanup(void)
 	unregister_key_type(&key_type_asymmetric);
 }
 
-module_init(asymmetric_key_init);
+postcore_initcall(asymmetric_key_init);
 module_exit(asymmetric_key_cleanup);
diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index 8409d7d36cb4..997f3e7910d8 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -246,7 +246,7 @@ static void __exit x509_key_exit(void)
 	unregister_asymmetric_key_parser(&x509_key_parser);
 }
 
-module_init(x509_key_init);
+postcore_initcall(x509_key_init);
 module_exit(x509_key_exit);
 
 MODULE_DESCRIPTION("X.509 certificate parser");
-- 
2.48.1


