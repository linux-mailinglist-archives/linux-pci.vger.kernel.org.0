Return-Path: <linux-pci+bounces-40641-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F70CC43035
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 17:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A773AEF67
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 16:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D604622A4DA;
	Sat,  8 Nov 2025 16:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwowBCnI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA48221294
	for <linux-pci@vger.kernel.org>; Sat,  8 Nov 2025 16:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762620939; cv=none; b=OSKY9M68VoMobr99CIj7xnwXCALXkMkfLx513MZOZZWxgorYbkTXYbw3MoQiuJdfSGqNrc8zKJfotoOalNMBwH3nejmavUlLjxNe716b/Pafi6enK87gNjOxZmitF9n46Ngqrstf8CjAWaB80E3w+kg7lzL+DWmrZA5TLTQhXRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762620939; c=relaxed/simple;
	bh=F/nW1NwtC1Ruv5+SUxdP3bvOxeJUJ/xNQNgyzSwQrGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qS+/4mjb35uKKXohbnCLNuC5GV+BJvISCDN6RazkvR1MjENhBHgsw0rhY0kQV4mjA1DP5YMByaOg3ti37xtFUlkd68Kxf01Zx9OoEYUsgKpgkgTGRZYKe78JQT12GTfJgXW1qMiKB1F8wIwR3mwYNPxfYS55JhyNjSzCMAtGOxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwowBCnI; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3418ad69672so1123914a91.3
        for <linux-pci@vger.kernel.org>; Sat, 08 Nov 2025 08:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762620937; x=1763225737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eS4aRaCWQbf8kHDxTXLGrz0fuyh4VU+l+vQ4w8/XelM=;
        b=gwowBCnI/eXquEcZRCF0m9wXyYWuVxDiS/PsgLn/nduxk9GfIQ/jXbeiCMGv9W9wI9
         TCHQl6mJWa9rJNeDNapIXUs0tCvPnMIZb7h/KzOwWFco40nFn615YdYBpc2Gqoy6KYz9
         37x3+oyfybVM4jJFx3Ck10+Vqy7fJe1KJz3DWA5QQoJFCtOT5NYQlVF2D4MCYQNP6WK2
         tD3IAH04ryV9Ua47bQVStIl20ZwM6H16IfwS1VDQAxVoHAORXVVRhbEo3It9D7Czo55n
         WpmFRD93l/T1BdPzTZfzSD/5INqpPA/5vyvnS1qKaDO/hiEbzVS5MpRwsI7ZRyvTNQvi
         ZETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762620937; x=1763225737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eS4aRaCWQbf8kHDxTXLGrz0fuyh4VU+l+vQ4w8/XelM=;
        b=GjXUWrxv6/SH/YyOZ9IL1HADFF5yI3ODKGSPjkWE57RSkWfjH1/84ZG5ERO3GCrNY/
         nOiLlp6sE609n7HdBZ6yMhWPlS//A7eH4ebGg0q8VjOonVtGp+9HVkP9ctXIQQ3B7dxk
         lmVFuMoxKz4BWNvmWtUpjgAmmzDB7QaBymFb78v7kF6/QPhMWGbEgu4siMi+CZTzq55p
         OVghtVNnfGzg+sGiOGBqsASM5Cwnhfwl5DLXdI3e3z6QEMN30qZW8vFNKWrNkN9sxuMG
         JXURXmBkSW7lIuH3AEgnaqek1ZuDFaYH7fxJ6Lc9a7krpH1LI0uoIlCnQcMCf/3v0rXI
         +bfA==
X-Forwarded-Encrypted: i=1; AJvYcCVZx+HSDuFiVLGxPlQZyk161L+nSgcHXsxxBM5u3T5nENB3j5LshVt6LPY27KgCLl3IBCBKbGLKs/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7+8cVvrBKCiNR9X/hx1zFPYpGucSGLqUFvykWaJaCNjrn9bzh
	Lkukof48Lt8K7pPbIOH1RIyhonK7jH1Xu45/aa1e6wYfhT8LGaQt0Lrr
X-Gm-Gg: ASbGncsV8O+AHZJd/AqZ4LXIZv49xnz7Gc8qQdF6rXBTsBV5vFP9T3QWUJMJipz9Ief
	UPWD76yP2vR9SheiDTwzzUH1bpOyZuD1ZZGACKoH6F+cFwqo1SfQczJuevcCScXi58LKJqAsrD4
	SuYrMnx+ghS+yDGMlVvDcKKcNQyGVvJzu8M9w2f2o+mS/Jt3/VSsuBu6NF9DXRiUm3najdP3RFu
	ubFPajvygb9+5R5mylBXAA18nSBfOmWpo+Bi9vYL3DHJqv2UwwV31QWBUJX4XC/Ejvo1vgu1eBx
	zccsh77xE4/CVsXod9MpyngvU4+D/ij10Y00gB2PkrBXhzz1phsXVNk1ROySqmYstkUA1qERN/D
	nLqFU3b38qCsZj13fYq2liUvWwoDFUYTIdLxlDwR490dpMKW2jRv7unGDfgl77r53EA5yhYi1Zy
	aRLhHfzFK7kCxs8hrd1zyjuQSpykljGUN+WgqIVmk=
X-Google-Smtp-Source: AGHT+IEK4Id6LcZHfEegeQfKzSISCLsplggp/+eo2BV506hPPHU4/6C87PquIuahlXDd2KcpheJGdg==
X-Received: by 2002:a17:90a:d2ce:b0:343:6108:1712 with SMTP id 98e67ed59e1d1-3436cb8c2fcmr3407143a91.18.1762620937526;
        Sat, 08 Nov 2025 08:55:37 -0800 (PST)
Received: from localhost.localdomain ([119.127.199.141])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba901c3817csm8181254a12.30.2025.11.08.08.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:55:37 -0800 (PST)
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Subject: [RFC PATCH v1 2/2] sample: rust: pci: implement dummy error handlers to demonstrate usage
Date: Sat,  8 Nov 2025 16:55:11 +0000
Message-ID: <20251108165511.98546-3-jckeep.cuiguangbo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251108165511.98546-1-jckeep.cuiguangbo@gmail.com>
References: <20251108165511.98546-1-jckeep.cuiguangbo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a dummy implementation of PCIe error handlers to the
Rust sample PCI driver. It demonstrates how to implement the
`pci::ErrorHandler` trait.

Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
---
 samples/rust/rust_driver_pci.rs | 47 +++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 11ed48dd9fbb..d575f84fde7b 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -4,7 +4,17 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{c_str, device::Core, devres::Devres, pci, prelude::*, sync::aref::ARef};
+use kernel::{
+    c_str,
+    device::{
+        Bound,
+        Core, //
+    },
+    devres::Devres,
+    pci,
+    prelude::*,
+    sync::aref::ARef,
+};
 
 struct Regs;
 
@@ -63,7 +73,7 @@ fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32> {
 impl pci::Driver for SampleDriver {
     type IdInfo = TestIndex;
 
-    type ErrorHandler = ();
+    type ErrorHandler = Self;
 
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
@@ -106,6 +116,39 @@ fn unbind(pdev: &pci::Device<Core>, this: Pin<&Self>) {
     }
 }
 
+#[vtable]
+impl pci::ErrorHandler for SampleDriver {
+    type Driver = Self;
+
+    fn error_detected(
+        pdev: &pci::Device<Bound>,
+        error: pci::ChannelState,
+        _this: Pin<&Self::Driver>,
+    ) -> pci::ErsResult {
+        dev_info!(pdev.as_ref(), "error detected.\n");
+
+        match error {
+            pci::ChannelState::PermanentFailure => {
+                dev_err!(pdev.as_ref(), "Permanent failure detected.\n");
+                pci::ErsResult::Disconnect
+            }
+            _ => {
+                dev_info!(pdev.as_ref(), "Attempting recovery from error.\n");
+                pci::ErsResult::NeedReset
+            }
+        }
+    }
+
+    fn slot_reset(pdev: &pci::Device<Bound>, _this: Pin<&Self::Driver>) -> pci::ErsResult {
+        dev_info!(pdev.as_ref(), "slot reset.\n");
+        pci::ErsResult::Recovered
+    }
+
+    fn resume(pdev: &pci::Device<Bound>, _this: Pin<&Self::Driver>) {
+        dev_info!(pdev.as_ref(), "resume.\n");
+    }
+}
+
 #[pinned_drop]
 impl PinnedDrop for SampleDriver {
     fn drop(self: Pin<&mut Self>) {
-- 
2.43.0


