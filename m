Return-Path: <linux-pci+bounces-22505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA87A47382
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845151892B44
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 03:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0807A1AA1DA;
	Thu, 27 Feb 2025 03:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="hD3Yp0uW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lPhz2HeY"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A35187FEC;
	Thu, 27 Feb 2025 03:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625943; cv=none; b=RSvjR7csWxqE74ACErM6z2e6rnqX2T2wYVYMxfGTlzI+LDuRKdEqB/nHi0tiiha1nvEc6MvhiUUZrK2VSMbfGmGkdJVkUv3cFsv56RhlLYBW5dEFWJ/y65GrdXHarpqjNsyRaSih74E3GdEPT9BOYcVQfAef25D8tIBb8TmQiIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625943; c=relaxed/simple;
	bh=d8dJ5M4zJTm+b/6IDp9srMSkKH4ua8cTtauEjhffqWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7xck4PiGe+Up5b6yl8jli5irpi1hmEhzBUBarK2JPyVEDdOIpcmhPYs8CD1bz5wlpCDaUDvXcjzcsL2QQklm++52H8rg+54fpiPRwk30It6dHj9vYpMAghkI1BdxN346MQsPKZ84DEvoGqm7fAW6PxWEuK4h0owEIeSd4kBwSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=hD3Yp0uW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lPhz2HeY; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 33832254020F;
	Wed, 26 Feb 2025 22:12:21 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 26 Feb 2025 22:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1740625941; x=
	1740712341; bh=b4h8AeBhBbZ9HfizaA1Uykb1ePIl2dcXDnlikuYxKw8=; b=h
	D3Yp0uWUDUfv+HKRe3j023AGDLT/YqXanuODtRLqDVQKZ+xlaij9AHiAQ9OEXQQO
	b6vUos9ZrWuW8nR4iX+rd5WYulvkniKnE5yiPyoQVeOtusnkoxiordpUUpF76CHP
	rXM0/1gm3TKzCQf6Rd1COuvlAFK94rc1N7WTRTj+AW+m1G++2PWqVQRmXXXsUBiw
	WxeHx2xy/HUJ40mS1ckIcd1HWTGmgaB2IC2lZXDoGrt02l84tUVNUEwJyUI57XCO
	w6phYmPixe7FS6PlL9VFZcJ7GQMqkfqPQwa5yIxqZUsLJaaoHCfEkAFUcRF77Z0V
	mtyJQ1DR4e86zeWPnf10w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1740625941; x=1740712341; bh=b
	4h8AeBhBbZ9HfizaA1Uykb1ePIl2dcXDnlikuYxKw8=; b=lPhz2HeYMc43Mli2d
	0LWyWuemDWKh3LJ0kLnHGvPfVkVADQt9dHN+m53xaYJ+/pbzogimAGgo08HPpfRG
	KgFWjsNpmygI4ERwbhKN1hjscnvb0us1OTp+oeOyusanQBFlr9QfokFGTWvCnaMc
	fjI8vAQG0dhCPp7Uw9Gw47apfZib44r1MY+RXc7xPIwy+UR50V35JhX2zcsSgJrg
	XeqovE8Yuf24S9sdJYMl12f2JrYDrJq8IHNooVUW9SHK41tFm79CuTy08pnMqPEf
	dhrfgAdxG7NnWDJsW/oLoylevNQjI3davhFri5ueSijCYS/8qsY8wPQ1A/dvT+HZ
	1irbQ==
X-ME-Sender: <xms:FNi_ZynbUkmXYeBdqnwoKLNRGNen0uBgTrVydwUVWklsitcbLr4PYQ>
    <xme:FNi_Z51C8IjGphRECITITkxtJCkqaZ7Wen99eckPDaeR9fDL8gXW6R_I-P8P1JUP2
    0EWgo4pfoN_QDudDxo>
X-ME-Received: <xmr:FNi_ZwrDQbB5RQFpgiHN9WmFr86pIRVXWXDqhO7F6IknkMq1JnGucDHHL2q7PPaWtKs7GFeMFD4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekieefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfuohhrthgvugftvg
    gtihhpvdculdegtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlh
    hishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeitdefkeetledvleevveeu
    ueejffeugfeuvdetkeevjeejueetudeftefhgfehheenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhr
    vdefrdhmvgdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehlihhnuhigqdgtgihlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhukhgrshesfihunhhnvghrrdguvgdprhgtphhtthhopehlihhnuhigqdhptghi
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghhvghlghgrrghssehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhdrtggrmhgvrhhonheshhhu
    rgifvghirdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgu
    rghtihhonhdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:FNi_Z2lzVt9_cAeHZrIjb2Q2CrYCr2jnssy-bcXBe2SNR08c7S7DoA>
    <xmx:FNi_Zw0-j3IEBxZmLpQ02OXnR7lBPvTjUxwm7VE8JwEwj98CvsivGA>
    <xmx:FNi_Z9u1n3OtH6DzUdAO3z5pVplIs15XW9C8CSxBegXGgmmBcXh-ZQ>
    <xmx:FNi_Z8XB5Lp-9E3ycdJjXMnnfybB9Wlfosh3u6r5oNxh4NlRZrZxeg>
    <xmx:Fdi_Z6V5yGTZWeL8m5PIXR8fwpF_hW4aMTDUZ5eRxYaMtzPSdodx22d8>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 22:12:14 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lukas@wunner.de,
	linux-pci@vger.kernel.org,
	bhelgaas@google.com,
	Jonathan.Cameron@huawei.com,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org
Cc: boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	ojeda@kernel.org,
	alistair23@gmail.com,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	gary@garyguo.net,
	alex.gaynor@gmail.com,
	benno.lossin@proton.me,
	Alistair Francis <alistair@alistair23.me>
Subject: [RFC v2 19/20] rust: allow extracting the buffer from a CString
Date: Thu, 27 Feb 2025 13:09:51 +1000
Message-ID: <20250227030952.2319050-20-alistair@alistair23.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227030952.2319050-1-alistair@alistair23.me>
References: <20250227030952.2319050-1-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel CString is a wrapper aroud a KVec. This patch allows
retrieving the underlying buffer and consuming the CString. This allows
users to create a CString from a string and then retrieve the underlying
buffer.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 rust/kernel/str.rs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 28e2201604d6..76862e91b81a 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -855,6 +855,11 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
         // exist in the buffer.
         Ok(Self { buf })
     }
+
+    /// Return the internal buffer while consuming the original [`CString`]
+    pub fn take_buffer(self) -> KVec<u8> {
+        self.buf
+    }
 }
 
 impl Deref for CString {
-- 
2.48.1


