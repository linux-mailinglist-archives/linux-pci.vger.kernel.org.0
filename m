Return-Path: <linux-pci+bounces-38647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EA7BEDE35
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 07:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EBB14E1C5A
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 05:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37A32557A;
	Sun, 19 Oct 2025 05:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0v079He"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A3721257F
	for <linux-pci@vger.kernel.org>; Sun, 19 Oct 2025 05:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760850010; cv=none; b=meqgsd6vr+H20iBctCMJQBTC2mSG9s/g3/uplsT4Vpm9K5oV2yYoKPQVqXYQZ1fEJzJCKSk9xlmESvnU0Rfb+rxDtPdGXA0HXj1p72kL+ojBOl0YH7jNrUmPLlquncQqiUnKNsMgdKBXBgml2P3vZ/zxa9+XvkIRT8Q+Vm5BV2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760850010; c=relaxed/simple;
	bh=o1PUC2wc1mAokO+mTBqq622zLzBZ0C7jG04WPD4ze+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fmzj2K8I0xozHlGZyoJ4IcyJfOeb+50X4SL5WnC4k0swVEPIlXyPUaQu0zh/Cibczjg4GzyKpZWxyUZMB5xyDVT6irdU+/UjlcqYBuCgdOuTfms3VX7EJKTCZbnR8OT+0kuNKwIiSJnWHmtvN5YqlmLV95xA4aNuFYmxl4Prmqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i0v079He; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760850008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6j42bXIK7vhHm/hVQ0KPPWv9prcOGiEtMxLoqJlyhY=;
	b=i0v079Hed/WgwvyK0cBqNP/HL3UEigF5cOzoESIJdnQS9gZFwXyuaHxCQXQFalSKOsMeIm
	d8X6bjf16t2cWrVnKYzRYP/5PGOx0BYgMx4XrI4G2vyPQJLtXBUdl1aIJYigv4142t3xT0
	yIo6YZ8VhynuBzcQPe6J0k1gD+cPxzU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-Vgtwr8vXO0ex_3KWttRRMg-1; Sun, 19 Oct 2025 01:00:06 -0400
X-MC-Unique: Vgtwr8vXO0ex_3KWttRRMg-1
X-Mimecast-MFC-AGG-ID: Vgtwr8vXO0ex_3KWttRRMg_1760850006
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-87c171369aaso142212456d6.0
        for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 22:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760850005; x=1761454805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6j42bXIK7vhHm/hVQ0KPPWv9prcOGiEtMxLoqJlyhY=;
        b=VBBR0zVCh7Ci1ygYIlgfA77RgOnQWJr9Ph8/tgfjutdalSs6CbrbGJ+mASPWLLWUQ3
         KJgbUXLazpaBKht74liWkpXejNVbtNMxOT5FsoTnN92xr87hsmdRJL+hps47/CdAMjDM
         01RknbvOQ7P9OTEzZB7Bp1+I/vfMvdLekIJiSSQTRigcJY+6xVzYyGiGEH+Tb53UCxAb
         yE/4PmnuN2LDBHhQPG81FbPxmFke/0+eJq7TwmdjN4o9z+J5KUh0EQAlZmXsuEraATOR
         T4kkN5RtmG2Pg+63TjvPIaF0fpHHB4pZkz0YGngSDU0SADUe/ecC+lPY3/45e1exBzQE
         0ysw==
X-Forwarded-Encrypted: i=1; AJvYcCXLb7nvBkE5D8UwRgfdwLTn9lrFpAemQsVrnOSUUZyKbNnpje1kKWBEJchyFEXjmo68nEuI8TSoXIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwUEsoFvLapmLoh8W4vhgU6WWZRcfdGQNwNuHffr5+K7uvx1Au
	rGwzwDNlVSYss+aqF6EzvvR/NQGZXid2/rEWuMukqVMi8mBVqV1n/FqQkxzILjpfg2Qb8qo/S1N
	qHJChgFeJ6+OqiL9PLloEtFWWo4HoGBQ2h2DIGsNBIYJXbbvqeTcgA3evg6wTwA==
X-Gm-Gg: ASbGnctulYKm30VDhQAQoyOj0tjbmnfLwzfqcHghwWNLRy3bPoSDUJLUcU65ZVIIdJB
	a+NbkHI8+zHiXcbVfUE8jyEpOIYze2N5kkc75WlnCDm9/RNe6LNKCzRsUsNmdC+vGf3EOD4KnxP
	J5r4jqsnAGzvIRvA/6Lfms7UHr5Bo0BFo89TBTN7liADD14MdeZ3xhX00P2YQva+PLBRlfAoxdM
	NogZqFChRTYL3MrKB+rO/3lHmdmPgGA3diz5uy9ROlcK3OnT14AYKX0PyAGda7QOauHOxeA1TmG
	39TfwKun8V1W+ri04JF3IqULFENAZdizL8yQbUY5314RATMYG6AHksNVcHygGxZqmLRf8n8KIGq
	Y8nONozMRkN+z
X-Received: by 2002:a05:6214:1c4e:b0:70f:b03d:2e85 with SMTP id 6a1803df08f44-87c202ca12cmr129730566d6.24.1760850005635;
        Sat, 18 Oct 2025 22:00:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5wLeuxoiCHUZOMNbVk/R58So9DiHQPQPxCkQ0dtuezAPPgfbIhF/Hy0u9hiLd/d1yjKIlOQ==
X-Received: by 2002:a05:6214:1c4e:b0:70f:b03d:2e85 with SMTP id 6a1803df08f44-87c202ca12cmr129730306d6.24.1760850005241;
        Sat, 18 Oct 2025 22:00:05 -0700 (PDT)
Received: from mira.orion.internal ([2607:f2c0:b0fc:be00:3640:bdf5:7a8:2136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028ad781sm27154396d6.49.2025.10.18.22.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 22:00:04 -0700 (PDT)
From: Peter Colberg <pcolberg@redhat.com>
To: Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Colberg <pcolberg@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH 1/2] rust: pci: refer to legacy as INTx interrupts
Date: Sun, 19 Oct 2025 04:56:19 +0000
Message-ID: <20251019045620.2080-2-pcolberg@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019045620.2080-1-pcolberg@redhat.com>
References: <20251019045620.2080-1-pcolberg@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consistently use INTx, as in the description of IrqType::Intx, to refer
to the four legacy PCI interrupts, INTA#, INTB#, INTC#, and INTD#.

Link: https://lore.kernel.org/rust-for-linux/20251015230209.GA960343@bhelgaas/
Link: https://github.com/Rust-for-Linux/linux/issues/1196
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Peter Colberg <pcolberg@redhat.com>
---
 rust/kernel/pci.rs | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index d91ec9f008ae..18f9b92a745e 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -56,7 +56,7 @@ const fn as_raw(self) -> u32 {
 pub struct IrqTypes(u32);
 
 impl IrqTypes {
-    /// Create a set containing all IRQ types (MSI-X, MSI, and Legacy).
+    /// Create a set containing all IRQ types (MSI-X, MSI, and INTx).
     pub const fn all() -> Self {
         Self(bindings::PCI_IRQ_ALL_TYPES)
     }
@@ -66,7 +66,7 @@ pub const fn all() -> Self {
     /// # Examples
     ///
     /// ```ignore
-    /// // Create a set with only MSI and MSI-X (no legacy interrupts).
+    /// // Create a set with only MSI and MSI-X (no INTx interrupts).
     /// let msi_only = IrqTypes::default()
     ///     .with(IrqType::Msi)
     ///     .with(IrqType::MsiX);
@@ -722,9 +722,9 @@ pub fn request_threaded_irq<'a, T: crate::irq::ThreadedHandler + 'static>(
     /// Allocate IRQ vectors for this PCI device with automatic cleanup.
     ///
     /// Allocates between `min_vecs` and `max_vecs` interrupt vectors for the device.
-    /// The allocation will use MSI-X, MSI, or legacy interrupts based on the `irq_types`
+    /// The allocation will use MSI-X, MSI, or INTx interrupts based on the `irq_types`
     /// parameter and hardware capabilities. When multiple types are specified, the kernel
-    /// will try them in order of preference: MSI-X first, then MSI, then legacy interrupts.
+    /// will try them in order of preference: MSI-X first, then MSI, then INTx interrupts.
     ///
     /// The allocated vectors are automatically freed when the device is unbound, using the
     /// devres (device resource management) system.
@@ -748,7 +748,7 @@ pub fn request_threaded_irq<'a, T: crate::irq::ThreadedHandler + 'static>(
     /// // Allocate using any available interrupt type in the order mentioned above.
     /// let vectors = dev.alloc_irq_vectors(1, 32, pci::IrqTypes::all())?;
     ///
-    /// // Allocate MSI or MSI-X only (no legacy interrupts).
+    /// // Allocate MSI or MSI-X only (no INTx interrupts).
     /// let msi_only = pci::IrqTypes::default()
     ///     .with(pci::IrqType::Msi)
     ///     .with(pci::IrqType::MsiX);
-- 
2.51.0


