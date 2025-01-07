Return-Path: <linux-pci+bounces-19380-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1F6A036BA
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 04:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DFEE165FEB
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 03:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361671E9B01;
	Tue,  7 Jan 2025 03:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="EWgmzQxL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kAoFE7G8"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167C91E883A;
	Tue,  7 Jan 2025 03:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221966; cv=none; b=ueOa6z//HZHG6S6qDyC3i1sAO0uYmGLhyobmu2sGXhwtohFNACmWsg5c6bqnZg5yvgnjwqLqS1Xl2e9W5im8uufMZ4/KrjeHWuybphskutE60XoRn35LMVTblNjfk7oJ6gh3kveUhYumG3wWnKUKxuc0EBECiGtUTe6OEVg0hSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221966; c=relaxed/simple;
	bh=ca4xx630+g0PAjkawxxCm3Yjq6HP4OpCrNReD91pACw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+4GklLaF49M0M4YrsgbiJW6Tg3M3wI7Qas+Dq8WDW1RXMtw/HSre+lod/lfjlB0Fj3dYstdazStMLqS8uHqWcXdqWZpXa9hlnuXvaqWS/X6MF+UMUGqecSYVgUPIswv2rtMQyGEbDjU8gQWr5oPnVbRqf3kpgnis8AU4tQo4/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=EWgmzQxL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kAoFE7G8; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id B6D311140152;
	Mon,  6 Jan 2025 22:52:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 06 Jan 2025 22:52:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1736221961; x=
	1736308361; bh=UBZi08O7ZyCFdLTlJ4kxsaxYFuFhIyxFjKNL1zlgn6M=; b=E
	WgmzQxLbG9IQgWiCMaTdXt1criM1UGAz5Q6IsvMPYORYrR68I/9YpVEHtAyH2Zxt
	dKSCN2DVPD8BJ01lAwBByoGkbDgh9TN+bD/8K3+G8R3A8l2KxrK/vjEgXup9IVKW
	Lk9cWZ/9psmktbnHJhe+Sd+fyyrc/C3HpIUiR+J3/vsBQRpXmQwoYLZKvruXCcyN
	2TJp/UBFdDFjppRGq8AkqmFlVRP5ue98GFipF7S/2l0dKlVH3uikjC7OAmAyCY9Z
	8cfUr/MuH4z3rxUmiZ4DMESIjXvgBkMo1uzohbl6/unjGKSgTP1oAgAcXFuj8pa4
	TwvPt480MDnf6CKxcJwUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1736221961; x=1736308361; bh=U
	BZi08O7ZyCFdLTlJ4kxsaxYFuFhIyxFjKNL1zlgn6M=; b=kAoFE7G8qPLghwBfq
	doWmO5Ro8RUsUxgAE0cL5e8yXr6fI1V6M2TtBJNbMr9qP8IGsKQKQ3Z3ni8+ucxr
	8GoApL1XzjrM2Kn/RVlhFXkZm9I2F7/vLbb/tH2P8c2nJdMDKz10oz98RIZckAUi
	Tl8I1qIEvEORsfPke9/zs36WQRgadNs99fOnm8ziSYXYgKxp923VK3F1QMN5JO2d
	ZTTgK2jZSbqwdh7UzmvbVaZUVC758dPJ4oxjtUcaXxQY0KRlwlEUXbXe4wu73xrg
	yGLW8iClFzL3RU98nmfNn36OUpDxUHkjLelZOSCUJze+r4kAFZ1+TMntehgZS4tE
	YHZvA==
X-ME-Sender: <xms:CaV8Z0bb8IfG79QZdSx4lmSLPRvYb3D5fujgq24L6I_jY3vBWs3Tuw>
    <xme:CaV8Z_ZcDGfyc9qwgPYDM_s-cS15sv6JM-cArlYacDPDqRSlsDrdPH7bDD8ifI5Uk
    x91560jGjszADl4zPk>
X-ME-Received: <xmr:CaV8Z-_w8Pkf-sv-sk2b4Wvf3jNA98Q9lhm084_AeiX15RpoNfhDl2QjbxeiAzIPCu001N5M0ng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeguddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlh
    hishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeitdefkeetledvleevveeu
    ueejffeugfeuvdetkeevjeejueetudeftefhgfehheenucevlhhushhtvghrufhiiigvpe
    efnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhr
    vdefrdhmvgdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhhushht
    qdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hukhgrshesfihunhhnvghrrdguvgdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdr
    nhgvthdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuhdprhgtphhtthhopegs
    ohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehojhgvuggrsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgtgihlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:CaV8Z-q7RIfWO2AmsXwV6B0CHYUXeqqTcFYY_KC7vvCkpV5aU_H68Q>
    <xmx:CaV8Z_oCFL3qHaDuEDuzkOPZxfIG3CmKLUqyvDTIC4TwN-te4s4DSg>
    <xmx:CaV8Z8R8kIcRf-c1aR2dPj1YmxHVp-Zqhbk3NoDZBdCAq8TANjO83Q>
    <xmx:CaV8Z_rI6vf6TGmCKfqcIEOpadN22s0PPYzTheJblCFl8PFQgr6Xxg>
    <xmx:CaV8Z-7_ABXMwOfel3p6C2m8CoadQzhYg0Cn3mbVDdMt-BBgYdyvPuBP>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 22:52:34 -0500 (EST)
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
Subject: [PATCH v5 09/11] rust: helpers: Remove some spinlock helpers
Date: Tue,  7 Jan 2025 13:50:56 +1000
Message-ID: <20250107035058.818539-10-alistair@alistair23.me>
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
 rust/bindgen_static_functions |  4 ++++
 rust/helpers/spinlock.c       | 15 ---------------
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 407dd091ddec..9d6c44e277b5 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -20,3 +20,7 @@
 --allowlist-function refcount_dec_and_test
 
 --allowlist-function signal_pending
+
+--allowlist-function spin_lock
+--allowlist-function spin_unlock
+--allowlist-function spin_trylock
diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
index 5971fdf6f755..72ca0208ed10 100644
--- a/rust/helpers/spinlock.c
+++ b/rust/helpers/spinlock.c
@@ -15,18 +15,3 @@ void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
 	spin_lock_init(lock);
 #endif /* CONFIG_DEBUG_SPINLOCK */
 }
-
-void rust_helper_spin_lock(spinlock_t *lock)
-{
-	spin_lock(lock);
-}
-
-void rust_helper_spin_unlock(spinlock_t *lock)
-{
-	spin_unlock(lock);
-}
-
-int rust_helper_spin_trylock(spinlock_t *lock)
-{
-	return spin_trylock(lock);
-}
-- 
2.47.1


