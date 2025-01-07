Return-Path: <linux-pci+bounces-19374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDE6A036AB
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 04:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D266E164B86
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 03:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BF61E283C;
	Tue,  7 Jan 2025 03:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="Vg9kTGUL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d1drU+SK"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2A31E2619;
	Tue,  7 Jan 2025 03:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221913; cv=none; b=YH05/ZVOJS/V4xd6II5WoaeO0dUTtQOOIYOojSY1DIj1mQQM9Lny4GVrye0MXiriv1qZp34yzv8Bv+ZR+beh/2Cdl40/7Jq+5VeyiBMP9EgNIhMbo1eVPH/BCGsEG3d2BROQHAkX1gYCJ29ILZNxUjhe9j8kiTYzx5eWrIO25ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221913; c=relaxed/simple;
	bh=rXDAQJOL+Uajjgvw/aj70QxUAQD2PtH3Brp7cxEK63w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XeI00fycM52Ht9SXS8OekVjoBsWS9at5q/H5Wbecm8RdGhbyAz8vsPe6RXwCmZ0vF/G4Q1A5zKrnebgOe+ne6ks2LBE2Q5K/Axk/+3EwHJZHk4q3zdLqsuZR9kF54ECm2tcO7Zot1psfLeBjMg3v8RSWm/rISSLZZXUd6fQW/wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=Vg9kTGUL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d1drU+SK; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 9194E1140128;
	Mon,  6 Jan 2025 22:51:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 06 Jan 2025 22:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1736221908; x=
	1736308308; bh=ysTD+sUmXTOF6acsNPFt4Y9Z1gISdYBIgbv6V+9ErgY=; b=V
	g9kTGULBhwctG9AgIlA5wH2besv0NiT7zzvWA7xCkyQZBIErq4SndCXQgi5aihmQ
	xvdl1T0mfJCy/ffUs+8JDN/5eyeoauuIAYxtjnih7aQWyQy43p6K4DxOdLXVAsrA
	lkWcic72XXd0i95S6e4ihWLYw9wKiJt/hhUHpK6YY83Aw9Zg7kE/k0I4FG/M+C1j
	LYW5ct4d5b/raHEdyHC1y2CIkb7umflrlpFZtaUSrDura0QM5L5KkPb6A5KnvBEv
	LQNi5NKfRLC8bV2ArxDoTdP0TSmKLX0xQtEfZzvifd6OReOPzaiLAB5Mgq/LUIcu
	rrtERPgOOvX1djN1ID5Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1736221908; x=1736308308; bh=y
	sTD+sUmXTOF6acsNPFt4Y9Z1gISdYBIgbv6V+9ErgY=; b=d1drU+SKQriVJwwd1
	LtujHF8fUYe2mNG88B5f5jnQyKIpEFj3m0XaI5ZTG1G97IcmI6ZWP9/4DKds40J9
	TbQVjf+VvqRcgX9/SRqiKA1+vyceRxF8pFqDmHH9X3mYzjDOkOLttsaRsOYIf9MG
	V575VdkhG0nDZKrNgUpRDeiTwgqddurRxy7kRi8PhRHWLE0jUJuNwzYKNJdqF3ju
	cDJHvZA06h4RDPpj/0g7p+Zmr5T9xWAiOhCTPimZCtfYxaKpz7CkweovMhlpezqa
	ZFodFUVo4tSOc0XWSfz0JW8mDW7XexBpNhtqarbvaTr18hKQ1GhbMqQNLwAyWQy7
	2x5qg==
X-ME-Sender: <xms:1KR8Z9CL6SF94nE_ZZnpW5dtQTg6ECLgYQy_99Mlc9TKDU2EkjI13Q>
    <xme:1KR8Z7iDw88D5xiNPR4K3iFeRMtcgGFbe1N1X6wRpQcJ_VBEu5PF4671n5fHC4Ln4
    xr66aQezAiLNghSrHA>
X-ME-Received: <xmr:1KR8Z4m9lhNuPfX9tVpPmQ0whyVv6_6LphKYKX4C8VC5jHeoMwttb9WGAcQPHsIc_B0bQGLndiI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeguddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlh
    hishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeitdefkeetledvleevveeu
    ueejffeugfeuvdetkeevjeejueetudeftefhgfehheenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhr
    vdefrdhmvgdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhhushht
    qdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hukhgrshesfihunhhnvghrrdguvgdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdr
    nhgvthdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuhdprhgtphhtthhopegs
    ohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehojhgvuggrsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgtgihlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:1KR8Z3w1p5IlXhqhsbn9mjuQGbU3wWzTaETdwD20FgIzS5NMfgx5UA>
    <xmx:1KR8ZyTy0r1MFYKB-HWMNzIR96Uk-wi2cRgyR16xWuWvLPySB4sxdg>
    <xmx:1KR8Z6YNdEorRn_LUMNaf-dI2VZNzzsqJD16XK5nhGIYRYyk_U6wCQ>
    <xmx:1KR8ZzSFUvMExes0A9NT_EzHjz6mjwQBvlouLawhSZ-WwoQcNNpUsg>
    <xmx:1KR8Z7Cv7B1KWhGWZZSrhKiPstvQ0IN1yo0sAl9doyWcLoiP5I2uS7I4>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 22:51:37 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: bhelgaas@google.com,
	rust-for-linux@vger.kernel.org,
	lukas@wunner.de,
	gary@garyguo.net,
	akpm@linux-foundation.org,
	tmgross@umich.edu,
	boqun.feng@gmail.com,
	ojeda@kernel.org,
	linux-cxl@vger.kernel.org,
	bjorn3_gh@protonmail.com,
	a.hindborg@kernel.org,
	me@kloenk.dev,
	linux-kernel@vger.kernel.org,
	aliceryhl@google.com,
	alistair.francis@wdc.com,
	linux-pci@vger.kernel.org,
	benno.lossin@proton.me,
	alex.gaynor@gmail.com,
	Jonathan.Cameron@huawei.com
Cc: alistair23@gmail.com,
	wilfred.mallawa@wdc.com,
	Alistair Francis <alistair@alistair23.me>,
	Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH v5 03/11] rust: helpers: Remove err helper
Date: Tue,  7 Jan 2025 13:50:50 +1000
Message-ID: <20250107035058.818539-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107035058.818539-1-alistair@alistair23.me>
References: <20250107035058.818539-1-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we support wrap-static-fns we no longer need the custom helper.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 rust/bindgen_static_functions |  4 ++++
 rust/helpers/err.c            | 18 ------------------
 rust/helpers/helpers.c        |  1 -
 3 files changed, 4 insertions(+), 19 deletions(-)
 delete mode 100644 rust/helpers/err.c

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 42e45ce34221..0269efa83c61 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -5,3 +5,7 @@
 
 --allowlist-function blk_mq_rq_to_pdu
 --allowlist-function blk_mq_rq_from_pdu
+
+--allowlist-function ERR_PTR
+--allowlist-function IS_ERR
+--allowlist-function PTR_ERR
diff --git a/rust/helpers/err.c b/rust/helpers/err.c
deleted file mode 100644
index 544c7cb86632..000000000000
--- a/rust/helpers/err.c
+++ /dev/null
@@ -1,18 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/err.h>
-
-__force void *rust_helper_ERR_PTR(long err)
-{
-	return ERR_PTR(err);
-}
-
-bool rust_helper_IS_ERR(__force const void *ptr)
-{
-	return IS_ERR(ptr);
-}
-
-long rust_helper_PTR_ERR(__force const void *ptr)
-{
-	return PTR_ERR(ptr);
-}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 1d31672c147c..675f8eae0475 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -11,7 +11,6 @@
 #include "build_assert.c"
 #include "build_bug.c"
 #include "cred.c"
-#include "err.c"
 #include "fs.c"
 #include "jump_label.c"
 #include "kunit.c"
-- 
2.47.1


