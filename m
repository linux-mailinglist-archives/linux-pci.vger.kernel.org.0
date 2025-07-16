Return-Path: <linux-pci+bounces-32276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EB2B07900
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 17:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC78505857
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 15:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DE126FD8F;
	Wed, 16 Jul 2025 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhohAihk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A18C20F09C;
	Wed, 16 Jul 2025 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678256; cv=none; b=rdEwlVjhEfNKRmmgX5mLyuMpySF4U2yPb4vD3HXtQrh8H1cfkWcdqISfM7gXqJAwaU2T9n29vG2oetqJQ06cI4NKZNptTM/zNx0HdmrCD9eieJdK5T88IrPCxEmz3T4htaXBRGLwyT1szwTmZ7hF4URZ9nzJN3kG8fNpb9vIdiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678256; c=relaxed/simple;
	bh=Jm5T7wVKYwNR2zjbQ2WIR5doSI9DWAxN08adyYuf1CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPeXwkA7lwUmb/AxldBfFy7e4uBryApqGpO9voY1OeeNtGM/d00p9dM4YkjbzbhgoJlszjbyz6u2szAE3Djs9afT3crWRaCFW7uFYIsh3svFKYT58Sy1t/q/E1Ct76h1s8cOQlMxpa2w4gtxKXHhuM+sIz+Ubi1AONxfpV78oDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhohAihk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237E1C4CEEB;
	Wed, 16 Jul 2025 15:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752678256;
	bh=Jm5T7wVKYwNR2zjbQ2WIR5doSI9DWAxN08adyYuf1CE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WhohAihksFx6OOtIMBZKbF2jkPU9rlxI8d4iurjp/JHuSnbB6iL9bg6UNODiIZUKO
	 blcOI3CmG+HvsJL00yWrk1GGruV5ce3C2kjx8zPvr2FuYollvuw++v9Kph+SZIXGJm
	 d+rW1wEQE0/s9UQ54mBzIJYqgR6a4xnmRVb3458f0ZniioIohNHAzSWvYEJgB8n17Z
	 3Ddz+vpPrafKxSR8BxE8YP6b/Yo1FHQX3kMvELEUQElgc0woCY7H7jB4vTxnlOMJSz
	 8G/WdDO7G9HZyly7ggzbi0dpjI6BT8RqP1k/jX3upxjaLnjrRSq/pH+bEVgoVVnwXG
	 Ic2xDpdmuAqMQ==
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
Subject: [PATCH v2 2/5] rust: dma: add DMA addressing capabilities
Date: Wed, 16 Jul 2025 17:02:47 +0200
Message-ID: <20250716150354.51081-3-dakr@kernel.org>
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

Implement `dma_set_mask()`, `dma_set_coherent_mask()` and
`dma_set_mask_and_coherent()` in the `dma::Device` trait.

Those methods are used to set up the device's DMA addressing
capabilities.

Reviewed-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers/dma.c |   5 ++
 rust/kernel/dma.rs | 112 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 113 insertions(+), 4 deletions(-)

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
index f0af23d08e8d..afd3ba538e3c 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -6,9 +6,9 @@
 
 use crate::{
     bindings, build_assert, device,
-    device::Bound,
-    error::code::*,
-    error::Result,
+    device::{Bound, Core},
+    error::{to_result, Result},
+    prelude::*,
     transmute::{AsBytes, FromBytes},
     types::ARef,
 };
@@ -18,7 +18,111 @@
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
+    unsafe fn dma_set_mask(&self, mask: DmaMask) -> Result {
+        // SAFETY:
+        // - By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
+        // - The safety requirement of this function guarantees that there are no concurrent calls
+        //   to DMA allocation and mapping primitives using this mask.
+        to_result(unsafe { bindings::dma_set_mask(self.as_ref().as_raw(), mask.value()) })
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
+    unsafe fn dma_set_coherent_mask(&self, mask: DmaMask) -> Result {
+        // SAFETY:
+        // - By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
+        // - The safety requirement of this function guarantees that there are no concurrent calls
+        //   to DMA allocation and mapping primitives using this mask.
+        to_result(unsafe { bindings::dma_set_coherent_mask(self.as_ref().as_raw(), mask.value()) })
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
+    unsafe fn dma_set_mask_and_coherent(&self, mask: DmaMask) -> Result {
+        // SAFETY:
+        // - By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
+        // - The safety requirement of this function guarantees that there are no concurrent calls
+        //   to DMA allocation and mapping primitives using this mask.
+        to_result(unsafe {
+            bindings::dma_set_mask_and_coherent(self.as_ref().as_raw(), mask.value())
+        })
+    }
+}
+
+/// A DMA mask that holds a bitmask with the lowest `n` bits set.
+///
+/// Use [`DmaMask::new`] to construct a value. Values are guaranteed to
+/// never exceed the bit width of `u64`.
+///
+/// This is the Rust equivalent of the C macro `DMA_BIT_MASK()`.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::dma::DmaMask;
+///
+/// let mask0 = DmaMask::new(0)?;
+/// assert_eq!(mask0.value(), 0);
+///
+/// let mask1 = DmaMask::new(1)?;
+/// assert_eq!(mask1.value(), 0b1);
+///
+/// let mask64 = DmaMask::new(64)?;
+/// assert_eq!(mask64.value(), u64::MAX);
+///
+/// let mask_overflow = DmaMask::new(100);
+/// assert!(mask_overflow.is_err());
+/// # Ok::<(), Error>(())
+/// ```
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+pub struct DmaMask(u64);
+
+impl DmaMask {
+    /// Constructs a `DmaMask` with the lowest `n` bits set to `1`.
+    ///
+    /// For `n <= 64`, sets exactly the lowest `n` bits.
+    /// For `n > 64`, returns [`EINVAL`].
+    #[inline]
+    pub const fn new(n: usize) -> Result<Self> {
+        Ok(Self(match n {
+            0 => 0,
+            1..=64 => u64::MAX >> (64 - n),
+            _ => return Err(EINVAL),
+        }))
+    }
+
+    /// Returns the underlying `u64` bitmask value.
+    #[inline]
+    pub const fn value(&self) -> u64 {
+        self.0
+    }
+}
 
 /// Possible attributes associated with a DMA mapping.
 ///
-- 
2.50.0


