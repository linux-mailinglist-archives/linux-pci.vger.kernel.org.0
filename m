Return-Path: <linux-pci+bounces-19382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 008C1A036BF
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 04:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40E01888E2A
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 03:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E661E9B26;
	Tue,  7 Jan 2025 03:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="AbjOH1yi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tOa6TzcJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18F61E0E16;
	Tue,  7 Jan 2025 03:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221982; cv=none; b=nc0zdqo6UK72xhodHLLhALx9O5JFsCuHNEAxxr6PKhRAC0828cFj/1g8eprATDtlBRNJd2Lec1WHPSFlQvO9oSSVcezta5QhfwKMg7FoRVZDvQj7cjw9v4R6TV92ky0Gw4dvJL9fxLvt6iLIgDzvLzfXJHzhKPvLw4xpIysI6tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221982; c=relaxed/simple;
	bh=h/vdAz68f5WBEK+WdATCg2LIYtqAKRgGlxS03XAJoYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7YTbivcapPZ+wXB2k2Zb0ryeew/i6z72jdppAgaf4EtvchJA6NI87LW7pufE2Idw6tsPT3T8MT2gwd4SUoEbTlS7MUVVVTpWBrHbRj2Ze23Nd3azMAeDseyif8Db/PgxKO6eHr7L9zomh6h7hpnsA7EWOteUfS26rMDVQuHl+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=AbjOH1yi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tOa6TzcJ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 894BC114015D;
	Mon,  6 Jan 2025 22:52:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 06 Jan 2025 22:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1736221977; x=
	1736308377; bh=AZJ1va9BbDkIfSjPw6PRUjwodT7OYt+ydpDIg7Yws0o=; b=A
	bjOH1yib4RcOWpz/8YHSqn6A4PFeYeS+OFcm/S/DuDeHf8P7h3OMnR8e6EuhkjnO
	WMxtQ6a6+0blSZJx2U++iWjCM6Sqv13Z/MXzxvvWqd7rlUedMNYM2AezYZyuS4Xf
	wXhBZ5BA6TblPEd040Nq5brtsdJ7UpGGZU9HFWEc0ezD9jzfEnviwUNqNl/9H0zJ
	zuYRMETVGhehxhQYkjku4dQ3wDS6d1xZm0NWV439iR8UA67ydtKm2jakiUItKg9D
	CWtU14woB8Q4xLNm9FhJf9dKwwNx++qPEPYCE6llGjSpPN2SrvfRWYo+96CIkF4y
	zGNLPQMNLpSjsqO7+zEwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1736221977; x=1736308377; bh=A
	ZJ1va9BbDkIfSjPw6PRUjwodT7OYt+ydpDIg7Yws0o=; b=tOa6TzcJLsrPL8Gbe
	NfphB65zDVwL4CxjKdsN9/jjVKj2/lFMOs0Micrr6ULlGL+NY54vWIhuay8vS/S0
	5p7igg5StEblE6GtV75FLSTpmOnE9VmhG62Oz4Jpl0VksLDmC70Nonv5K85vY3kN
	DodfMT7wjTBj7SztyzdBMH+mEjneICZ2xRE8C+F9kKkh/98c+TcT3Dlm01oK4zzT
	62hSDbPRg2N520iRLFf9myXyNEf3kDzN2CnY10T1h2lNqcCtnhQd20ErUUbET0WW
	rSBXVIWhbIL3Z2sJP+ELe1095Bi3rK3Ih29/fKrqCsbYKVyuMNX/t7bO/gq3gRuU
	R/Kew==
X-ME-Sender: <xms:GaV8Z20OpPjLD79NxcDl8X1IOUuRNrkydJx9W1XscRkAMJy9xDXeMg>
    <xme:GaV8Z5EuQl2QwlOUof2ACSKHNSbpZqB04ObnGjJKTPPRLNH6aIJOVKLDzjqcUHA-s
    b0oHRzRce-_J7hyzKs>
X-ME-Received: <xmr:GaV8Z-5xEM65Ab-77HPZSAVTAzrcLV-2baXfKWlnB_6bjCdQKevTlLvoDiJCu9KRgkFQZmRHzW4>
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
X-ME-Proxy: <xmx:GaV8Z33CpzOT2IOOQKCA_OezcazBZ_SGO_OIMDH9mPUEZJ-YEQParg>
    <xmx:GaV8Z5HhqaT9gB1y5hXsLNu5GgGJq6wU5mtkNg4fANGEXs7YHQMdcQ>
    <xmx:GaV8Zw_tj-0sksn8nbFw3qlWZIk-kFaNd_4dvjs8C_pO27dCxJOelw>
    <xmx:GaV8Z-n6tHOFU-l_HltvfXuxigRQJSwnJJEvueh_TAeZOUx-aYYzVg>
    <xmx:GaV8Zwm7_rRE4nk9tkD_FMBJkAk1Yt1gcdyjYcAUzkan57MV2BnAcvOe>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 22:52:50 -0500 (EST)
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
Subject: [PATCH v5 11/11] rust: helpers: Remove uaccess helpers
Date: Tue,  7 Jan 2025 13:50:58 +1000
Message-ID: <20250107035058.818539-12-alistair@alistair23.me>
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
 rust/bindgen_static_functions |  3 +++
 rust/helpers/helpers.c        |  6 ++----
 rust/helpers/uaccess.c        | 15 ---------------
 rust/kernel/uaccess.rs        |  5 +++--
 4 files changed, 8 insertions(+), 21 deletions(-)
 delete mode 100644 rust/helpers/uaccess.c

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 8bc291a7a799..ec48ad2e8c78 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -27,3 +27,6 @@
 
 --allowlist-function get_task_struct
 --allowlist-function put_task_struct
+
+--allowlist-function copy_from_user
+--allowlist-function copy_to_user
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 2731ddf736dd..eae067fe2528 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Non-trivial C macros cannot be used in Rust. Similarly, inlined C functions
- * cannot be called either. This file explicitly creates functions ("helpers")
- * that wrap those so that they can be called from Rust.
+ * Non-trivial C macros cannot be used in Rust. This file explicitly creates
+ * functions ("helpers") that wrap those so that they can be called from Rust.
  *
  * Sorted alphabetically.
  */
@@ -21,7 +20,6 @@
 #include "slab.c"
 #include "spinlock.c"
 #include "task.c"
-#include "uaccess.c"
 #include "vmalloc.c"
 #include "wait.c"
 #include "workqueue.c"
diff --git a/rust/helpers/uaccess.c b/rust/helpers/uaccess.c
deleted file mode 100644
index f49076f813cd..000000000000
--- a/rust/helpers/uaccess.c
+++ /dev/null
@@ -1,15 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/uaccess.h>
-
-unsigned long rust_helper_copy_from_user(void *to, const void __user *from,
-					 unsigned long n)
-{
-	return copy_from_user(to, from, n);
-}
-
-unsigned long rust_helper_copy_to_user(void __user *to, const void *from,
-				       unsigned long n)
-{
-	return copy_to_user(to, from, n);
-}
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index cc044924867b..d8f75de93073 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -226,7 +226,8 @@ pub fn read_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> Result {
         }
         // SAFETY: `out_ptr` points into a mutable slice of length `len`, so we may write
         // that many bytes to it.
-        let res = unsafe { bindings::copy_from_user(out_ptr, self.ptr as *const c_void, len) };
+        let res =
+            unsafe { bindings::copy_from_user(out_ptr, self.ptr as *const c_void, len as u64) };
         if res != 0 {
             return Err(EFAULT);
         }
@@ -330,7 +331,7 @@ pub fn write_slice(&mut self, data: &[u8]) -> Result {
         }
         // SAFETY: `data_ptr` points into an immutable slice of length `len`, so we may read
         // that many bytes from it.
-        let res = unsafe { bindings::copy_to_user(self.ptr as *mut c_void, data_ptr, len) };
+        let res = unsafe { bindings::copy_to_user(self.ptr as *mut c_void, data_ptr, len as u64) };
         if res != 0 {
             return Err(EFAULT);
         }
-- 
2.47.1


