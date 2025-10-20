Return-Path: <linux-pci+bounces-38781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B893BF2982
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 19:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CFE464374
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 17:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CE52882B8;
	Mon, 20 Oct 2025 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtUjOhUc"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9E1330331
	for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979763; cv=none; b=AAJ2uAhg4ngK4OGV3UEaelUx5WWZ38SoFQrzuifwrFxlG5kXb/QQpv/gUpfKqpv7XJcc6GFLd25EEvRtyZEtOw8p25fFp/FhNURbJ8e74HpTaIpN+doi8zycIkHvt4FwI5ljwLu/SstslTepqKjYeWslpnXrgaskZaPp2kyvquk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979763; c=relaxed/simple;
	bh=2LnSxd8IsSBMktmXsQisK9Ua8Nh5zVfE16oGFwAyfeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nD0j3qBjUXLoUNAqH/tXFoL2dHh0bBu/VK9cV0HSCjVD78fAOQax/SB3gou4W2l4bLBTI+cxBNdzokGuXsXPg2XQE2EWpSzE61POpXuoYBc0ym2SOGa/Cm9CcXX1KLMy23Y32qdRMZCEOBUcuNQ3h3j8h1hdnY0Z8YsINwpi3qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DtUjOhUc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760979761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPHWjPU7CSeWAPvAVmCEF3sPJBT3JRDvDSv/YcuLtGk=;
	b=DtUjOhUcZgvy/8baATdaYG6ZrKXsatzPnBag0VwLZLPoYTPXbd8/DIpr3/PVcuY8nCFTEC
	RLNtWhaUk5KDNFrXqV/vhgBdubz5OBCGciZojsXdrgjHiRzBWaeWwNLdtyXJRtI9Gs2zrY
	kYOjIrveykuoPK/AEbA3PI+vlXvfmms=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-O7yw1hXnPQ6dd2OuQr2t1w-1; Mon, 20 Oct 2025 13:02:39 -0400
X-MC-Unique: O7yw1hXnPQ6dd2OuQr2t1w-1
X-Mimecast-MFC-AGG-ID: O7yw1hXnPQ6dd2OuQr2t1w_1760979759
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-88e91599ee5so1141659385a.1
        for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 10:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979759; x=1761584559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPHWjPU7CSeWAPvAVmCEF3sPJBT3JRDvDSv/YcuLtGk=;
        b=RFjJ7b+PM2SsYhYGg9avqWh6dQb1Oe2CrcLHoKd9TCcqUXXrU5Qoz9/1gCVgMI70UL
         9eFZ6JLqHLBsoWve7EqR1HJTP0N5ove7spJTQB9x8gnlC8VzU7iQhAat3+mWx2bnbjdd
         nfFh1koj6zDhHP+rIhbZXE/htC7MRt22cf5ZalZPbigK1Gl0N/8V+md5uOrVrt34/Bv6
         5iROrh2H+9yYwGH7sKFq4x0LyfSIqwPvjxQMsCloD1g+e4GiB02T1KhUxjsZ4Rz0MVbs
         sqR6TAhmPuKo4QY1+gZlx7IZd2/TCZOXT3VCA0wgha8zhv0EXi7tdJSv8EztRO7EHiTe
         Q9hg==
X-Forwarded-Encrypted: i=1; AJvYcCXH3illxSeIvfal+f/zn2NsgoDlw+llKD2RcEQFwulczBjsA3M5q2ODTB55kKLH7/LGwkIe0i9oYrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiY3sao42TpQFF6YpXQaapSVciQrQWAdYAiEuV2SpUsqhXsZmP
	vc6wshyoosvWyt/7yxZMv43pKSrN6abLwQnsH8q/PK9UJhiiR4luWFxcvgzNYKlNNSPyJNw2iw4
	LqsXmubgaV/MrgpNGpKZ0Ldr8DJsGq997FPwVT1/vefvQNmUFGM1GTVRsRJeKtA==
X-Gm-Gg: ASbGncuqv48s+QyVsyZ3BzOC605V366/3xP6NxAjFmhTnzy1xufSOXtkiotmackrEWx
	txNsFZPZXQj/np/i2/d2jchcxtAA8n8VrcEsme7m2fAh4tovVmj1lMKF2Kklyz5BVPF1Z5HozAQ
	vIrnhTEL3tCrpVsP1PNV8BAnS9Y3aMUvzom5JneT4UNeDcagjDN/oti1HS0nAe7lJprKmHG2brh
	2IUSgoTSx1jQm8FW9HJKGi/PVcjixNCKLjwXWQ6wx+Jqc7bNGaDnvNSfmcvMAFUBAktznU2TU88
	Ll100jkIhd6oIcrnPEz75DBTirFQ8seNJL+8/ZPYr8i6WN3CN4S9FjFQ6dp91EwpMTSnQ1vZTrQ
	ckcHQts95e5w8
X-Received: by 2002:a05:620a:2953:b0:883:c768:200a with SMTP id af79cd13be357-8906f070ddemr1518992185a.32.1760979759129;
        Mon, 20 Oct 2025 10:02:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmqI8q2sxX0OqdFQA9RfZOPmOaiGltBS+T2wF8uSl77apdARqCViHFxEfhEVCuf8S2A/soVA==
X-Received: by 2002:a05:620a:2953:b0:883:c768:200a with SMTP id af79cd13be357-8906f070ddemr1518987085a.32.1760979758565;
        Mon, 20 Oct 2025 10:02:38 -0700 (PDT)
Received: from mira.orion.internal ([2607:f2c0:b0fc:be00:3640:bdf5:7a8:2136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cf58eecbsm589945985a.49.2025.10.20.10.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:02:38 -0700 (PDT)
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
Subject: [PATCH v2 1/2] rust: pci: refer to legacy as INTx interrupts
Date: Mon, 20 Oct 2025 17:02:22 +0000
Message-ID: <20251020170223.573769-2-pcolberg@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020170223.573769-1-pcolberg@redhat.com>
References: <20251020170223.573769-1-pcolberg@redhat.com>
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
v2:
- Rebase onto driver-core-testing to follow "Rust PCI housekeeping"
  patches, which move I/O and IRQ specific code into sub-modules.
---
 rust/kernel/pci/irq.rs | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
index 77235c271876..782a524fe11c 100644
--- a/rust/kernel/pci/irq.rs
+++ b/rust/kernel/pci/irq.rs
@@ -42,7 +42,7 @@ const fn as_raw(self) -> u32 {
 pub struct IrqTypes(u32);
 
 impl IrqTypes {
-    /// Create a set containing all IRQ types (MSI-X, MSI, and Legacy).
+    /// Create a set containing all IRQ types (MSI-X, MSI, and INTx).
     pub const fn all() -> Self {
         Self(bindings::PCI_IRQ_ALL_TYPES)
     }
@@ -52,7 +52,7 @@ pub const fn all() -> Self {
     /// # Examples
     ///
     /// ```ignore
-    /// // Create a set with only MSI and MSI-X (no legacy interrupts).
+    /// // Create a set with only MSI and MSI-X (no INTx interrupts).
     /// let msi_only = IrqTypes::default()
     ///     .with(IrqType::Msi)
     ///     .with(IrqType::MsiX);
@@ -199,9 +199,9 @@ pub fn request_threaded_irq<'a, T: crate::irq::ThreadedHandler + 'static>(
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
@@ -225,7 +225,7 @@ pub fn request_threaded_irq<'a, T: crate::irq::ThreadedHandler + 'static>(
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


