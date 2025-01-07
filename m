Return-Path: <linux-pci+bounces-19378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D358BA036B7
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 04:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E031218873A9
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 03:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892851E491C;
	Tue,  7 Jan 2025 03:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="iu1DtC5f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rxk0cFp/"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065171E500C;
	Tue,  7 Jan 2025 03:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221950; cv=none; b=mbVqFep1kfEbofFdKbI7kQpY5LQDTtfgUjbgNN4BOX4G5pEwi/FV/vTngH6zVa1q4qy/nvHqV1AOkrYcpOqTEzBfLtp8NxNM0rBA5x+OWFSg9nLV6KfPOBPPaoQUAuKn041UW+/ppKqOtgSbTTPnDt9k6FCCA9lVUc4H1PPr4Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221950; c=relaxed/simple;
	bh=ktuF6QGhDbQg8xIfGVMl2TcLdel+kA+paQAD6kULnIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqLD4dmp02A2z7BKaE9yvX58JKp1uKKt0jEEWsLuBOWSYGkvIOr13PSa7lh4DSzgl+H2wBiL312ISRIgnp6ScXTqDAPH0xGgFlwkxhUjvZ+QUhUsuvYYe1kttAJjdkgfEuiil8p3belT3ZN/twVencMBVekcmYwNlj2QoasJZVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=iu1DtC5f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rxk0cFp/; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7A72D254018A;
	Mon,  6 Jan 2025 22:52:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 06 Jan 2025 22:52:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1736221945; x=
	1736308345; bh=8bWDHDA3V6fl83TPJL7Nq440bVs6UgORLNLOTozsUtw=; b=i
	u1DtC5f2DXFwCPg34L54fW2PNo+45siL6sS+ndsiT8+Qs2JcxVLdvoupliYgxCen
	oAtcqvIuNaS+qrbk2/8lnJ03LuXOvoqKv+PV0CvjsEZvCrBksw7yS8AckGpRUtCL
	c3k+hw9z2fAy1Us0a+zpPSdOg9260qr5WRYWpg57IuwLm+e49+BHP4aseZwLILu3
	Rosvb0yHRk1m4qfHWqNk0yONqSB9uyklV6wT6avurHziaH6aEXiO3PP984bTv4j8
	YV5qz4xOdhrOPflmk56Paz2BIWQTuLqLqEGLHdAoBt+TuRWQHTDu07GnFjUhG4ZZ
	0oj3hLFppa/Y/Xn7bUKHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1736221945; x=1736308345; bh=8
	bWDHDA3V6fl83TPJL7Nq440bVs6UgORLNLOTozsUtw=; b=Rxk0cFp//pvofqBW9
	3+EC4Qhs5PXsjuJOAXURF5AnBXARM8DK0O2LM/ayavApmX3+95rWV9IzkuQICckS
	L2kJTpMlka/V/w0EFfWDCznpME1sH7vWjygcppiMWPUyAjEXHP6kjxHaJgOcdh8S
	fIHbaV0A1ykGTfm1WjmKIuWgVLcubDYaC8FDAdoOcBu6QKX0B/sQ9t5yGFMsjIAF
	9YmGCS/Vrtg46/Ow9ncZhRBG9qXfQKSi27ajkERJ91R5hNOqx9HNxYpkKBQl5BvU
	sCqzGaEF0CXPjx6lrmjBuWUKF1Ty7Iic0y7+mAHFQPZWdmuzsX1EQTgAyZN6d0x3
	MO/5g==
X-ME-Sender: <xms:-aR8Z8_tLDxfDr6DnAK2JX5CuGMdsqiulUqlZRi4f2lJ72okuhVT7g>
    <xme:-aR8Z0tXkwGvZchCshq-MyYG0X8NHKizVRyMFt11IGSpSplYRd41dkkKykY1Or1Xq
    zHQYBnk6a2ag8h-2sk>
X-ME-Received: <xmr:-aR8ZyDlrYa3vJxYuEM7EUFGtQiwaChPDjRVADlUzFqHaF8obu8t2hx55cbkxBqBNdulyb-2Rvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeguddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlh
    hishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeitdefkeetledvleevveeu
    ueejffeugfeuvdetkeevjeejueetudeftefhgfehheenucevlhhushhtvghrufhiiigvpe
    dvnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhr
    vdefrdhmvgdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhhushht
    qdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hukhgrshesfihunhhnvghrrdguvgdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdr
    nhgvthdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuhdprhgtphhtthhopegs
    ohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehojhgvuggrsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgtgihlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:-aR8Z8e6SNICJSwH_70Fn2m-kh4wf6a37VEvlwmBTxa2PaQzOs_Efg>
    <xmx:-aR8ZxMVft5l7UcsYRnkMz-14zwJwfGVo05cG2uUxN1EeKnNZppYNw>
    <xmx:-aR8Z2mnCGtSSdi9isjoYW4zKxq6aRJR-OMIf4FkbGAo1uivZ5q-eQ>
    <xmx:-aR8ZzsvgS5-AFBR6m6JG3YwOXt4_xdtOLUemoaB4O-Sfo8lvABqwA>
    <xmx:-aR8Z8PIRFGblcO7lLuL-a2Rjv1jKsQO4jisuUyqPxIMsItglJqBiig8>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 22:52:18 -0500 (EST)
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
Subject: [PATCH v5 07/11] rust: helpers: Remove some refcount helpers
Date: Tue,  7 Jan 2025 13:50:54 +1000
Message-ID: <20250107035058.818539-8-alistair@alistair23.me>
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

Now that we support wrap-static-fns we no longer need the custom helpers.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 rust/bindgen_static_functions |  3 +++
 rust/helpers/refcount.c       | 10 ----------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index e464dc1f5682..9c40a867a64d 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -15,3 +15,6 @@
 --allowlist-function kmap_local_page
 
 --allowlist-function rb_link_node
+
+--allowlist-function refcount_inc
+--allowlist-function refcount_dec_and_test
diff --git a/rust/helpers/refcount.c b/rust/helpers/refcount.c
index d6adbd2e45a1..ed13236246d8 100644
--- a/rust/helpers/refcount.c
+++ b/rust/helpers/refcount.c
@@ -6,13 +6,3 @@ refcount_t rust_helper_REFCOUNT_INIT(int n)
 {
 	return (refcount_t)REFCOUNT_INIT(n);
 }
-
-void rust_helper_refcount_inc(refcount_t *r)
-{
-	refcount_inc(r);
-}
-
-bool rust_helper_refcount_dec_and_test(refcount_t *r)
-{
-	return refcount_dec_and_test(r);
-}
-- 
2.47.1


