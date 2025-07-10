Return-Path: <linux-pci+bounces-31889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B1BB00C4B
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 21:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7465487499
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 19:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E52E2FD893;
	Thu, 10 Jul 2025 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtgdAefa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3246F2FD889;
	Thu, 10 Jul 2025 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752176790; cv=none; b=U5MI6EsxQ5yQWkLsunfUd09H2H5BreElUN32uBTy7FBPlyP+XeNqmrggNJ/paYI5S+Tf6igDNf6iC2C84yN3J09QCr0CzxLC6kWcVCdqgOol8iY0IX7FBT4k4GCa8MRnwn1xsyYwXNA8om2rUdxo29OdUmFB8Lm6ZFcNo05tslY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752176790; c=relaxed/simple;
	bh=Y2jZgyG/X4B2hLyeKjERv+lNNYhceJlVSnkd7lE+GaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5CN4JNfh3uEH0Ltf0PbXPGIkgl4nhzfyL+MpY+7Pwa/sIXPgTwlTGOEFkaXwNVqG8BrMR+U/+SVtHM67OlfEbxBGETLlMYXM+JbdFW29/6TCUinZnfAUoFgavzOLLcJFLbIbG8gY0Rj4SAGZo3dRR0lquYbONOVsea55rl+PBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtgdAefa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61BFC4CEE3;
	Thu, 10 Jul 2025 19:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752176789;
	bh=Y2jZgyG/X4B2hLyeKjERv+lNNYhceJlVSnkd7lE+GaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HtgdAefaT7Ecs/25JhW14NOW/h/V0xIZAVRM+XxSA08cTljOq1RrwRHJwE1iIgbaS
	 Jvl7KTnTg7jwrxioqyHtLiDpgccCeguaTDmnX9Fkw2t9VW3O8zKHxNyfysyWeT6OE+
	 vDigOgE/F0OtxrnIOpRhn5vS0GAzfrPovh3wol8PG2i0BpaGBmtJvrogiZxfnBQ8aW
	 WwYtAokedgDDjx5phm4tKkKhqh+m3ura9CiB0DL/NUoG36brX7zFQPanBdr9qq68a+
	 F9cDe5gbTjF85lpHLHusWlmBpa9vTFolykdugKchjQ9E+3zTllDWzvaxG2GA61cL+v
	 TbVxXjpHjS5zg==
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
Subject: [PATCH 5/5] rust: samples: dma: set DMA mask
Date: Thu, 10 Jul 2025 21:45:47 +0200
Message-ID: <20250710194556.62605-6-dakr@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710194556.62605-1-dakr@kernel.org>
References: <20250710194556.62605-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set a DMA mask for the `pci::Device` in the Rust DMA sample driver.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 samples/rust/rust_dma.rs | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 9e05d5c0cdae..b295c346252f 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -4,7 +4,14 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{bindings, device::Core, dma::CoherentAllocation, pci, prelude::*, types::ARef};
+use kernel::{
+    bindings,
+    device::Core,
+    dma::{CoherentAllocation, Device, dma_bit_mask},
+    pci,
+    prelude::*,
+    types::ARef,
+};
 
 struct DmaSampleDriver {
     pdev: ARef<pci::Device>,
@@ -51,6 +58,9 @@ impl pci::Driver for DmaSampleDriver {
     fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
         dev_info!(pdev.as_ref(), "Probe DMA test driver.\n");
 
+        // SAFETY: There are no concurrent calls to DMA allocation and mapping primitives.
+        unsafe { pdev.dma_set_mask_and_coherent(dma_bit_mask(64))? };
+
         let ca: CoherentAllocation<MyStruct> =
             CoherentAllocation::alloc_coherent(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
 
-- 
2.50.0


