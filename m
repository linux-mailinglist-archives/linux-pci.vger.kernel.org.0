Return-Path: <linux-pci+bounces-19377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF18A036B4
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 04:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1CB91653C2
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 03:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324491E1C32;
	Tue,  7 Jan 2025 03:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="mS9wqiDE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="por36wVT"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EDE1E3DFE;
	Tue,  7 Jan 2025 03:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221943; cv=none; b=kIpNFGZttE6ZROhqrhQSbQOkdlPwRwVjN0FtG04g4CZy3fVh8Qr56ae5cbf5tcNyUGGn2AMFovg67k+HdIzIbplifoPczahGmJ+i6avyX79FyWuPwTmHoqASeiRHZugybShtqm1jc6ZHxVlAuI5llcV9lbs3PXNr2KlLOu3LJjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221943; c=relaxed/simple;
	bh=cd0agS7AIHU0PVOJAqLdisbQ8RWlif+RxxV6n4J/ICs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDfBDJY52STiGy68TOgzGv2ZpETIi/FsUBRUfe0a4OI2PQ/L1mj6xdrak7GUYuXHiacsO9Cn6RZhDyBxehnyXoxUlkIXcL4G8I7dWEk9G9LRoJVid98W+sWza31LWYuF+KqBVTAy+XNMBjleLTSiFqqft5ZqxF+mDfxeB/+Kc0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=mS9wqiDE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=por36wVT; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id BC7B11140149;
	Mon,  6 Jan 2025 22:52:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 06 Jan 2025 22:52:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1736221937; x=
	1736308337; bh=nj0EXgOnxSxBu+4DaTIAnIbfD1oigHDTuBMmfLub0ok=; b=m
	S9wqiDEh/Vj/aCKxZKXvmbA5QijiaNAX0hwSB7AbghhuKO7hqkL/QOY7wDbJIEId
	UPtuASfbjD03l8/IajIZe0ojJLeZhY67S0d+eFZguCXOW8xAsxBjjZjAVRRje1Js
	FWZOC+7TFCN1EEeU+DL69kJ97w+FQUBhIfR+vp9B434kScvCSg/SBl5YsByoijCr
	tDosHckeuuXopVlM8HV92ozaZ/jBnYAGmdROPtzqi2pW3TwbaD1w5pjnkhUqH/Lq
	5fK5E1u4bq9JFCAo+Uge89YieFQBI/u1q2oAU21m4ZkktFRTqhwf9svj/l9mcfpQ
	Et5zdpCOPL+j9vVZvbwcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1736221937; x=1736308337; bh=n
	j0EXgOnxSxBu+4DaTIAnIbfD1oigHDTuBMmfLub0ok=; b=por36wVTUWoqMSo8P
	D3E6MnwmF0snFmmB6hHM580sETT0vvn/VR79x3AcB6zHmZ27hD/qRrGsiIpnDhca
	Aa+2InlPrP/5P/Dw85GmMapJ/l9oCfoVwbTxNaoJ6cWdDmSdjxM5T5y3aExzokC4
	tsfEqLDMcRY6o076d+Zo4lLzTy3YpEVlzx8r2eKSS36b+qGjg8aM25NEMT0sIGWp
	tK8/r+R14vFJxaFGUpRE110mkZj+ng2EFKwvtmUFc1h65aUBhZ1dCZ6lJu4vPhch
	lw9XSEL+Sy2ter4oU5gN/xJ45ev+C9bJv+zl+lj9IbvBPO5+Ywl38nwDib5D7zmX
	rUrfw==
X-ME-Sender: <xms:8aR8Z1oY8v7RU04k2OGgBN3knj8MiHcGYSTCkx2EH-XmOGhDkCGFWw>
    <xme:8aR8Z3pW49U26zjeo94OY-hkMyoAy8tMREHjHqklZiot2F9Uv0xVdLaZbMAUxPdXU
    CNChfwnCfJG8DAYwtU>
X-ME-Received: <xmr:8aR8ZyPGVc3esHHX_b4uNHsry0N1JIWV-F47Odpl4gjZXJGT1-RUerN24j6wBc35yuMZZqp2P3I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeguddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlh
    hishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeitdefkeetledvleevveeu
    ueejffeugfeuvdetkeevjeejueetudeftefhgfehheenucevlhhushhtvghrufhiiigvpe
    dunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhr
    vdefrdhmvgdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhhushht
    qdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hukhgrshesfihunhhnvghrrdguvgdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdr
    nhgvthdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuhdprhgtphhtthhopegs
    ohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehojhgvuggrsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgtgihlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:8aR8Zw47sMS4X3aHZze6Wwm-PPkl2JatMBcg3nX7RHcskVWJED3Dlg>
    <xmx:8aR8Z059Q-VOgNe8iEFYBOgMFABFYip8Gn-PIA-UQZTLEoS7R-hBdQ>
    <xmx:8aR8Z4gKH-lDZXJpoy-tubIRllgVE7GKRH-_S5mLky-ujCyzloNfRg>
    <xmx:8aR8Z249qz0BIVb-WcewS3IJKoWZOw9AfbIpDch0aodS-RtFfJBKGA>
    <xmx:8aR8Z3ILB-I-GxpamqFFZSAAHimwlLk1d9oD8rSMT2w4pC2GeB8p62ux>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 22:52:11 -0500 (EST)
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
Subject: [PATCH v5 06/11] rust: helpers: Remove rbtree helper
Date: Tue,  7 Jan 2025 13:50:53 +1000
Message-ID: <20250107035058.818539-7-alistair@alistair23.me>
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
 rust/bindgen_static_functions | 2 ++
 rust/helpers/helpers.c        | 1 -
 rust/helpers/rbtree.c         | 9 ---------
 3 files changed, 2 insertions(+), 10 deletions(-)
 delete mode 100644 rust/helpers/rbtree.c

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index ded5b816f304..e464dc1f5682 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -13,3 +13,5 @@
 --allowlist-function kunit_get_current_test
 
 --allowlist-function kmap_local_page
+
+--allowlist-function rb_link_node
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 9e6c6c9c67d2..54c52ceab77a 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -16,7 +16,6 @@
 #include "mutex.c"
 #include "page.c"
 #include "pid_namespace.c"
-#include "rbtree.c"
 #include "refcount.c"
 #include "security.c"
 #include "signal.c"
diff --git a/rust/helpers/rbtree.c b/rust/helpers/rbtree.c
deleted file mode 100644
index 6d404b84a9b5..000000000000
--- a/rust/helpers/rbtree.c
+++ /dev/null
@@ -1,9 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/rbtree.h>
-
-void rust_helper_rb_link_node(struct rb_node *node, struct rb_node *parent,
-			      struct rb_node **rb_link)
-{
-	rb_link_node(node, parent, rb_link);
-}
-- 
2.47.1


