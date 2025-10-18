Return-Path: <linux-pci+bounces-38607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E28BED74C
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 20:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C0F19A6748
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 18:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E392638BF;
	Sat, 18 Oct 2025 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dCdE0Ojt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06C32741C6
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760810604; cv=none; b=fsxol3IMKe6aVxTayHVPXCf34yhQ0g4JYjRAE7pBA25dP0w6wc970E4SAlaMNx5eEMCPtjNpG66+KxfmaFB4TrKo3ob1fDfmZHq7/R6Uk9cdS9C3ks0N/IAU/cXuk3vEm7TsdK+YN2U25zDnqV5KKyH5/IZDHNla8Rd9z0bpL5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760810604; c=relaxed/simple;
	bh=JRHxs/B/lllx/mRYTbX4X0zoBVdGGTRzzB4qSksz3BQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RZ2N6akmULNF22cmfoRsbNiy4tuqQry7RcvAGijQrGyPPfHMc4JUvBndjN3dY06PW7k/KWTHh3nJ+j3Cj8GaRBHLLqGpzhfKup+vmYbcjhbXXFmTcjqNpDZJrkMg6vpMOfJBzKbuJPURNYX+5Ln21x59eHiSUhOqK+Pg1q+ot78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dCdE0Ojt; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso30822435e9.2
        for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 11:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760810601; x=1761415401; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sRx+IA31rk7VSUz5v3RyOo4nJpXSH+QxySZDi0dx43E=;
        b=dCdE0Ojtp97T5z8E+h35C6VvFcW7GEmDKFlzGtzHHeTO4CpUTYvuzFBRMZngydoQEM
         kkRRH+z1BMRh2i+GVu3xud/cewc0qPlupQACtcV5zolUTgvQgAxIdYFcnCHB9Q4TrDv8
         Ba25lHINRwsGOxjhqlkJ16VRXvWQaNfHlR0xwWVeG3K6p7tB/29fEpY1qCHNaYJPMV1a
         U2xlB3ZR9fBfDpFmM7pUAQLAlmoe/oeqv0q5U0fl736quAWUCsFZipG4cHeMCI6m0uIg
         6iKiF63M8KtoPW2sejkpXljPDgIr6FNv+jOSi3hBzCjNnftEWCqa8x0c6t55zMPznTsF
         Cpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760810601; x=1761415401;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRx+IA31rk7VSUz5v3RyOo4nJpXSH+QxySZDi0dx43E=;
        b=Xf4S4EFgHNc0KvgUn4CyVUKztqvsmu3290PkKwzy4BhoguyivbzQ6wa3E+gaozFko3
         yLlHWNA25xzK6VNcRbwHqPl2QP19CEw+bLKFLXyA4tnbdCOE2Z7tRQHYLMg5718wuk+h
         I6WjOMZR4elB1ZMzDQeMItewqtfbwfwWTAXgsHqHNSTL587FtcerBnriVLUPLFO74IBJ
         2WZxBHncGB3J+SgUeM4/NOy0ptJmRPhVc+JfzeVUiB43M9WDOme+d0/hnivTxR9ZEmku
         FGTydwzYeVM4r4YKpDcni189cM7dMBo3xD9ZaHgqpbElmDpJUYLO+TnFHgUPrEgYhSR7
         18xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh3RX1cieALTOzv6lNv7WZ1lp5PhnISfqLbxvvL0DFBNtbtLTpPMck3TpKRMAsiGx4CnPGiSb/7/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxElJ+KqrtwqXL+PFgO5JAvOw8zl+QexSPAYzzPzqsf+mxP012Y
	yhCrjC7fd3hj/LSpVnbPiHr2Z3e957R2O/IXg600QzSO+292wHcMRWJ+c1iGWCA8g8/+4Wmv2wA
	9bodxR7iWRP4eEFyO6g==
X-Google-Smtp-Source: AGHT+IF6AVT5n9fyZmX8HKRXXzv3logzsSjOnhKpBAjpd1CKVhXkGu1U0u6LIuqBRDGiqbuatyc4kakbkHTbQVE=
X-Received: from wmna7.prod.google.com ([2002:a05:600c:687:b0:46f:b153:bfb7])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5029:b0:46f:b32e:4af3 with SMTP id 5b1f17b1804b1-471178784efmr48534695e9.1.1760810601266;
 Sat, 18 Oct 2025 11:03:21 -0700 (PDT)
Date: Sat, 18 Oct 2025 18:03:19 +0000
In-Reply-To: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
Message-ID: <20251018180319.3615829-1-aliceryhl@google.com>
Subject: [PATCH v18 14/16] rust: clk: use `CStr::as_char_ptr`
From: Alice Ryhl <aliceryhl@google.com>
To: tamird@gmail.com
Cc: Liam.Howlett@oracle.com, a.hindborg@kernel.org, airlied@gmail.com, 
	alex.gaynor@gmail.com, aliceryhl@google.com, arve@android.com, 
	axboe@kernel.dk, bhelgaas@google.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, brauner@kernel.org, broonie@kernel.org, 
	cmllamas@google.com, dakr@kernel.org, dri-devel@lists.freedesktop.org, 
	gary@garyguo.net, gregkh@linuxfoundation.org, jack@suse.cz, 
	joelagnelf@nvidia.com, justinstitt@google.com, kwilczynski@kernel.org, 
	leitao@debian.org, lgirdwood@gmail.com, linux-block@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, llvm@lists.linux.dev, longman@redhat.com, 
	lorenzo.stoakes@oracle.com, lossin@kernel.org, maco@android.com, 
	mcgrof@kernel.org, mingo@redhat.com, mmaurer@google.com, morbo@google.com, 
	mturquette@baylibre.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	nm@ti.com, ojeda@kernel.org, peterz@infradead.org, rafael@kernel.org, 
	russ.weight@linux.dev, rust-for-linux@vger.kernel.org, sboyd@kernel.org, 
	simona@ffwll.ch, surenb@google.com, tkjos@android.com, tmgross@umich.edu, 
	urezki@gmail.com, vbabka@suse.cz, vireshk@kernel.org, viro@zeniv.linux.org.uk, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Tamir Duberstein <tamird@gmail.com>

Replace the use of `as_ptr` which works through `<CStr as
Deref<Target=&[u8]>::deref()` in preparation for replacing
`kernel::str::CStr` with `core::ffi::CStr` as the latter does not
implement `Deref<Target=&[u8]>`.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/clk.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index 1e6c8c42fb3a..c1cfaeaa36a2 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -136,7 +136,7 @@ impl Clk {
         ///
         /// [`clk_get`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_get
         pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
-            let con_id = name.map_or(ptr::null(), |n| n.as_ptr());
+            let con_id = name.map_or(ptr::null(), |n| n.as_char_ptr());
 
             // SAFETY: It is safe to call [`clk_get`] for a valid device pointer.
             //
@@ -304,7 +304,7 @@ impl OptionalClk {
         /// [`clk_get_optional`]:
         /// https://docs.kernel.org/core-api/kernel-api.html#c.clk_get_optional
         pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
-            let con_id = name.map_or(ptr::null(), |n| n.as_ptr());
+            let con_id = name.map_or(ptr::null(), |n| n.as_char_ptr());
 
             // SAFETY: It is safe to call [`clk_get_optional`] for a valid device pointer.
             //
-- 
2.51.0.915.g61a8936c21-goog


