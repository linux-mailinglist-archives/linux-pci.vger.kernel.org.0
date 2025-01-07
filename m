Return-Path: <linux-pci+bounces-19376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312CAA036B2
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 04:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D8918873EF
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 03:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FD51E2603;
	Tue,  7 Jan 2025 03:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="vsSi0Ple";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tw6t5HN2"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F2D1E377A;
	Tue,  7 Jan 2025 03:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221935; cv=none; b=mZrETFZlHURQMkY61sGZ4dWPXSY97PREna4nhOQ45szMC9dl80Jj2XdK1U62NVJdt100uXcAB+k/+UnNnOCb8tMi/cU+nJKW7slSlZxaNG5hOq14K1NRR/qRkeingOzLGh79OXIOI6ABCn6iM9F+Q+U8z2g7SIRsLnzJV/rq4/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221935; c=relaxed/simple;
	bh=EHSlaTonH2PZtsWfGpxaWYL0HLwW1YZBpvhRYnj6NjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iatb55l5rCbRT9WrBM8CVfibP0KNwO8HwTe/c0UL18O/o8pVnbxlvqafNZTBf/Z1nb+Q+KuwonHQ+5S2POulQ7soly19DdWdXbjKAvHTIBDhGXIL1YQevAeYfEakAOwERCtqFWyatB4dwhzQHFXMxXFDb+jSkPm6ja9/EMepyJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=vsSi0Ple; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tw6t5HN2; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2B70D1140139;
	Mon,  6 Jan 2025 22:52:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 06 Jan 2025 22:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1736221930; x=
	1736308330; bh=OfYGHDYbEKvGmLe0AavBagBId+cthJ3oCYShygzZcXU=; b=v
	sSi0PlejpPxLSUJBhVCKhG8hyguZ5MzyDiJQ9liiG/IRP2kRetiiRuF3Y0on4TWs
	xh8H2DG7YBfpmLMSThDuurJA03d5Dj895egng59UQRyq4HSc0QZtfImRlXeFiwex
	xdWbH3KNomQAoqYYUwrwHWqFkhZvp2dIC4UqyWvlTlHCZ8IcJOHeHVV77xZWTIKd
	ge1+7T3JVAWNVmIs+gyqcsmRwpBLAFjmVxrGRH5yCfgpdeqryjPRDYvWnBMMAYEb
	Lyx/brHJRzBLml9XXjhzzrOLaaF0Xmd4IVWYRr3yCU2gq3xU0QOj+TwRGE+7G4s5
	hIIkOShrLzEVSeBK7mSbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1736221930; x=1736308330; bh=O
	fYGHDYbEKvGmLe0AavBagBId+cthJ3oCYShygzZcXU=; b=Tw6t5HN2nk8vF0zXk
	R131X4TwrIyqeng3t7+TEBFxxzj4+7X3wM0HtSmjSyKNMDSw3iHb5w+Z7AYGXRci
	4k8OTeQDaP/O7g+geZ2odlAtxgoaL/GV4lMKmCCVOtUV3mvbSrE4FoVvL9h+B3gc
	/0tz0M2sMYdmsR7u2Cm01vgvslxCPQRwhe0Y7uDtgvW/YY15oVNPD4zY9fRv+rlL
	AdblQlB4TTdatdq2Vt/vCDqEf2MJGUBlC4YTOxzdtl5z+aJVCjskUiP7Uya8Ii62
	pa9FNo+hplWKjGg2U0WZxhAN2EwakOCChgKhnse8otFyK5Crb+wsoRuP8N/LkeJB
	Qup0g==
X-ME-Sender: <xms:6aR8ZwQ_kDOPYSkqheJUwiAmXSR7BK4YUVn-1spuB70PLRs4SRYmFA>
    <xme:6aR8Z9yIrmQzUuuVtfbIn0hSX0-sgs2PitiQxDSYwFVcuHkLYGMRqeHivbzfxvwU5
    0R_EHVNmY0viJFlCCs>
X-ME-Received: <xmr:6aR8Z91FdpdZxX8tR5s8WSMAtzO5UvSMWPNAsiPOKgtdEoV2NpunCFPW1JsH7vK-3cSr_EGiyMQ>
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
X-ME-Proxy: <xmx:6aR8Z0C5vxKWM3-wxkcsLd8gvh-sXa2kTvB1e1JxOQ1ARIna8vRFbg>
    <xmx:6aR8Z5gkVb9OAjKhuBkFLeEx7pWZetaryLulhJwjJ8h6Slu1VVqAbg>
    <xmx:6aR8ZwrBJwM1h0TZhgtx_b_JHgXXO0OKBqQaihkJS1wzxZJ59hxWAw>
    <xmx:6aR8Z8i-MSMGIKYONvq0CRGFFmGkmJUO7vPkzn19rO17X6HP_m_T2g>
    <xmx:6aR8Z9QWFa9uVXQkHA4t1Io0U1afE1wSN-EUQutQm5gkzl5yROF05lzb>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 22:52:01 -0500 (EST)
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
Subject: [PATCH v5 05/11] rust: helpers: Remove some page helpers
Date: Tue,  7 Jan 2025 13:50:52 +1000
Message-ID: <20250107035058.818539-6-alistair@alistair23.me>
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
 rust/bindgen_static_functions | 2 ++
 rust/helpers/page.c           | 5 -----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index b4032d277e72..ded5b816f304 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -11,3 +11,5 @@
 --allowlist-function PTR_ERR
 
 --allowlist-function kunit_get_current_test
+
+--allowlist-function kmap_local_page
diff --git a/rust/helpers/page.c b/rust/helpers/page.c
index b3f2b8fbf87f..52ebec9d7186 100644
--- a/rust/helpers/page.c
+++ b/rust/helpers/page.c
@@ -8,11 +8,6 @@ struct page *rust_helper_alloc_pages(gfp_t gfp_mask, unsigned int order)
 	return alloc_pages(gfp_mask, order);
 }
 
-void *rust_helper_kmap_local_page(struct page *page)
-{
-	return kmap_local_page(page);
-}
-
 void rust_helper_kunmap_local(const void *addr)
 {
 	kunmap_local(addr);
-- 
2.47.1


