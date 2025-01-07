Return-Path: <linux-pci+bounces-19373-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2129A036AA
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 04:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D55164BB1
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 03:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4E71E0B86;
	Tue,  7 Jan 2025 03:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="NmDDLTaT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tib6GhS0"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1481E00BF;
	Tue,  7 Jan 2025 03:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221902; cv=none; b=YK9/CCzPBQpZSq9Y7QeIfmhl8SUVng6MXPLWRZwo2Q51dt9sp4hdKPxEDrckS9NKOjaBQtfk7WOtHDE4YlLSm/y0mmzLlBkUAWSicJru+4yyVv0blzz2Xuib8ny8kxxh9dVrdUjAHNtK0KPTJUlr6GoZrk8pOyjQ9EwnziDzaBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221902; c=relaxed/simple;
	bh=IWjQKr7AccmFJmpTxD6S3bb5W3i/qtgfuKMD1zVh5zU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kok8HTltHcX6LNa58OVP+NGwzJZem8VSvb/zhAGL6iRh2yQ1hz/1gwXV+rXHQ2ZgS6Xb7etM38goWQOtX1RHwVPv45/BKiaGd/Gb3QmBiJskiXkA25h5XePJgu5kGALAaNmrJ++wNyoojM5pNojwoSnNdSoPktTG6dvvR2rasn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=NmDDLTaT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tib6GhS0; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6B16C2540187;
	Mon,  6 Jan 2025 22:51:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 06 Jan 2025 22:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1736221896; x=
	1736308296; bh=z+pFKIeLOA8PYLBgwPgZ3mmaxEgfTa5OvRl/6M1DAr8=; b=N
	mDDLTaTluiTd2okDGRChlHL9dczRxUWgfKdEmsHdk3Abs7Z/wlZOmfKHwZjVF24o
	emcf+eIXgJ2FgdiXQfdRjejN5/LSz1h5bRRVxP+okeiTg6NyzPnfZRnBLTTQL3UR
	hjLf6cjva55lJB76KzCg/xWamKUFMnZylgF+HwKDfr3T+JKAikFwFqqGowGi0/b7
	DHMZuYMfY1ngzNPu3RwfABks2dXgkU+o15ePF5j0vg5wg0oWAir8gv5Er5kZth//
	nPsxM0JdW6njkxZfggh1dxJQZS2ZUFqmVXt6oMfUKhOe9EPIM0qPxAVwXvnDNt2U
	aa8cuvt1mP4dRWtj5qNew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1736221896; x=1736308296; bh=z
	+pFKIeLOA8PYLBgwPgZ3mmaxEgfTa5OvRl/6M1DAr8=; b=Tib6GhS0+vlHp/r5S
	g/2r/Y3KKXwPVXAR6qNiifkukRB/D4ttviZe2lqy+WwInr8kPEYc13bPLKs/CJje
	pLgIcBgUgzouTRoyJnq66OtKAaOnQPpMcRUu0pkta00zpE0bADIHhug5iFOHyJrX
	K+9osKwdDXTqNJWGO7KXaREGPi/395TZlP7h1J9QnZ8ctfr937F31AVciOnBVmdC
	zn/BZGqjfObN9q8DD7Yv84KTC0Gh7O+M2rC97gqX0fZOGV69BEHmJVwU/rR6apNL
	eoafEn1CzWRNPit2Xv3wXSIIxIDrvZvz7R/77zHQCApRIWb1WC50jpXPeTb3cMy9
	V6L4w==
X-ME-Sender: <xms:x6R8ZxdngS6fIseNZD-6J9zkg7ydtnBKH9YH7PN3_fr96LI46WurUQ>
    <xme:x6R8Z_Oq4VK8rjvjJ8au_i1ZQU2U0t6UobsNtN_4rOKZnmgDenK5FPJW6wIbLcNW9
    Z9r8EhHSpOfVRHYlhU>
X-ME-Received: <xmr:x6R8Z6hzEFMvksy0hA9M9lmBC67CkDnpjAf9MWusctUGc6rSkT1lPoGUoZKGD_jL-3OskMZScZ0>
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
X-ME-Proxy: <xmx:x6R8Z6-arbnmjjIYdQp4_1W2tfsEYB1A2XXC6ntLrTGCuuyHjkAhEg>
    <xmx:x6R8Z9vae59UfaxdsMHLWuvmNAXdfb5A0l7pIMXWgrb8CQA0Ve6LmA>
    <xmx:x6R8Z5GNJ1uvwY1CIT7T-T1clF0_X4bDp-MuxGG9e4esZh27LWd8Vw>
    <xmx:x6R8Z0MeUQvtG2GHwmbfxyj84uNyTKI_7_0H9MD6TXUYHjWZEtyARA>
    <xmx:yKR8Z2sQzmrclPpL9wDvNKgs97E6lOew4s6ezL42kFs7Qjq8Bn7d3CvG>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 22:51:26 -0500 (EST)
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
Subject: [PATCH v5 02/11] rust: helpers: Remove blk helper
Date: Tue,  7 Jan 2025 13:50:49 +1000
Message-ID: <20250107035058.818539-3-alistair@alistair23.me>
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
 rust/bindgen_static_functions |  1 +
 rust/helpers/blk.c            | 14 --------------
 rust/helpers/helpers.c        |  1 -
 3 files changed, 1 insertion(+), 15 deletions(-)
 delete mode 100644 rust/helpers/blk.c

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 1f24360daeb3..42e45ce34221 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -4,3 +4,4 @@
 --blocklist-type '.*'
 
 --allowlist-function blk_mq_rq_to_pdu
+--allowlist-function blk_mq_rq_from_pdu
diff --git a/rust/helpers/blk.c b/rust/helpers/blk.c
deleted file mode 100644
index cc9f4e6a2d23..000000000000
--- a/rust/helpers/blk.c
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/blk-mq.h>
-#include <linux/blkdev.h>
-
-void *rust_helper_blk_mq_rq_to_pdu(struct request *rq)
-{
-	return blk_mq_rq_to_pdu(rq);
-}
-
-struct request *rust_helper_blk_mq_rq_from_pdu(void *pdu)
-{
-	return blk_mq_rq_from_pdu(pdu);
-}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index dcf827a61b52..1d31672c147c 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -7,7 +7,6 @@
  * Sorted alphabetically.
  */
 
-#include "blk.c"
 #include "bug.c"
 #include "build_assert.c"
 #include "build_bug.c"
-- 
2.47.1


