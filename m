Return-Path: <linux-pci+bounces-32279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C147FB07914
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 17:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12BD0172B1B
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 15:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6324128D82F;
	Wed, 16 Jul 2025 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuaDUPA1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3808E20F09C;
	Wed, 16 Jul 2025 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678270; cv=none; b=RAE+c1o1eegOLrz1rLRQba1HzhYmhDiPEynSn7BckMNMG/iXxuS0KJvobRaZ8icNNkMzAkHqlhejWXZOzexQQf7DzdarGeSzNh7sKmYKiELSNHjXalwRk0S7Rr01ou6DKVsEmLBxS9abrr3N1Lh3Xw2aI1KOzVSH6hjSKZl9DYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678270; c=relaxed/simple;
	bh=8YbmoICxDHq8BmA5AG+ttKnGA2bK0YMKDQUYjpfZl1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fva0dseTIhYMm0v6xDtm50pjYSc85aXyrXQS/mOyr+OhFcc34xWhln5qwxt+FTXlPMHUEqiBT7iZFaqI/0/r/bveL/zhFkzOggqQ/SFK9aBttfe/Y57ZERMVuSoureuDEW4wHIVxVV3yNWUxEQsl3RDd4Nbg0E/ZLPzfDPHBOBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuaDUPA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6643C4CEEB;
	Wed, 16 Jul 2025 15:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752678269;
	bh=8YbmoICxDHq8BmA5AG+ttKnGA2bK0YMKDQUYjpfZl1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TuaDUPA1RMXdRBoIH8EMUk/TxGAcdmpsHj8SlaUxRHh1igaFiYJvrVW0YSAInybi7
	 DlAinAnB2yF3zZn4L4BtKJTYCgnEenmV8M5VQGiiEQMYNP3RctDsZGTqC92d61p6JH
	 ie9Ubq/hAJ0XfcogZE+SoyHlAtIllk6Pn0p4pJYcYifbvr9TLWmcu1DwJhCuqTagJi
	 rn2vVraS2y4G+JS4zN7WW7AaBo414b8waeFanCIF/iKesledQf++rjMycgOGxHsSCL
	 VMgCunhPLo5Ptb8h+X3kB7YiPsiWOr05BWa3FGqFPnd+s2xox3yc1ge3l2VnpCs5N5
	 3UPnVf7Z+gX6w==
From: Danilo Krummrich <dakr@kernel.org>
To: abdiel.janulgue@gmail.com,
	daniel.almeida@collabora.com,
	robin.murphy@arm.com,
	a.hindborg@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 5/5] rust: samples: dma: set DMA mask
Date: Wed, 16 Jul 2025 17:02:50 +0200
Message-ID: <20250716150354.51081-6-dakr@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716150354.51081-1-dakr@kernel.org>
References: <20250716150354.51081-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set a DMA mask for the `pci::Device` in the Rust DMA sample driver.

Reviewed-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 samples/rust/rust_dma.rs | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 9e05d5c0cdae..9422ac68c139 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -4,7 +4,14 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{bindings, device::Core, dma::CoherentAllocation, pci, prelude::*, types::ARef};
+use kernel::{
+    bindings,
+    device::Core,
+    dma::{CoherentAllocation, Device, DmaMask},
+    pci,
+    prelude::*,
+    types::ARef,
+};
 
 struct DmaSampleDriver {
     pdev: ARef<pci::Device>,
@@ -51,6 +58,11 @@ impl pci::Driver for DmaSampleDriver {
     fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
         dev_info!(pdev.as_ref(), "Probe DMA test driver.\n");
 
+        let mask = DmaMask::new(64)?;
+
+        // SAFETY: There are no concurrent calls to DMA allocation and mapping primitives.
+        unsafe { pdev.dma_set_mask_and_coherent(mask)? };
+
         let ca: CoherentAllocation<MyStruct> =
             CoherentAllocation::alloc_coherent(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
 
-- 
2.50.0


