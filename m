Return-Path: <linux-pci+bounces-38253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C91BE0252
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 20:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A3FE34D532
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 18:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D040833EB0F;
	Wed, 15 Oct 2025 18:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BH/te9Hy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F2333A01F;
	Wed, 15 Oct 2025 18:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552502; cv=none; b=K+GthTCAMswtBBvLDFv95t1gYD8zEttaUni4H8APznekizzfZno5cW3CF61Q9nuhoq1TQD6SXCDOM9BREVxONfRj36lmQ39P2zyqz7eFl49TMHWwtj/NxvhQ5fx71sDaHRMyv6y9KT9fYwEZx8rGeGKBacKKGv7Mrf3USNMC5ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552502; c=relaxed/simple;
	bh=bYDYwSWhzccXxXvDuSWiQVKIv+ZMP5+x49stWJ0QSuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPhMH2mGH7YUXptRnNEk1wVX73BhKq31Q9X5uZvkCsTNDdt+0/N++aqcHcz7LQtDMF1GJ1sGUZYp+BCm2V6ZuD1R3DCOAaiMP0nmWWq/dO2j6JIxgHrqXu5/8wN7uw0S/dLCBQCG3O0qyz8w9LjuGDjBDMxAQBicNHBPoCM6SII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BH/te9Hy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E588C4AF53;
	Wed, 15 Oct 2025 18:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760552502;
	bh=bYDYwSWhzccXxXvDuSWiQVKIv+ZMP5+x49stWJ0QSuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BH/te9HypOYLTlRlOOdj6gnjDBp6hAgLsp0BtydQXVpDt/p2NBigiAKhdDB0nZQPN
	 tvSru0DWFcZ0QYfbcp/yr/RUyj9EagcD9+khdrw6uVfND0mNGtx8lKBS03/PJAeD/4
	 nFdQpQTP7Vnbd8sWQvaeVUXEb+4CSMOo8e2Cc7EErx0f2TQasC4kseiRGCBWy/Dl8N
	 W3rCwAKmrsH0uvo4bvGa8DLTeEnkX3d4l/+zo44ImEqQczZwyQg1GCRC6i6eRkDxZY
	 UIUkMT9P5EC7lcUqzZjFgk4WvfGMxOt1/aRI9gX9tWhMoYAycT+NfSjPun0uTQ17Q6
	 7DHXrcuLYITog==
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
Subject: [PATCH 2/3] rust: pci: move I/O infrastructure to separate file
Date: Wed, 15 Oct 2025 20:14:30 +0200
Message-ID: <20251015182118.106604-3-dakr@kernel.org>
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

Move the PCI I/O infrastructure to a separate sub-module in order to
keep things organized.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs    | 133 ++-------------------------------------
 rust/kernel/pci/io.rs | 141 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+), 129 deletions(-)
 create mode 100644 rust/kernel/pci/io.rs

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index c6b750047b2e..ed9d8619f944 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -8,10 +8,8 @@
     bindings, container_of, device,
     device::Bound,
     device_id::{RawDeviceId, RawDeviceIdIndex},
-    devres::{self, Devres},
-    driver,
+    devres, driver,
     error::{from_result, to_result, Result},
-    io::{Io, IoRaw},
     irq::{self, IrqRequest},
     str::CStr,
     sync::aref::ARef,
@@ -20,14 +18,16 @@
 };
 use core::{
     marker::PhantomData,
-    ops::{Deref, RangeInclusive},
+    ops::RangeInclusive,
     ptr::{addr_of_mut, NonNull},
 };
 use kernel::prelude::*;
 
 mod id;
+mod io;
 
 pub use self::id::{Class, ClassMask, Vendor};
+pub use self::io::Bar;
 
 /// IRQ type flags for PCI interrupt allocation.
 #[derive(Debug, Clone, Copy)]
@@ -358,112 +358,6 @@ pub struct Device<Ctx: device::DeviceContext = device::Normal>(
     PhantomData<Ctx>,
 );
 
-/// A PCI BAR to perform I/O-Operations on.
-///
-/// # Invariants
-///
-/// `Bar` always holds an `IoRaw` inststance that holds a valid pointer to the start of the I/O
-/// memory mapped PCI bar and its size.
-pub struct Bar<const SIZE: usize = 0> {
-    pdev: ARef<Device>,
-    io: IoRaw<SIZE>,
-    num: i32,
-}
-
-impl<const SIZE: usize> Bar<SIZE> {
-    fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
-        let len = pdev.resource_len(num)?;
-        if len == 0 {
-            return Err(ENOMEM);
-        }
-
-        // Convert to `i32`, since that's what all the C bindings use.
-        let num = i32::try_from(num)?;
-
-        // SAFETY:
-        // `pdev` is valid by the invariants of `Device`.
-        // `num` is checked for validity by a previous call to `Device::resource_len`.
-        // `name` is always valid.
-        let ret = unsafe { bindings::pci_request_region(pdev.as_raw(), num, name.as_char_ptr()) };
-        if ret != 0 {
-            return Err(EBUSY);
-        }
-
-        // SAFETY:
-        // `pdev` is valid by the invariants of `Device`.
-        // `num` is checked for validity by a previous call to `Device::resource_len`.
-        // `name` is always valid.
-        let ioptr: usize = unsafe { bindings::pci_iomap(pdev.as_raw(), num, 0) } as usize;
-        if ioptr == 0 {
-            // SAFETY:
-            // `pdev` valid by the invariants of `Device`.
-            // `num` is checked for validity by a previous call to `Device::resource_len`.
-            unsafe { bindings::pci_release_region(pdev.as_raw(), num) };
-            return Err(ENOMEM);
-        }
-
-        let io = match IoRaw::new(ioptr, len as usize) {
-            Ok(io) => io,
-            Err(err) => {
-                // SAFETY:
-                // `pdev` is valid by the invariants of `Device`.
-                // `ioptr` is guaranteed to be the start of a valid I/O mapped memory region.
-                // `num` is checked for validity by a previous call to `Device::resource_len`.
-                unsafe { Self::do_release(pdev, ioptr, num) };
-                return Err(err);
-            }
-        };
-
-        Ok(Bar {
-            pdev: pdev.into(),
-            io,
-            num,
-        })
-    }
-
-    /// # Safety
-    ///
-    /// `ioptr` must be a valid pointer to the memory mapped PCI bar number `num`.
-    unsafe fn do_release(pdev: &Device, ioptr: usize, num: i32) {
-        // SAFETY:
-        // `pdev` is valid by the invariants of `Device`.
-        // `ioptr` is valid by the safety requirements.
-        // `num` is valid by the safety requirements.
-        unsafe {
-            bindings::pci_iounmap(pdev.as_raw(), ioptr as *mut c_void);
-            bindings::pci_release_region(pdev.as_raw(), num);
-        }
-    }
-
-    fn release(&self) {
-        // SAFETY: The safety requirements are guaranteed by the type invariant of `self.pdev`.
-        unsafe { Self::do_release(&self.pdev, self.io.addr(), self.num) };
-    }
-}
-
-impl Bar {
-    #[inline]
-    fn index_is_valid(index: u32) -> bool {
-        // A `struct pci_dev` owns an array of resources with at most `PCI_NUM_RESOURCES` entries.
-        index < bindings::PCI_NUM_RESOURCES
-    }
-}
-
-impl<const SIZE: usize> Drop for Bar<SIZE> {
-    fn drop(&mut self) {
-        self.release();
-    }
-}
-
-impl<const SIZE: usize> Deref for Bar<SIZE> {
-    type Target = Io<SIZE>;
-
-    fn deref(&self) -> &Self::Target {
-        // SAFETY: By the type invariant of `Self`, the MMIO range in `self.io` is properly mapped.
-        unsafe { Io::from_raw(&self.io) }
-    }
-}
-
 impl<Ctx: device::DeviceContext> Device<Ctx> {
     #[inline]
     fn as_raw(&self) -> *mut bindings::pci_dev {
@@ -670,25 +564,6 @@ fn drop(&mut self) {
 }
 
 impl Device<device::Bound> {
-    /// Mapps an entire PCI-BAR after performing a region-request on it. I/O operation bound checks
-    /// can be performed on compile time for offsets (plus the requested type size) < SIZE.
-    pub fn iomap_region_sized<'a, const SIZE: usize>(
-        &'a self,
-        bar: u32,
-        name: &'a CStr,
-    ) -> impl PinInit<Devres<Bar<SIZE>>, Error> + 'a {
-        Devres::new(self.as_ref(), Bar::<SIZE>::new(self, bar, name))
-    }
-
-    /// Mapps an entire PCI-BAR after performing a region-request on it.
-    pub fn iomap_region<'a>(
-        &'a self,
-        bar: u32,
-        name: &'a CStr,
-    ) -> impl PinInit<Devres<Bar>, Error> + 'a {
-        self.iomap_region_sized::<0>(bar, name)
-    }
-
     /// Returns a [`kernel::irq::Registration`] for the given IRQ vector.
     pub fn request_irq<'a, T: crate::irq::Handler + 'static>(
         &'a self,
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
new file mode 100644
index 000000000000..65151a0a1a41
--- /dev/null
+++ b/rust/kernel/pci/io.rs
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! PCI memory-mapped I/O infrastructure.
+
+use super::Device;
+use crate::{
+    bindings, device,
+    devres::Devres,
+    io::{Io, IoRaw},
+    str::CStr,
+    sync::aref::ARef,
+};
+use core::ops::Deref;
+use kernel::prelude::*;
+
+/// A PCI BAR to perform I/O-Operations on.
+///
+/// # Invariants
+///
+/// `Bar` always holds an `IoRaw` inststance that holds a valid pointer to the start of the I/O
+/// memory mapped PCI bar and its size.
+pub struct Bar<const SIZE: usize = 0> {
+    pdev: ARef<Device>,
+    io: IoRaw<SIZE>,
+    num: i32,
+}
+
+impl<const SIZE: usize> Bar<SIZE> {
+    pub(super) fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
+        let len = pdev.resource_len(num)?;
+        if len == 0 {
+            return Err(ENOMEM);
+        }
+
+        // Convert to `i32`, since that's what all the C bindings use.
+        let num = i32::try_from(num)?;
+
+        // SAFETY:
+        // `pdev` is valid by the invariants of `Device`.
+        // `num` is checked for validity by a previous call to `Device::resource_len`.
+        // `name` is always valid.
+        let ret = unsafe { bindings::pci_request_region(pdev.as_raw(), num, name.as_char_ptr()) };
+        if ret != 0 {
+            return Err(EBUSY);
+        }
+
+        // SAFETY:
+        // `pdev` is valid by the invariants of `Device`.
+        // `num` is checked for validity by a previous call to `Device::resource_len`.
+        // `name` is always valid.
+        let ioptr: usize = unsafe { bindings::pci_iomap(pdev.as_raw(), num, 0) } as usize;
+        if ioptr == 0 {
+            // SAFETY:
+            // `pdev` valid by the invariants of `Device`.
+            // `num` is checked for validity by a previous call to `Device::resource_len`.
+            unsafe { bindings::pci_release_region(pdev.as_raw(), num) };
+            return Err(ENOMEM);
+        }
+
+        let io = match IoRaw::new(ioptr, len as usize) {
+            Ok(io) => io,
+            Err(err) => {
+                // SAFETY:
+                // `pdev` is valid by the invariants of `Device`.
+                // `ioptr` is guaranteed to be the start of a valid I/O mapped memory region.
+                // `num` is checked for validity by a previous call to `Device::resource_len`.
+                unsafe { Self::do_release(pdev, ioptr, num) };
+                return Err(err);
+            }
+        };
+
+        Ok(Bar {
+            pdev: pdev.into(),
+            io,
+            num,
+        })
+    }
+
+    /// # Safety
+    ///
+    /// `ioptr` must be a valid pointer to the memory mapped PCI bar number `num`.
+    unsafe fn do_release(pdev: &Device, ioptr: usize, num: i32) {
+        // SAFETY:
+        // `pdev` is valid by the invariants of `Device`.
+        // `ioptr` is valid by the safety requirements.
+        // `num` is valid by the safety requirements.
+        unsafe {
+            bindings::pci_iounmap(pdev.as_raw(), ioptr as *mut c_void);
+            bindings::pci_release_region(pdev.as_raw(), num);
+        }
+    }
+
+    fn release(&self) {
+        // SAFETY: The safety requirements are guaranteed by the type invariant of `self.pdev`.
+        unsafe { Self::do_release(&self.pdev, self.io.addr(), self.num) };
+    }
+}
+
+impl Bar {
+    #[inline]
+    pub(super) fn index_is_valid(index: u32) -> bool {
+        // A `struct pci_dev` owns an array of resources with at most `PCI_NUM_RESOURCES` entries.
+        index < bindings::PCI_NUM_RESOURCES
+    }
+}
+
+impl<const SIZE: usize> Drop for Bar<SIZE> {
+    fn drop(&mut self) {
+        self.release();
+    }
+}
+
+impl<const SIZE: usize> Deref for Bar<SIZE> {
+    type Target = Io<SIZE>;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: By the type invariant of `Self`, the MMIO range in `self.io` is properly mapped.
+        unsafe { Io::from_raw(&self.io) }
+    }
+}
+
+impl Device<device::Bound> {
+    /// Mapps an entire PCI-BAR after performing a region-request on it. I/O operation bound checks
+    /// can be performed on compile time for offsets (plus the requested type size) < SIZE.
+    pub fn iomap_region_sized<'a, const SIZE: usize>(
+        &'a self,
+        bar: u32,
+        name: &'a CStr,
+    ) -> impl PinInit<Devres<Bar<SIZE>>, Error> + 'a {
+        Devres::new(self.as_ref(), Bar::<SIZE>::new(self, bar, name))
+    }
+
+    /// Mapps an entire PCI-BAR after performing a region-request on it.
+    pub fn iomap_region<'a>(
+        &'a self,
+        bar: u32,
+        name: &'a CStr,
+    ) -> impl PinInit<Devres<Bar>, Error> + 'a {
+        self.iomap_region_sized::<0>(bar, name)
+    }
+}
-- 
2.51.0


