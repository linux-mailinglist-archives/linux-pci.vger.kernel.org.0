Return-Path: <linux-pci+bounces-38605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB30BED71C
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 20:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2633AC29D
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 18:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C950259CAF;
	Sat, 18 Oct 2025 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hxDIUqo6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6988924678D
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 18:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760810591; cv=none; b=YLWqyI9TyCCmpEteqdxU50QT9K7FXaAnePZLCWfeylja6fKDpDWlhGDez/cYQRO08/0TeyHq2CpAC+5U5hJfHvKmud/HOYEwDVkUM9lSRCZP1CXyd6wv0gml9betHZzWUv/eA1egaO8eP3DJDHocuXHT7wKQ4YkMxtnX6HDylGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760810591; c=relaxed/simple;
	bh=0GzwcDEeRifVYWOU1Ju17zqBLy5F9ZnkEqm/6SUKvKQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F7ya5JXv8iWwgS93xJW1fzlNWmi3fGfZWtZQWbgdR7LcMYvu8bV1VzmSHh0jffArdbGqouxu/bIJGz4vm1RcYGfnUAwZoSuT3GpNq9A3yXfqSHHNno+674lFOSC7//qKH3WUCfmrLJsmzWQLUNfpp6cjxijF1eBaICBZi+zMdPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hxDIUqo6; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47114d373d5so25353615e9.1
        for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 11:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760810588; x=1761415388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Jw3+rOqAmz9lI4+2vszjAxIVE8PlKgnkOGLhqwHbOo=;
        b=hxDIUqo6eoQQzTk/UK2gwlX//nfbdzaTwNxS/XcLvWTFXKz5p8Pib51uSza/iK0TR8
         E7X08qcyzgzhVWcnKqAcu8Ntg4MaM66VYBAUC/zpzCTch5BnhEDIjTZ4q2M+Ath2bwkf
         keKUxSQwJixk4tDpFD1p33qi9gIt4SniDidLU+08qSE3TxoKzOCIrt6m/dnTz8zCvc7N
         oZbivVvtCBzIdIvnPZzer6FR5aEICGsb08wSrGdARgtbrsoJKZgu0UA8TPzWXsaCXZgK
         NRqMU7lsymz2BK2cZ/baMWhs4noidaJxecq56qoMu+p1Tn9QwS2IRTTZ4V12VmLAsjgq
         aYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760810588; x=1761415388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Jw3+rOqAmz9lI4+2vszjAxIVE8PlKgnkOGLhqwHbOo=;
        b=XwAmxVCZvAyB+90vC9y6ff79gYT296M4YC8wYzLUJVxh0MrinKy27K4WINfBCrtJTC
         ELMec0oYXMstAw3zaLtDtcYVw0idFSl8FNzpgOCsTZjA40Y2Vr4G6DHQxSP+MvbNZU8r
         hzd1tqkA9ZlaULgzd7wrlUQHy68jbRhSspsZoB5nbV0ldixrMOl17NN1M3zf4tD5ZpiI
         PZc9Tz8953LrMzUHGmtULIqamAoHQRb1zJHwfiqtzGV5CmAxRREEbYu4Y2rLmTs+IU28
         8hCeasIuyu9kvkYqdsT73LiHX6IilzfXytxQxodyJi3Y+LV58m8g5lqXNJuEmDLjSMjE
         JKMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1hCYvYELw15WP/ZqEf+5Tb/32nyIKKzfvSD3WyiXdy7n16u8tpHzLk3HqkksrApUlT925PIKKYeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFsGz9iapDZv3OOApScGuY4biz23j7e35ODAijFTB+kOaaCiHq
	1MgU2lNVagvDIax23IJ25cSqgHyqdZ9L+/vXogs/f3YOx7llnBqIATUBf1lmYMYEEijiJj2dpFK
	9pWAkflB4XZOtNIcbQQ==
X-Google-Smtp-Source: AGHT+IEDBiBL9j3PrKHEoPMUCzoRBlvkx4ZL7AxoxVM1NpYJWMzoUQv31Vq5zUARBonVeR76HGoFc6I/2XbrkI8=
X-Received: from wmbh26.prod.google.com ([2002:a05:600c:a11a:b0:46e:6a75:2910])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4715:b0:45b:9a46:69e9 with SMTP id 5b1f17b1804b1-4711791c8c3mr58877225e9.31.1760810587581;
 Sat, 18 Oct 2025 11:03:07 -0700 (PDT)
Date: Sat, 18 Oct 2025 18:03:03 +0000
In-Reply-To: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
Message-ID: <20251018180303.3615403-1-aliceryhl@google.com>
Subject: [PATCH v18 12/16] rust: configfs: use `CStr::as_char_ptr`
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
 rust/kernel/configfs.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 10f1547ca9f1..466fb7f40762 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -157,7 +157,7 @@ pub fn new(
                     unsafe {
                         bindings::config_group_init_type_name(
                             &mut (*place.get()).su_group,
-                            name.as_ptr(),
+                            name.as_char_ptr(),
                             item_type.as_ptr(),
                         )
                     };
-- 
2.51.0.915.g61a8936c21-goog


