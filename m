Return-Path: <linux-pci+bounces-16808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0CD9CD6A5
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 06:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF291F225DD
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 05:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93078185B68;
	Fri, 15 Nov 2024 05:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="WqmNLt35";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aJrWp73D"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39D9184520;
	Fri, 15 Nov 2024 05:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731649595; cv=none; b=NKsf++y66RsS8hsyYXp+ijjOhIkCtMFTboyz3NjVeQ1iFA9GYxYyE9qas5C/uXbJdQrUrVlHE7GKNWRbdIhvEV8ruVVy3uU9wI/rv4UGDaOsZo2Z+FD2TS9MM3eofTP5D/5yMO7stK8PhURMC5iNawTvhCRNF/j0iENjsgoU810=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731649595; c=relaxed/simple;
	bh=uISXudpg3a0EJMCxVtCbL+sgKNCu63mA4i4Vv1LuzRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELkuLljEkk7CoEpgEeK5ZR/XnsZPxmnk5b6GlRaaGVgOIJy5aJJ3tvLtLX00LfyHcOLS5XRIe086CVUMbMqksPPgJNqxrm8/BrEpDQuhEJBLZDYwmYDWv/sRUCBTOONxG9vMUkDL09sWLsGuD77caM1CDvO+bcVvHjyrQXuiuVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=WqmNLt35; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aJrWp73D; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B6C5114011D;
	Fri, 15 Nov 2024 00:46:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 15 Nov 2024 00:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731649592; x=
	1731735992; bh=OgHEk/1EFc0QQfHGk/cY+OzZO//KmIr76oJXZzdsNVI=; b=W
	qmNLt35g406bjVbSwZ2c+StCWCMZZRY7Y2Kba4Dbw+7MWyLXySPIq6iWDPB6H5vd
	0fhp5bTbYMoQP3ZhSdmI/EFZ9/8rnceDHHG+DgI27gzWWI1JjqJR/Xq4kpdEWQsq
	wBLq2zR44Kc0tiYc2ArMOEpBkZgBIPz40iTZT7YB4xb47nOvrQMq/BjG/9uTYMYR
	zM/vV1dO13itutsyUcb7KtjBqNdmKVhzk+u3c7mJI31b7Gmn79xlShJL8m+Itpk+
	tQHeu6/qBLhEHifNhplGHBbpVKRyJQW6U+2lg/JBLbWdMT5jSHhrLnQfN4xdr+E7
	/Om2ndMtR2bPvTFLXNtZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731649592; x=1731735992; bh=O
	gHEk/1EFc0QQfHGk/cY+OzZO//KmIr76oJXZzdsNVI=; b=aJrWp73D2uvFIOOm0
	Xx26iKzJnNZ47h+xSxwr37w9soZ+8583+eY2iMotJi/s0bfqNQSie3x+qhkU9KrD
	kFr679W+/orddB8Kb6dj2bqqKXBtYvSNz/Q9OV+6Ioy6lsrz2421I2ZOJYKnA5ZM
	crvO8jUKFX0MVWm9BFP9+6JUx/VWANNIRxHi4847/uG443g0AHeY1RPuf0MSOT+A
	TFVMSXNXQYzZJ0mMfsBoKHNH7cvbfg+jBtVe38TLXd9EaQpw6QQqM0WzG61PrwZC
	kQbdd5h3Cr2jhMUaN1S32P8PlzjyKSMXR3O+ZZntqbrKqQgaSNCUrKR8tYSQ7C8U
	V9sQA==
X-ME-Sender: <xms:OOA2ZwaGDFsLapu8t5xJ43YSbmwkuWyIxIdQWzZqOHaFgwb4USU5fQ>
    <xme:OOA2Z7aQPA6oRjnHneBuPIuW8eGwSgxFhMyDHoIMqJ_9a44kuSH8URIk7o1Z0YYxC
    cw4D06bO6pKiYG1pWk>
X-ME-Received: <xmr:OOA2Z6959aybJcrT8sYM9qq93IKt17T2PaIayrt-3dBAbi4yaSt7fhyRYN_Dlk9Nc-xuOuNZvpkG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgt
    ihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtth
    gvrhhnpeeitdefkeetledvleevveeuueejffeugfeuvdetkeevjeejueetudeftefhgfeh
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlh
    hishhtrghirhesrghlihhsthgrihhrvdefrdhmvgdpnhgspghrtghpthhtohepvddtpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehluhhkrghsseifuhhnnhgvrhdruggvpd
    hrtghpthhtohepjhhonhgrthhhrghnrdgtrghmvghrohhnsehhuhgrfigvihdrtghomhdp
    rhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqtgiglhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsjhho
    rhhnfegpghhhsehprhhothhonhhmrghilhdrtghomh
X-ME-Proxy: <xmx:OOA2Z6p1D2Ql-hbkrslir1vxl9w3KtiT1pbaWizPrJmMuEsmFyF1WQ>
    <xmx:OOA2Z7qZR590juV5obijsdbfKpPNRC3RCCd254CmFbvm6q4WTCR11Q>
    <xmx:OOA2Z4Qs-Kl_pWy0LGqGh680D-pOKyx_89MQ-4khn89F3xU_msr8Bg>
    <xmx:OOA2Z7od90rDmzyCSR5jt-Sk5xrCNrV6yiPxrP2Qz-nNO4Ljr2NNmA>
    <xmx:OOA2Z3oOPbzHMTHZ4gqopqNGtsC6MiQF77wD5LzYkIgTy86G4embVUWT>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 00:46:26 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: lukas@wunner.de,
	Jonathan.Cameron@huawei.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: bjorn3_gh@protonmail.com,
	ojeda@kernel.org,
	tmgross@umich.edu,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	wilfred.mallawa@wdc.com,
	alistair23@gmail.com,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
	aliceryhl@google.com,
	Alistair Francis <alistair@alistair23.me>
Subject: [RFC 1/6] rust: bindings: Support SPDM bindings
Date: Fri, 15 Nov 2024 15:46:11 +1000
Message-ID: <20241115054616.1226735-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115054616.1226735-1-alistair@alistair23.me>
References: <20241115054616.1226735-1-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for a Rust SPDM library we need to include the SPDM
functions in the Rust bindings.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 rust/bindings/bindings_helper.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 7847b2b3090b..8283e6a79ac9 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -24,6 +24,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/task.h>
 #include <linux/slab.h>
+#include <linux/spdm.h>
 #include <linux/uaccess.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
-- 
2.47.0


