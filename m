Return-Path: <linux-pci+bounces-38254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0F4BE02A6
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 20:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E446C4827EB
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 18:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231B9340DAF;
	Wed, 15 Oct 2025 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugTwX8lv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE94340DA9;
	Wed, 15 Oct 2025 18:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552506; cv=none; b=q/YSJzaKLR99x2PBb/rVWgRocHBIONO8xc4cur37CmY9L80PXIpaG60QIJ/48D2kRK5b4UpoxqsOABzhIYGTsGJ2oGTss1A/uaYyFk7GrOYPrywQG3QJ4Gp0aCjgUspkcgamNpfhoqbcGueVb1/dzDen1tFw96vFd66bO/ToJQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552506; c=relaxed/simple;
	bh=Q/flZqlx/5pQas2MrOF/QlCi1+4kadGxmZ0Uiqzy8zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enMMERSQTdwz0INhJypQUjpWs38zGOkM8AL70bAY8nIv96HZFTx+bo+TUwrZNuPI4VW6+N88XnkWzLMG/hD6ITc+7K40UBMkCCGoCF/bR6tDRmEI4qqzQHBBD/1t7zN9KEUlHD3bq7qnZY5vcF67GaiYDUat3ZNP+xV5J4itYBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugTwX8lv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D27EC4AF54;
	Wed, 15 Oct 2025 18:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760552505;
	bh=Q/flZqlx/5pQas2MrOF/QlCi1+4kadGxmZ0Uiqzy8zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ugTwX8lvmfxZ5Yox6didCOMDl+YMaEVC6hzEx2olu7gE4O9/qD0mvAEJSZGffUqRB
	 bn2mZjXzTzjudasngxBsPR3nBreFOMqgZiRo+53k8xnP6w/DCFO0FYw/EtmWqQDUut
	 2YQOgHgd9206ZJ0KLbUZ25CquuRT+YsHeIpsAUxhzbgA1o1ny9c2A0kPXNWuAia1m3
	 AagFFLcfPdKvrkcB2Eg+fImvBdEtduv22A7Spe1SAiiP3poOnJH9vJxt/vATtDGMOK
	 vyz8pjtDX/gelVDz34MLK41AFnxk4dxtE6BUXc2aog3yr4MrYRQuzTnpV0PK3zwlNw
	 w1ePaXljXB0RA==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
	kwilczynski@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Cc: rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 3/3] rust: pci: move IRQ infrastructure to separate file
Date: Wed, 15 Oct 2025 20:14:31 +0200
Message-ID: <20251015182118.106604-4-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015182118.106604-1-dakr@kernel.org>
References: <20251015182118.106604-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the PCI interrupt infrastructure to a separate sub-module in order
to keep things organized.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs     | 236 +--------------------------------------
 rust/kernel/pci/irq.rs | 244 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 247 insertions(+), 233 deletions(-)
 create mode 100644 rust/kernel/pci/irq.rs

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index ed9d8619f944..ce612c9b7b56 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -6,80 +6,26 @@
 
 use crate::{
     bindings, container_of, device,
-    device::Bound,
     device_id::{RawDeviceId, RawDeviceIdIndex},
-    devres, driver,
+    driver,
     error::{from_result, to_result, Result},
-    irq::{self, IrqRequest},
     str::CStr,
-    sync::aref::ARef,
     types::Opaque,
     ThisModule,
 };
 use core::{
     marker::PhantomData,
-    ops::RangeInclusive,
     ptr::{addr_of_mut, NonNull},
 };
 use kernel::prelude::*;
 
 mod id;
 mod io;
+mod irq;
 
 pub use self::id::{Class, ClassMask, Vendor};
 pub use self::io::Bar;
-
-/// IRQ type flags for PCI interrupt allocation.
-#[derive(Debug, Clone, Copy)]
-pub enum IrqType {
-    /// INTx interrupts.
-    Intx,
-    /// Message Signaled Interrupts (MSI).
-    Msi,
-    /// Extended Message Signaled Interrupts (MSI-X).
-    MsiX,
-}
-
-impl IrqType {
-    /// Convert to the corresponding kernel flags.
-    const fn as_raw(self) -> u32 {
-        match self {
-            IrqType::Intx => bindings::PCI_IRQ_INTX,
-            IrqType::Msi => bindings::PCI_IRQ_MSI,
-            IrqType::MsiX => bindings::PCI_IRQ_MSIX,
-        }
-    }
-}
-
-/// Set of IRQ types that can be used for PCI interrupt allocation.
-#[derive(Debug, Clone, Copy, Default)]
-pub struct IrqTypes(u32);
-
-impl IrqTypes {
-    /// Create a set containing all IRQ types (MSI-X, MSI, and Legacy).
-    pub const fn all() -> Self {
-        Self(bindings::PCI_IRQ_ALL_TYPES)
-    }
-
-    /// Build a set of IRQ types.
-    ///
-    /// # Examples
-    ///
-    /// ```ignore
-    /// // Create a set with only MSI and MSI-X (no legacy interrupts).
-    /// let msi_only = IrqTypes::default()
-    ///     .with(IrqType::Msi)
-    ///     .with(IrqType::MsiX);
-    /// ```
-    pub const fn with(self, irq_type: IrqType) -> Self {
-        Self(self.0 | irq_type.as_raw())
-    }
-
-    /// Get the raw flags value.
-    const fn as_raw(self) -> u32 {
-        self.0
-    }
-}
+pub use self::irq::{IrqType, IrqTypes, IrqVector};
 
 /// An adapter for the registration of PCI drivers.
 pub struct Adapter<T: Driver>(T);
@@ -463,182 +409,6 @@ pub fn pci_class(&self) -> Class {
     }
 }
 
-/// Represents an allocated IRQ vector for a specific PCI device.
-///
-/// This type ties an IRQ vector to the device it was allocated for,
-/// ensuring the vector is only used with the correct device.
-#[derive(Clone, Copy)]
-pub struct IrqVector<'a> {
-    dev: &'a Device<Bound>,
-    index: u32,
-}
-
-impl<'a> IrqVector<'a> {
-    /// Creates a new [`IrqVector`] for the given device and index.
-    ///
-    /// # Safety
-    ///
-    /// - `index` must be a valid IRQ vector index for `dev`.
-    /// - `dev` must point to a [`Device`] that has successfully allocated IRQ vectors.
-    unsafe fn new(dev: &'a Device<Bound>, index: u32) -> Self {
-        Self { dev, index }
-    }
-
-    /// Returns the raw vector index.
-    fn index(&self) -> u32 {
-        self.index
-    }
-}
-
-impl<'a> TryInto<IrqRequest<'a>> for IrqVector<'a> {
-    type Error = Error;
-
-    fn try_into(self) -> Result<IrqRequest<'a>> {
-        // SAFETY: `self.as_raw` returns a valid pointer to a `struct pci_dev`.
-        let irq = unsafe { bindings::pci_irq_vector(self.dev.as_raw(), self.index()) };
-        if irq < 0 {
-            return Err(crate::error::Error::from_errno(irq));
-        }
-        // SAFETY: `irq` is guaranteed to be a valid IRQ number for `&self`.
-        Ok(unsafe { IrqRequest::new(self.dev.as_ref(), irq as u32) })
-    }
-}
-
-/// Represents an IRQ vector allocation for a PCI device.
-///
-/// This type ensures that IRQ vectors are properly allocated and freed by
-/// tying the allocation to the lifetime of this registration object.
-///
-/// # Invariants
-///
-/// The [`Device`] has successfully allocated IRQ vectors.
-struct IrqVectorRegistration {
-    dev: ARef<Device>,
-}
-
-impl IrqVectorRegistration {
-    /// Allocate and register IRQ vectors for the given PCI device.
-    ///
-    /// Allocates IRQ vectors and registers them with devres for automatic cleanup.
-    /// Returns a range of valid IRQ vectors.
-    fn register<'a>(
-        dev: &'a Device<Bound>,
-        min_vecs: u32,
-        max_vecs: u32,
-        irq_types: IrqTypes,
-    ) -> Result<RangeInclusive<IrqVector<'a>>> {
-        // SAFETY:
-        // - `dev.as_raw()` is guaranteed to be a valid pointer to a `struct pci_dev`
-        //   by the type invariant of `Device`.
-        // - `pci_alloc_irq_vectors` internally validates all other parameters
-        //   and returns error codes.
-        let ret = unsafe {
-            bindings::pci_alloc_irq_vectors(dev.as_raw(), min_vecs, max_vecs, irq_types.as_raw())
-        };
-
-        to_result(ret)?;
-        let count = ret as u32;
-
-        // SAFETY:
-        // - `pci_alloc_irq_vectors` returns the number of allocated vectors on success.
-        // - Vectors are 0-based, so valid indices are [0, count-1].
-        // - `pci_alloc_irq_vectors` guarantees `count >= min_vecs > 0`, so both `0` and
-        //   `count - 1` are valid IRQ vector indices for `dev`.
-        let range = unsafe { IrqVector::new(dev, 0)..=IrqVector::new(dev, count - 1) };
-
-        // INVARIANT: The IRQ vector allocation for `dev` above was successful.
-        let irq_vecs = Self { dev: dev.into() };
-        devres::register(dev.as_ref(), irq_vecs, GFP_KERNEL)?;
-
-        Ok(range)
-    }
-}
-
-impl Drop for IrqVectorRegistration {
-    fn drop(&mut self) {
-        // SAFETY:
-        // - By the type invariant, `self.dev.as_raw()` is a valid pointer to a `struct pci_dev`.
-        // - `self.dev` has successfully allocated IRQ vectors.
-        unsafe { bindings::pci_free_irq_vectors(self.dev.as_raw()) };
-    }
-}
-
-impl Device<device::Bound> {
-    /// Returns a [`kernel::irq::Registration`] for the given IRQ vector.
-    pub fn request_irq<'a, T: crate::irq::Handler + 'static>(
-        &'a self,
-        vector: IrqVector<'a>,
-        flags: irq::Flags,
-        name: &'static CStr,
-        handler: impl PinInit<T, Error> + 'a,
-    ) -> Result<impl PinInit<irq::Registration<T>, Error> + 'a> {
-        let request = vector.try_into()?;
-
-        Ok(irq::Registration::<T>::new(request, flags, name, handler))
-    }
-
-    /// Returns a [`kernel::irq::ThreadedRegistration`] for the given IRQ vector.
-    pub fn request_threaded_irq<'a, T: crate::irq::ThreadedHandler + 'static>(
-        &'a self,
-        vector: IrqVector<'a>,
-        flags: irq::Flags,
-        name: &'static CStr,
-        handler: impl PinInit<T, Error> + 'a,
-    ) -> Result<impl PinInit<irq::ThreadedRegistration<T>, Error> + 'a> {
-        let request = vector.try_into()?;
-
-        Ok(irq::ThreadedRegistration::<T>::new(
-            request, flags, name, handler,
-        ))
-    }
-
-    /// Allocate IRQ vectors for this PCI device with automatic cleanup.
-    ///
-    /// Allocates between `min_vecs` and `max_vecs` interrupt vectors for the device.
-    /// The allocation will use MSI-X, MSI, or legacy interrupts based on the `irq_types`
-    /// parameter and hardware capabilities. When multiple types are specified, the kernel
-    /// will try them in order of preference: MSI-X first, then MSI, then legacy interrupts.
-    ///
-    /// The allocated vectors are automatically freed when the device is unbound, using the
-    /// devres (device resource management) system.
-    ///
-    /// # Arguments
-    ///
-    /// * `min_vecs` - Minimum number of vectors required.
-    /// * `max_vecs` - Maximum number of vectors to allocate.
-    /// * `irq_types` - Types of interrupts that can be used.
-    ///
-    /// # Returns
-    ///
-    /// Returns a range of IRQ vectors that were successfully allocated, or an error if the
-    /// allocation fails or cannot meet the minimum requirement.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// # use kernel::{ device::Bound, pci};
-    /// # fn no_run(dev: &pci::Device<Bound>) -> Result {
-    /// // Allocate using any available interrupt type in the order mentioned above.
-    /// let vectors = dev.alloc_irq_vectors(1, 32, pci::IrqTypes::all())?;
-    ///
-    /// // Allocate MSI or MSI-X only (no legacy interrupts).
-    /// let msi_only = pci::IrqTypes::default()
-    ///     .with(pci::IrqType::Msi)
-    ///     .with(pci::IrqType::MsiX);
-    /// let vectors = dev.alloc_irq_vectors(4, 16, msi_only)?;
-    /// # Ok(())
-    /// # }
-    /// ```
-    pub fn alloc_irq_vectors(
-        &self,
-        min_vecs: u32,
-        max_vecs: u32,
-        irq_types: IrqTypes,
-    ) -> Result<RangeInclusive<IrqVector<'_>>> {
-        IrqVectorRegistration::register(self, min_vecs, max_vecs, irq_types)
-    }
-}
-
 impl Device<device::Core> {
     /// Enable memory resources for this device.
     pub fn enable_device_mem(&self) -> Result {
diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
new file mode 100644
index 000000000000..77235c271876
--- /dev/null
+++ b/rust/kernel/pci/irq.rs
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! PCI interrupt infrastructure.
+
+use super::Device;
+use crate::{
+    bindings, device,
+    device::Bound,
+    devres,
+    error::{to_result, Result},
+    irq::{self, IrqRequest},
+    str::CStr,
+    sync::aref::ARef,
+};
+use core::ops::RangeInclusive;
+use kernel::prelude::*;
+
+/// IRQ type flags for PCI interrupt allocation.
+#[derive(Debug, Clone, Copy)]
+pub enum IrqType {
+    /// INTx interrupts.
+    Intx,
+    /// Message Signaled Interrupts (MSI).
+    Msi,
+    /// Extended Message Signaled Interrupts (MSI-X).
+    MsiX,
+}
+
+impl IrqType {
+    /// Convert to the corresponding kernel flags.
+    const fn as_raw(self) -> u32 {
+        match self {
+            IrqType::Intx => bindings::PCI_IRQ_INTX,
+            IrqType::Msi => bindings::PCI_IRQ_MSI,
+            IrqType::MsiX => bindings::PCI_IRQ_MSIX,
+        }
+    }
+}
+
+/// Set of IRQ types that can be used for PCI interrupt allocation.
+#[derive(Debug, Clone, Copy, Default)]
+pub struct IrqTypes(u32);
+
+impl IrqTypes {
+    /// Create a set containing all IRQ types (MSI-X, MSI, and Legacy).
+    pub const fn all() -> Self {
+        Self(bindings::PCI_IRQ_ALL_TYPES)
+    }
+
+    /// Build a set of IRQ types.
+    ///
+    /// # Examples
+    ///
+    /// ```ignore
+    /// // Create a set with only MSI and MSI-X (no legacy interrupts).
+    /// let msi_only = IrqTypes::default()
+    ///     .with(IrqType::Msi)
+    ///     .with(IrqType::MsiX);
+    /// ```
+    pub const fn with(self, irq_type: IrqType) -> Self {
+        Self(self.0 | irq_type.as_raw())
+    }
+
+    /// Get the raw flags value.
+    const fn as_raw(self) -> u32 {
+        self.0
+    }
+}
+
+/// Represents an allocated IRQ vector for a specific PCI device.
+///
+/// This type ties an IRQ vector to the device it was allocated for,
+/// ensuring the vector is only used with the correct device.
+#[derive(Clone, Copy)]
+pub struct IrqVector<'a> {
+    dev: &'a Device<Bound>,
+    index: u32,
+}
+
+impl<'a> IrqVector<'a> {
+    /// Creates a new [`IrqVector`] for the given device and index.
+    ///
+    /// # Safety
+    ///
+    /// - `index` must be a valid IRQ vector index for `dev`.
+    /// - `dev` must point to a [`Device`] that has successfully allocated IRQ vectors.
+    unsafe fn new(dev: &'a Device<Bound>, index: u32) -> Self {
+        Self { dev, index }
+    }
+
+    /// Returns the raw vector index.
+    fn index(&self) -> u32 {
+        self.index
+    }
+}
+
+impl<'a> TryInto<IrqRequest<'a>> for IrqVector<'a> {
+    type Error = Error;
+
+    fn try_into(self) -> Result<IrqRequest<'a>> {
+        // SAFETY: `self.as_raw` returns a valid pointer to a `struct pci_dev`.
+        let irq = unsafe { bindings::pci_irq_vector(self.dev.as_raw(), self.index()) };
+        if irq < 0 {
+            return Err(crate::error::Error::from_errno(irq));
+        }
+        // SAFETY: `irq` is guaranteed to be a valid IRQ number for `&self`.
+        Ok(unsafe { IrqRequest::new(self.dev.as_ref(), irq as u32) })
+    }
+}
+
+/// Represents an IRQ vector allocation for a PCI device.
+///
+/// This type ensures that IRQ vectors are properly allocated and freed by
+/// tying the allocation to the lifetime of this registration object.
+///
+/// # Invariants
+///
+/// The [`Device`] has successfully allocated IRQ vectors.
+struct IrqVectorRegistration {
+    dev: ARef<Device>,
+}
+
+impl IrqVectorRegistration {
+    /// Allocate and register IRQ vectors for the given PCI device.
+    ///
+    /// Allocates IRQ vectors and registers them with devres for automatic cleanup.
+    /// Returns a range of valid IRQ vectors.
+    fn register<'a>(
+        dev: &'a Device<Bound>,
+        min_vecs: u32,
+        max_vecs: u32,
+        irq_types: IrqTypes,
+    ) -> Result<RangeInclusive<IrqVector<'a>>> {
+        // SAFETY:
+        // - `dev.as_raw()` is guaranteed to be a valid pointer to a `struct pci_dev`
+        //   by the type invariant of `Device`.
+        // - `pci_alloc_irq_vectors` internally validates all other parameters
+        //   and returns error codes.
+        let ret = unsafe {
+            bindings::pci_alloc_irq_vectors(dev.as_raw(), min_vecs, max_vecs, irq_types.as_raw())
+        };
+
+        to_result(ret)?;
+        let count = ret as u32;
+
+        // SAFETY:
+        // - `pci_alloc_irq_vectors` returns the number of allocated vectors on success.
+        // - Vectors are 0-based, so valid indices are [0, count-1].
+        // - `pci_alloc_irq_vectors` guarantees `count >= min_vecs > 0`, so both `0` and
+        //   `count - 1` are valid IRQ vector indices for `dev`.
+        let range = unsafe { IrqVector::new(dev, 0)..=IrqVector::new(dev, count - 1) };
+
+        // INVARIANT: The IRQ vector allocation for `dev` above was successful.
+        let irq_vecs = Self { dev: dev.into() };
+        devres::register(dev.as_ref(), irq_vecs, GFP_KERNEL)?;
+
+        Ok(range)
+    }
+}
+
+impl Drop for IrqVectorRegistration {
+    fn drop(&mut self) {
+        // SAFETY:
+        // - By the type invariant, `self.dev.as_raw()` is a valid pointer to a `struct pci_dev`.
+        // - `self.dev` has successfully allocated IRQ vectors.
+        unsafe { bindings::pci_free_irq_vectors(self.dev.as_raw()) };
+    }
+}
+
+impl Device<device::Bound> {
+    /// Returns a [`kernel::irq::Registration`] for the given IRQ vector.
+    pub fn request_irq<'a, T: crate::irq::Handler + 'static>(
+        &'a self,
+        vector: IrqVector<'a>,
+        flags: irq::Flags,
+        name: &'static CStr,
+        handler: impl PinInit<T, Error> + 'a,
+    ) -> Result<impl PinInit<irq::Registration<T>, Error> + 'a> {
+        let request = vector.try_into()?;
+
+        Ok(irq::Registration::<T>::new(request, flags, name, handler))
+    }
+
+    /// Returns a [`kernel::irq::ThreadedRegistration`] for the given IRQ vector.
+    pub fn request_threaded_irq<'a, T: crate::irq::ThreadedHandler + 'static>(
+        &'a self,
+        vector: IrqVector<'a>,
+        flags: irq::Flags,
+        name: &'static CStr,
+        handler: impl PinInit<T, Error> + 'a,
+    ) -> Result<impl PinInit<irq::ThreadedRegistration<T>, Error> + 'a> {
+        let request = vector.try_into()?;
+
+        Ok(irq::ThreadedRegistration::<T>::new(
+            request, flags, name, handler,
+        ))
+    }
+
+    /// Allocate IRQ vectors for this PCI device with automatic cleanup.
+    ///
+    /// Allocates between `min_vecs` and `max_vecs` interrupt vectors for the device.
+    /// The allocation will use MSI-X, MSI, or legacy interrupts based on the `irq_types`
+    /// parameter and hardware capabilities. When multiple types are specified, the kernel
+    /// will try them in order of preference: MSI-X first, then MSI, then legacy interrupts.
+    ///
+    /// The allocated vectors are automatically freed when the device is unbound, using the
+    /// devres (device resource management) system.
+    ///
+    /// # Arguments
+    ///
+    /// * `min_vecs` - Minimum number of vectors required.
+    /// * `max_vecs` - Maximum number of vectors to allocate.
+    /// * `irq_types` - Types of interrupts that can be used.
+    ///
+    /// # Returns
+    ///
+    /// Returns a range of IRQ vectors that were successfully allocated, or an error if the
+    /// allocation fails or cannot meet the minimum requirement.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::{ device::Bound, pci};
+    /// # fn no_run(dev: &pci::Device<Bound>) -> Result {
+    /// // Allocate using any available interrupt type in the order mentioned above.
+    /// let vectors = dev.alloc_irq_vectors(1, 32, pci::IrqTypes::all())?;
+    ///
+    /// // Allocate MSI or MSI-X only (no legacy interrupts).
+    /// let msi_only = pci::IrqTypes::default()
+    ///     .with(pci::IrqType::Msi)
+    ///     .with(pci::IrqType::MsiX);
+    /// let vectors = dev.alloc_irq_vectors(4, 16, msi_only)?;
+    /// # Ok(())
+    /// # }
+    /// ```
+    pub fn alloc_irq_vectors(
+        &self,
+        min_vecs: u32,
+        max_vecs: u32,
+        irq_types: IrqTypes,
+    ) -> Result<RangeInclusive<IrqVector<'_>>> {
+        IrqVectorRegistration::register(self, min_vecs, max_vecs, irq_types)
+    }
+}
-- 
2.51.0


