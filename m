Return-Path: <linux-pci+bounces-19375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5C6A036AE
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 04:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31BA1886450
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 03:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887441E32D3;
	Tue,  7 Jan 2025 03:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="wn1MCndP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ikkma1Bm"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1158D1E282D;
	Tue,  7 Jan 2025 03:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221925; cv=none; b=eaeVAjxqlANIwa3zwYyUNOywBnDS3I3U8S1rwbljGZzR7iPa+Ood70UrTVFLxycb4a6iBjQ53V05+AAB+twAULuuRrSyFg3tfXV12fauVQ7YvAYu9r0hju+PXPm2dzrld/JfexpM5aAEmfDwZSnSXMjKacpllLH6Eez4HXl0DkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221925; c=relaxed/simple;
	bh=5BrfFFBCBHv6932FS3KDksKXm9dLpoXeq8iAZYe+SqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+B/o8fYYpCvRYDV6jUF8gjyA6uVtFDbinPb1IpP4FEkLyg3kzh9uvXPCTaCq8Ue5VoQMq0+roSVo0pbovpAdRKNLY3cTKxINUJU59I51Vpl7hRkSBDxHGD/zi4Y41+R3ft0M8/oSm/UzvLa66M8sGl0xaVQShOS52Nd5KfSqAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=wn1MCndP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ikkma1Bm; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B55911140132;
	Mon,  6 Jan 2025 22:52:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 06 Jan 2025 22:52:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1736221920; x=
	1736308320; bh=bEub0ikOKo+++DSvY9N0stswW670P+GbSK/Ut0G9gns=; b=w
	n1MCndPAy8nPh90TaHLCghRfSkZQTy6RbcgyGB7xsFie0XEWniKknvUYUhWIF/LF
	cVnzMRDtGl9rQmXVrpGjIDShVHs8u8Mj0tr/H/Xa5Mw5ANcCcvi3SAQH4VFNy8vp
	SzNTm+I4nTDddp4R7/s9WwCZkkDaUmznkIpw/n9t3EaAj8QPFug3jn8NAW+KUtc3
	/p0u97in9Ldlk5TT6rZsmUwnK+tVYIVdKc3LIsZgmchcgzx9Ut3Fdf1/ilOGL7Z+
	JMpkMuUea8en4wW3v5XREupCd43DrZlf8rXvxhuqjcL8q/YIq9inDMxuOeqBQ8HT
	eZCf+CQcpcQsLPyol9z5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1736221920; x=1736308320; bh=b
	Eub0ikOKo+++DSvY9N0stswW670P+GbSK/Ut0G9gns=; b=ikkma1Bm9JpJV2OmM
	50eRmZKS51EOmLAuMtdCUjsalmm7uE1UWQykW9P74dQKIHvtp9As8M/AJTbo8/Mc
	TjAR25J9mMVYKDBDiZy/XBfFgvDSNNtxhPU3/5le7q1mNHg/MBCjAkSa1QVPgAAj
	IZ/k4YYAGgyx/u+tocQRs3K3Dib9CPNpLoEHlvACySS9428aEs407U9YrWNOt94Q
	vkZ5WbhheeY8oW3DvHcYuUE7OtVapFKd6paGwFvfwMM2TmcgS+//L7gOs49jABS+
	j4lfz/tswve3JxThcoRRkg3q3/pmnPCOAcP90XtzApSYsozWcnmng4sExT1nM4y/
	7Z9UA==
X-ME-Sender: <xms:36R8ZxUHgQhBkgtkBN6Q5p1dxKB5LMKf-7ULJpRkXCeYYmVuz8p75g>
    <xme:36R8Zxn-npDI9nT56-Kbppg53hrw4bdFwY7IC1yoTG-LhZKtwMMbWqxqt49bW_7e4
    f3ByAYBxLkKSs3rxBY>
X-ME-Received: <xmr:36R8Z9b-aFAVqYUgDl7CvD9ZYp7cT36r2-Yg2SJiWpDMsy4vh74SJXHNheSKNo-aqNbb6PzQQrc>
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
X-ME-Proxy: <xmx:36R8Z0Ux1FcdEz1ZsS3aSaoiGaRkj97JTZTHGMraoJaGtA0ioMue1A>
    <xmx:36R8Z7m8fIfDHMaNBC3OCvWF5vtsXT2S-WvjpTCKuV1Kcoyhrbrn9g>
    <xmx:36R8ZxctHauQDHe9V2C7mdrLQ8-tuGf6uQM8oa38mXCSJPvow-Thvw>
    <xmx:36R8Z1FuwAf9OVz_r8VR1mKnfDAp8vDs9ZYb2hjphaoehsC-KB3hfA>
    <xmx:4KR8Z5Hu4UeaGxgT0iewlbVDrXfs54_GxXiBFP4o26KO-6weDzBR0B6t>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 22:51:49 -0500 (EST)
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
Subject: [PATCH v5 04/11] rust: helpers: Remove kunit helper
Date: Tue,  7 Jan 2025 13:50:51 +1000
Message-ID: <20250107035058.818539-5-alistair@alistair23.me>
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
 rust/helpers/kunit.c          | 8 --------
 3 files changed, 2 insertions(+), 9 deletions(-)
 delete mode 100644 rust/helpers/kunit.c

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 0269efa83c61..b4032d277e72 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -9,3 +9,5 @@
 --allowlist-function ERR_PTR
 --allowlist-function IS_ERR
 --allowlist-function PTR_ERR
+
+--allowlist-function kunit_get_current_test
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 675f8eae0475..9e6c6c9c67d2 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -13,7 +13,6 @@
 #include "cred.c"
 #include "fs.c"
 #include "jump_label.c"
-#include "kunit.c"
 #include "mutex.c"
 #include "page.c"
 #include "pid_namespace.c"
diff --git a/rust/helpers/kunit.c b/rust/helpers/kunit.c
deleted file mode 100644
index b85a4d394c11..000000000000
--- a/rust/helpers/kunit.c
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <kunit/test-bug.h>
-
-struct kunit *rust_helper_kunit_get_current_test(void)
-{
-	return kunit_get_current_test();
-}
-- 
2.47.1


