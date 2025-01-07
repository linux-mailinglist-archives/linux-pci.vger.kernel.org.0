Return-Path: <linux-pci+bounces-19379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D67FA036B9
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 04:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0591F1888077
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 03:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BD81E5738;
	Tue,  7 Jan 2025 03:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="YsrOwSe8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OzHJ9ace"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559551E571B;
	Tue,  7 Jan 2025 03:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221959; cv=none; b=J+moOl+TuU6I22XL5lZecFTIL3oBp5dlc6u3NTDBstIY7sKz0r4tW6jORgJrqdR3MFxsMWh6r7jQwarMFpY4K8NlpJd8jqxFuuSHc0UX4Q8AAWhglsDf2MSdf8Oq82O7wNLfFyJNJUEgT9nQaJ6oK88d2rdKNuSyMzQN/sHTOjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221959; c=relaxed/simple;
	bh=WJM8agB18razC459I8KPMiDyInJYNz/buuLZP8sSpYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUOOwVNJKpgwJ1R2lmHlBrZfiuFfKioTgfoqGe/MvxSCuPdH21FbFKoQsQki4spWMquUs9KVOiriaM7e6sgSH9atHMqpvDBvJROZP+ybcJgNLtr+316MGFJDKZFy1/H30eWuu+V3LcxnmN6CPJCLeXlOB29NTvT86WV3Hfz28mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=YsrOwSe8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OzHJ9ace; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B7F8E1140137;
	Mon,  6 Jan 2025 22:52:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 06 Jan 2025 22:52:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1736221953; x=
	1736308353; bh=uDYuNp9Rb3X+K7oxTJbqZ8wyi03RrB4MU+gB0NKcPJU=; b=Y
	srOwSe8lgNNGX65YnDUHTghbwOxPiMwpS9MZQXrC1fc+YwLkyqTH7AzxdCV5ZRPp
	7ad2fTQM+O/TAKkGKn7GI42IdBFhfkyRle2Q0iE09K57vr7TBipT9I8Fzsgl3XGM
	gsij2+lRYNKmgthcrrEqg6buRI7FPeDNv3YNSrO6kGZ+hUP2azQtMqDemFakoEqt
	xlRvK94pI4xHI5hmAiA49nINVZi7g8IxsDY+lsw9c1HqYTwdCYbYip3B5dGxjnyL
	rV5cimdcOViq+ntr+pfdxXynviSQ1opIIoNcKCUDA6ORX5awbFea2kX3LYz2+WWu
	4eT6VwC8n2TKrgavhHg1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1736221953; x=1736308353; bh=u
	DYuNp9Rb3X+K7oxTJbqZ8wyi03RrB4MU+gB0NKcPJU=; b=OzHJ9aceBiB6hhlVJ
	GRKkdXi7GiR4odTPUTD0ep6g2JAKR+bGEG12WYVVqGteQjTFOtED0yhrpRSYd7qM
	5FsG2cqmII0HLm1XDAU2ALXssrM8+2d5KfdW1V0PGoc8xLMm9lrSE4Hhy+Hn77cN
	E7FJ/EH9KEp9XahnJ1NS15GkmWlhSMIrlyIPoBJ1Rk2U4p0zLEqzyw3UjPhQjy6d
	BrJabPCiBxP7AsyW3N6oTcVpVS/b66fX+9eisHJW2LaNM7t/sBKU0ue/tDMWpdPL
	jyqWRUaczv+1FtAas5LY5cshReqv8WyU5CDc7gwgD2+e3bBfXvwWTe80ZHOoFKKB
	RV/vA==
X-ME-Sender: <xms:AaV8Z3AhifcxLdCXDL5cFMQZjU85RS5I32Qwtx3IQUu2TZUv68IPOw>
    <xme:AaV8Z9j4o9SMTDE8VApfCYsNuJ6EzSmrXLQq5Y8cRtVDZhCU8n5Vk6Nbk0li3-SD4
    zNomKWZZWwSkfgFgX0>
X-ME-Received: <xmr:AaV8Zylc44kq1nR5odWkU5HMvAMuLxvq9nvnGl7hQhcYbt9kk6TFS-CWLeLd2MGlgsuEzshVsNc>
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
X-ME-Proxy: <xmx:AaV8Z5x_SsMAd0jf1c6kwqTSDuf70tfRNmfl97ZUnwYyrRKaU54xPQ>
    <xmx:AaV8Z8RBcj1v6cyuJ76mr0Z5uu9gtogB6HpUzELuluianh8rtmIB-g>
    <xmx:AaV8Z8a0UuoT0toyO7EDzOhb6q4iuFxnbIMUkGBcE87xBElvqPrRwg>
    <xmx:AaV8Z9RtxuCcpvzQh2s9U34ASD1xesArcZmuCnKKrHSIeEhG1tpa8w>
    <xmx:AaV8Z9A0zsrCD8-SjwSztZhhdkXp8wjCVZoC_jOn3KJIYou2wBKvJ8Cb>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 22:52:26 -0500 (EST)
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
Subject: [PATCH v5 08/11] rust: helpers: Remove signal helper
Date: Tue,  7 Jan 2025 13:50:55 +1000
Message-ID: <20250107035058.818539-9-alistair@alistair23.me>
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
 rust/helpers/signal.c         | 8 --------
 3 files changed, 2 insertions(+), 9 deletions(-)
 delete mode 100644 rust/helpers/signal.c

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 9c40a867a64d..407dd091ddec 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -18,3 +18,5 @@
 
 --allowlist-function refcount_inc
 --allowlist-function refcount_dec_and_test
+
+--allowlist-function signal_pending
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 54c52ceab77a..2731ddf736dd 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -18,7 +18,6 @@
 #include "pid_namespace.c"
 #include "refcount.c"
 #include "security.c"
-#include "signal.c"
 #include "slab.c"
 #include "spinlock.c"
 #include "task.c"
diff --git a/rust/helpers/signal.c b/rust/helpers/signal.c
deleted file mode 100644
index 1a6bbe9438e2..000000000000
--- a/rust/helpers/signal.c
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/sched/signal.h>
-
-int rust_helper_signal_pending(struct task_struct *t)
-{
-	return signal_pending(t);
-}
-- 
2.47.1


