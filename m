Return-Path: <linux-pci+bounces-19381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F50A036BD
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 04:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B59847A2906
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 03:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CCF1E501C;
	Tue,  7 Jan 2025 03:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="vxchY+0x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wz7tAAC9"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040E01E9B09;
	Tue,  7 Jan 2025 03:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221974; cv=none; b=i0ugWh1WIgem6sFyZSu2KqyeJODmCqJMyzOpzeYLVipxU+ZTMLvd3hRhIkylHt7f3S4CBo5r5ohkwNjJ/Ncq5cGKrmoDownti2QdX4jPmthSzGGTuCQW8APeQ+Ou4y+57GnpzC8GY2THHziZx3HzcKPAKfOWaPkRCxrnTRMkjL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221974; c=relaxed/simple;
	bh=shclbD4m40GcjPTZvhzkGHRYbPJZG50Z0vKKKwDHAX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGL0Up7AQLuIlfKsFxoJwxhpwt5aM+gRYPBim4Owu9YHtWUisfo4NNtTQPsMS95l47Imr+RtwvNwi9JnZlBuoRJ8xLc0DIvFFyApI90l5epPajasgL+F22plgZBgc0k8wUwtRtsXnZGgi9R3cSldTUAve//bh6UMMrgoocMcoZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=vxchY+0x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wz7tAAC9; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A1AD92540194;
	Mon,  6 Jan 2025 22:52:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 06 Jan 2025 22:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1736221969; x=
	1736308369; bh=nCGxfzjG/lwLPtxDK38RAhotjzRn8PNJB7cqZ+mSotE=; b=v
	xchY+0xFIbuXq4z2O4YAYAw6K+xQCWVVxwpgT7Gczfj7+IQO5GLjSaAt5lvfWIj9
	JG3JFeS/XbnypYFSsxNU7vMZglzz2MphxWulevym4XA/6Aas/1Dyw+VemHzS8RhU
	GdGdq/W1UksGvaCFypim2mXt0dUXtSLHrqMPElTb1Zn8W6VAWVjikn5ZXIjjj7yv
	LINOtnqupkCqdrLrFVJRnQ3aaVdH2wiQemLinmCKuiBcyaVUcAM9thlLlITMqdcj
	cAghc2H8hLKrRhrKhrbi7lVDZCj9YA3QK700moDpWXy1IGatw83qMF78+qEHKLzV
	ZS+ua9n/yX/T4wRmopd/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1736221969; x=1736308369; bh=n
	CGxfzjG/lwLPtxDK38RAhotjzRn8PNJB7cqZ+mSotE=; b=Wz7tAAC9F5U8F4P58
	+B9OB0HMTQmUw2M87tp8fwrHwSMf/9kSkfhVzc9KjinaaCdr9irB1SGNwT1C9vdx
	DmMuB0nv4UERzkvF7AyFf9nENazHZi8zCPZdRyea1EFCmODgX61w7VhU7sd/P3yY
	PVtf80Z3HCd/NumhbHEE4HTvMc4f1xcX8zMJyTIjgdfCLL/UbaNZ0bjmZBY7AxV4
	Xc8yobamPy/xvBhaDNo3ZVsC9HX204glgZP2iBbiA278xorHjB4zl4ax0LFBdxwA
	OemUb3fIxh3BPZZEaXdQNSiFSvWYMVWIscnMSIIBAtIduGS83hFziGTfweeI2RaE
	C0pzQ==
X-ME-Sender: <xms:EaV8Z_PuQOTHANU0ZN2Ru87sarRC-ZgchOeDml6OcW7RIpNZ43UYNw>
    <xme:EaV8Z58rTtApBmftmCRsLsJ-z2Tvx3Q5sEkGNlHLpdqzK8wqhQguww6-Izee1nmz_
    tHE8ry5w0kx_1SOM5o>
X-ME-Received: <xmr:EaV8Z-TEbfwZnlpUJ6__-WO-XvXVWbTW-2YMPpwTNA2cvQHWePaEhOWrkp9-uCj0mDznY6TgQEA>
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
X-ME-Proxy: <xmx:EaV8ZzsZtZgCncw8WGegWV0wtGM0GpQ-psxk36qTbOql_K0IsOHqhg>
    <xmx:EaV8Z3eEbmKmdLhfvVg5sEoW3CauYh38Iaxyn7Mb0s-paB16Zj8xtA>
    <xmx:EaV8Z_3sqwQ7f3hkQal1C2mPhbDQlenjXjldA1e5jGMlf415xVfq_g>
    <xmx:EaV8Zz_H-MX9Jp9NV7bIpMAzNfkeVTxMRRY-3LmLHM0dFHH1WPObAQ>
    <xmx:EaV8ZxdXxO8SDym61a7z7shwXmzcIcd4K9RC5drQxJl1Hv8qbz921BFg>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 22:52:42 -0500 (EST)
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
Subject: [PATCH v5 10/11] rust: helpers: Remove some task helpers
Date: Tue,  7 Jan 2025 13:50:57 +1000
Message-ID: <20250107035058.818539-11-alistair@alistair23.me>
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
 rust/helpers/task.c           | 10 ----------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 9d6c44e277b5..8bc291a7a799 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -24,3 +24,6 @@
 --allowlist-function spin_lock
 --allowlist-function spin_unlock
 --allowlist-function spin_trylock
+
+--allowlist-function get_task_struct
+--allowlist-function put_task_struct
diff --git a/rust/helpers/task.c b/rust/helpers/task.c
index 31c33ea2dce6..38a7765d9915 100644
--- a/rust/helpers/task.c
+++ b/rust/helpers/task.c
@@ -7,16 +7,6 @@ struct task_struct *rust_helper_get_current(void)
 	return current;
 }
 
-void rust_helper_get_task_struct(struct task_struct *t)
-{
-	get_task_struct(t);
-}
-
-void rust_helper_put_task_struct(struct task_struct *t)
-{
-	put_task_struct(t);
-}
-
 kuid_t rust_helper_task_uid(struct task_struct *task)
 {
 	return task_uid(task);
-- 
2.47.1


