Return-Path: <linux-pci+bounces-31886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 442F1B00C42
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 21:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114C41CA56CD
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 19:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16652FD86A;
	Thu, 10 Jul 2025 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtpoAfy3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F6B28981F;
	Thu, 10 Jul 2025 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752176776; cv=none; b=PWq/7/wDeFVFjcy2gltIlN/3s5JuJqJbFAv+AxgbatD6v2Ta3vWItNPT1LP+DQAygbMlfxSCc1ZaLqKWp01+q6TjHFQIvBShuRXXjaBRizRhDn2ZOzMajiQU24o/bQCChZV3PaZnNrozSx6hwFjyhl8swy0wbEjSrefnFpaH7mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752176776; c=relaxed/simple;
	bh=TnZRiss20aC4t2yXVpyKvLnTYtDXtNPoRmXyKVx2/hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PiIYYrzqjAxLNLZLK641dk+PKwPa51Ub0roBiNoUkZyZaKXzor6VA6Svx5eVHE+c7HzOqQ5o8cjazU8aa/7TB/XXooMXa4c7uP2mxx96mpH669b0vAe0/IkcVAQlhEqEd/wehDvvQW4y0mx8t3uNo5ObP7ZT1Pg8cH67eNyyKeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtpoAfy3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69779C4CEF1;
	Thu, 10 Jul 2025 19:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752176776;
	bh=TnZRiss20aC4t2yXVpyKvLnTYtDXtNPoRmXyKVx2/hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PtpoAfy3oj/6amUWRybJjQ5UWRLCIpu7RDdmvigvBr8Foo8m7K0fON6zcpJWqwMus
	 QaiT5eeRSoxXDZ3OpMjy7SZXb2Httu19DuWa9lzcOQiYeYPGOyKteMlA537ZchFUG7
	 yF3NOrsBHdPOACTeNJa3RfbY4FOsNSXOgGe6ylNVCIrDiOg8dHZSQye827IJ3OyJLY
	 KLVaKuW1YEx/fNK6gYFBkMfC1pljPQx+eoh+ADYLp1Qz/leA2+JdhvkMEvh8MBsI47
	 6IDubluyX+mOU8vl7dc+gL1Y0KvmBY6ovDO83YlDUzKwFJP28mdSZRyG13S85hkVLB
	 KRboFTpsxd+AQ==
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
Subject: [PATCH 2/5] rust: dma: add DMA addressing capabilities
Date: Thu, 10 Jul 2025 21:45:44 +0200
Message-ID: <20250710194556.62605-3-dakr@kernel.org>
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

Implement `dma_set_mask()`, `dma_set_coherent_mask()` and
`dma_set_mask_and_coherent()` in the `dma::Device` trait.

Those methods are used to set up the device's DMA addressing
capabilities.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers/dma.c |  5 +++
 rust/kernel/dma.rs | 82 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/rust/helpers/dma.c b/rust/helpers/dma.c
index df8b8a77355a..6e741c197242 100644
--- a/rust/helpers/dma.c
+++ b/rust/helpers/dma.c
@@ -14,3 +14,8 @@ void rust_helper_dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 {
 	dma_free_attrs(dev, size, cpu_addr, dma_handle, attrs);
 }
+
+int rust_helper_dma_set_mask_and_coherent(struct device *dev, u64 mask)
+{
+	return dma_set_mask_and_coherent(dev, mask);
+}
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index f0af23d08e8d..4b27b8279941 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -6,9 +6,9 @@
 
 use crate::{
     bindings, build_assert, device,
-    device::Bound,
+    device::{Bound, Core},
     error::code::*,
-    error::Result,
+    error::{to_result, Result},
     transmute::{AsBytes, FromBytes},
     types::ARef,
 };
@@ -18,7 +18,83 @@
 /// The [`dma::Device`](Device) trait should be implemented by bus specific device representations,
 /// where the underlying bus is DMA capable, such as [`pci::Device`](::kernel::pci::Device) or
 /// [`platform::Device`](::kernel::platform::Device).
-pub trait Device: AsRef<device::Device<Core>> {}
+pub trait Device: AsRef<device::Device<Core>> {
+    /// Set up the device's DMA streaming addressing capabilities.
+    ///
+    /// This method is usually called once from `probe()` as soon as the device capabilities are
+    /// known.
+    ///
+    /// # Safety
+    ///
+    /// This method must not be called concurrently with any DMA allocation or mapping primitives,
+    /// such as [`CoherentAllocation::alloc_attrs`].
+    unsafe fn dma_set_mask(&self, mask: u64) -> Result {
+        // SAFETY:
+        // - By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
+        // - The safety requirement of this function guarantees that there are no concurrent calls
+        //   to DMA allocation and mapping primitives using this mask.
+        to_result(unsafe { bindings::dma_set_mask(self.as_ref().as_raw(), mask) })
+    }
+
+    /// Set up the device's DMA coherent addressing capabilities.
+    ///
+    /// This method is usually called once from `probe()` as soon as the device capabilities are
+    /// known.
+    ///
+    /// # Safety
+    ///
+    /// This method must not be called concurrently with any DMA allocation or mapping primitives,
+    /// such as [`CoherentAllocation::alloc_attrs`].
+    unsafe fn dma_set_coherent_mask(&self, mask: u64) -> Result {
+        // SAFETY:
+        // - By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
+        // - The safety requirement of this function guarantees that there are no concurrent calls
+        //   to DMA allocation and mapping primitives using this mask.
+        to_result(unsafe { bindings::dma_set_coherent_mask(self.as_ref().as_raw(), mask) })
+    }
+
+    /// Set up the device's DMA addressing capabilities.
+    ///
+    /// This is a combination of [`Device::dma_set_mask`] and [`Device::dma_set_coherent_mask`].
+    ///
+    /// This method is usually called once from `probe()` as soon as the device capabilities are
+    /// known.
+    ///
+    /// # Safety
+    ///
+    /// This method must not be called concurrently with any DMA allocation or mapping primitives,
+    /// such as [`CoherentAllocation::alloc_attrs`].
+    unsafe fn dma_set_mask_and_coherent(&self, mask: u64) -> Result {
+        // SAFETY:
+        // - By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
+        // - The safety requirement of this function guarantees that there are no concurrent calls
+        //   to DMA allocation and mapping primitives using this mask.
+        to_result(unsafe { bindings::dma_set_mask_and_coherent(self.as_ref().as_raw(), mask) })
+    }
+}
+
+/// Returns a bitmask with the lowest `n` bits set to `1`.
+///
+/// For `n` in `0..=64`, returns a mask with the lowest `n` bits set.
+/// For `n > 64`, returns `u64::MAX` (all bits set).
+///
+/// # Examples
+///
+/// ```
+/// use kernel::dma::dma_bit_mask;
+///
+/// assert_eq!(dma_bit_mask(0), 0);
+/// assert_eq!(dma_bit_mask(1), 0b1);
+/// assert_eq!(dma_bit_mask(64), u64::MAX);
+/// assert_eq!(dma_bit_mask(100), u64::MAX); // Saturates at all bits set.
+/// ```
+pub const fn dma_bit_mask(n: usize) -> u64 {
+    match n {
+        0 => 0,
+        1..=64 => u64::MAX >> (64 - n),
+        _ => u64::MAX,
+    }
+}
 
 /// Possible attributes associated with a DMA mapping.
 ///
-- 
2.50.0


