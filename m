Return-Path: <linux-pci+bounces-23764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D27A615EB
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 17:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB49A3BF82D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 16:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB68204C13;
	Fri, 14 Mar 2025 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXcPsePp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D94204C0F;
	Fri, 14 Mar 2025 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968589; cv=none; b=XbIAexJFWrXQN/0An/bqbI7VHVN1VvCWE4owlOvcy6lauOk+aFVODxY2f9b6dDN/nEkH5EkD34VYnZyUof1q70q3XJSDt14aQGrAILwZUOGlrZLsZCMANDFCwHk8hF8KS9LGqWR5Xv3eZxwwtUrmeAM1lJos5GXxgKyXm42asUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968589; c=relaxed/simple;
	bh=PXqjksoBv5r0sMAylYy8VC+mkJmatOkt19brm7SZ2SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxXsvgdv46leQF3p1K5iTSpGI9sQw2w8gcZaEBuRBDhx75AVqc9bPzc46Qglk3vYYFgVFsdTv5erLnh6tsi2jVe5QSx9BUs+uSP7eQlTq4Yo4xCxs/afD0q67aPvC+u/ah4anyKAlu/ZFQfkHjjBRxCuDTkFsk8sCr9zrjpa8W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXcPsePp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2110CC4CEEC;
	Fri, 14 Mar 2025 16:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741968589;
	bh=PXqjksoBv5r0sMAylYy8VC+mkJmatOkt19brm7SZ2SM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GXcPsePpRibJJM7R76r1gaNLoxS7sm3VOUQcgKtrEKzLbTc3M5VHYRsAXYU8XHPo/
	 IAFqzsEhuy8dup/DQ3IBB6D8sErianl/p5BCy2/YC/fcj7ETyjr4F/q8tXXhJ9P44/
	 y0mgkYFGUgerrEGoWY/+jwx6eNH4o9pygesXv/LZPDFyumcj8Z+nQMyWcQjyysWwAC
	 Eo6+j40fxCjIsCZn7RlrPRtv2ADfxZPcvAyXmeZBNND2S+BLBht9srrYV1GzYCK+4J
	 rE9mXgORbGKx3LdzHaTUKgknbLA6sNW/5uoc/9xAM3aQnWIhi7r+cMiIuJSPMnBAXh
	 p/2552cYq2R9g==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 3/4] rust: pci: fix unrestricted &mut pci::Device
Date: Fri, 14 Mar 2025 17:09:06 +0100
Message-ID: <20250314160932.100165-4-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314160932.100165-1-dakr@kernel.org>
References: <20250314160932.100165-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As by now, pci::Device is implemented as:

	#[derive(Clone)]
	pub struct Device(ARef<device::Device>);

This may be convenient, but has the implication that drivers can call
device methods that require a mutable reference concurrently at any
point of time.

Instead define pci::Device as

	pub struct Device<Ctx: DeviceContext = Normal>(
		Opaque<bindings::pci_dev>,
		PhantomData<Ctx>,
	);

and manually implement the AlwaysRefCounted trait.

With this we can implement methods that should only be called from
bus callbacks (such as probe()) for pci::Device<Core>. Consequently, we
make this type accessible in bus callbacks only.

Arbitrary references taken by the driver are still of type
ARef<pci::Device> and hence don't provide access to methods that are
reserved for bus callbacks.

Fixes: 1bd8b6b2c5d3 ("rust: pci: add basic PCI device / driver abstractions")
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs              | 132 ++++++++++++++++++++------------
 samples/rust/rust_driver_pci.rs |   8 +-
 2 files changed, 89 insertions(+), 51 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 386484dcf36e..0ac6cef74f81 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -6,7 +6,7 @@
 
 use crate::{
     alloc::flags::*,
-    bindings, container_of, device,
+    bindings, device,
     device_id::RawDeviceId,
     devres::Devres,
     driver,
@@ -17,7 +17,11 @@
     types::{ARef, ForeignOwnable, Opaque},
     ThisModule,
 };
-use core::{ops::Deref, ptr::addr_of_mut};
+use core::{
+    marker::PhantomData,
+    ops::Deref,
+    ptr::{addr_of_mut, NonNull},
+};
 use kernel::prelude::*;
 
 /// An adapter for the registration of PCI drivers.
@@ -60,17 +64,16 @@ extern "C" fn probe_callback(
     ) -> kernel::ffi::c_int {
         // SAFETY: The PCI bus only ever calls the probe callback with a valid pointer to a
         // `struct pci_dev`.
-        let dev = unsafe { device::Device::get_device(addr_of_mut!((*pdev).dev)) };
-        // SAFETY: `dev` is guaranteed to be embedded in a valid `struct pci_dev` by the call
-        // above.
-        let mut pdev = unsafe { Device::from_dev(dev) };
+        //
+        // INVARIANT: `pdev` is valid for the duration of `probe_callback()`.
+        let pdev = unsafe { &*pdev.cast::<Device<device::Core>>() };
 
         // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of `struct pci_device_id` and
         // does not add additional invariants, so it's safe to transmute.
         let id = unsafe { &*id.cast::<DeviceId>() };
         let info = T::ID_TABLE.info(id.index());
 
-        match T::probe(&mut pdev, info) {
+        match T::probe(pdev, info) {
             Ok(data) => {
                 // Let the `struct pci_dev` own a reference of the driver's private data.
                 // SAFETY: By the type invariant `pdev.as_raw` returns a valid pointer to a
@@ -192,7 +195,7 @@ macro_rules! pci_device_table {
 /// # Example
 ///
 ///```
-/// # use kernel::{bindings, pci};
+/// # use kernel::{bindings, device::Core, pci};
 ///
 /// struct MyDriver;
 ///
@@ -210,7 +213,7 @@ macro_rules! pci_device_table {
 ///     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 ///
 ///     fn probe(
-///         _pdev: &mut pci::Device,
+///         _pdev: &pci::Device<Core>,
 ///         _id_info: &Self::IdInfo,
 ///     ) -> Result<Pin<KBox<Self>>> {
 ///         Err(ENODEV)
@@ -234,20 +237,23 @@ pub trait Driver {
     ///
     /// Called when a new platform device is added or discovered.
     /// Implementers should attempt to initialize the device here.
-    fn probe(dev: &mut Device, id_info: &Self::IdInfo) -> Result<Pin<KBox<Self>>>;
+    fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo) -> Result<Pin<KBox<Self>>>;
 }
 
 /// The PCI device representation.
 ///
-/// A PCI device is based on an always reference counted `device:Device` instance. Cloning a PCI
-/// device, hence, also increments the base device' reference count.
+/// This structure represents the Rust abstraction for a C `struct pci_dev`. The implementation
+/// abstracts the usage of an already existing C `struct pci_dev` within Rust code that we get
+/// passed from the C side.
 ///
 /// # Invariants
 ///
-/// `Device` hold a valid reference of `ARef<device::Device>` whose underlying `struct device` is a
-/// member of a `struct pci_dev`.
-#[derive(Clone)]
-pub struct Device(ARef<device::Device>);
+/// A [`Device`] instance represents a valid `struct device` created by the C portion of the kernel.
+#[repr(transparent)]
+pub struct Device<Ctx: device::DeviceContext = device::Normal>(
+    Opaque<bindings::pci_dev>,
+    PhantomData<Ctx>,
+);
 
 /// A PCI BAR to perform I/O-Operations on.
 ///
@@ -256,13 +262,13 @@ pub trait Driver {
 /// `Bar` always holds an `IoRaw` inststance that holds a valid pointer to the start of the I/O
 /// memory mapped PCI bar and its size.
 pub struct Bar<const SIZE: usize = 0> {
-    pdev: Device,
+    pdev: ARef<Device>,
     io: IoRaw<SIZE>,
     num: i32,
 }
 
 impl<const SIZE: usize> Bar<SIZE> {
-    fn new(pdev: Device, num: u32, name: &CStr) -> Result<Self> {
+    fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
         let len = pdev.resource_len(num)?;
         if len == 0 {
             return Err(ENOMEM);
@@ -300,12 +306,16 @@ fn new(pdev: Device, num: u32, name: &CStr) -> Result<Self> {
                 // `pdev` is valid by the invariants of `Device`.
                 // `ioptr` is guaranteed to be the start of a valid I/O mapped memory region.
                 // `num` is checked for validity by a previous call to `Device::resource_len`.
-                unsafe { Self::do_release(&pdev, ioptr, num) };
+                unsafe { Self::do_release(pdev, ioptr, num) };
                 return Err(err);
             }
         };
 
-        Ok(Bar { pdev, io, num })
+        Ok(Bar {
+            pdev: pdev.into(),
+            io,
+            num,
+        })
     }
 
     /// # Safety
@@ -351,20 +361,8 @@ fn deref(&self) -> &Self::Target {
 }
 
 impl Device {
-    /// Create a PCI Device instance from an existing `device::Device`.
-    ///
-    /// # Safety
-    ///
-    /// `dev` must be an `ARef<device::Device>` whose underlying `bindings::device` is a member of
-    /// a `bindings::pci_dev`.
-    pub unsafe fn from_dev(dev: ARef<device::Device>) -> Self {
-        Self(dev)
-    }
-
     fn as_raw(&self) -> *mut bindings::pci_dev {
-        // SAFETY: By the type invariant `self.0.as_raw` is a pointer to the `struct device`
-        // embedded in `struct pci_dev`.
-        unsafe { container_of!(self.0.as_raw(), bindings::pci_dev, dev) as _ }
+        self.0.get()
     }
 
     /// Returns the PCI vendor ID.
@@ -379,18 +377,6 @@ pub fn device_id(&self) -> u16 {
         unsafe { (*self.as_raw()).device }
     }
 
-    /// Enable memory resources for this device.
-    pub fn enable_device_mem(&self) -> Result {
-        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
-        to_result(unsafe { bindings::pci_enable_device_mem(self.as_raw()) })
-    }
-
-    /// Enable bus-mastering for this device.
-    pub fn set_master(&self) {
-        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
-        unsafe { bindings::pci_set_master(self.as_raw()) };
-    }
-
     /// Returns the size of the given PCI bar resource.
     pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         if !Bar::index_is_valid(bar) {
@@ -410,7 +396,7 @@ pub fn iomap_region_sized<const SIZE: usize>(
         bar: u32,
         name: &CStr,
     ) -> Result<Devres<Bar<SIZE>>> {
-        let bar = Bar::<SIZE>::new(self.clone(), bar, name)?;
+        let bar = Bar::<SIZE>::new(self, bar, name)?;
         let devres = Devres::new(self.as_ref(), bar, GFP_KERNEL)?;
 
         Ok(devres)
@@ -422,8 +408,60 @@ pub fn iomap_region(&self, bar: u32, name: &CStr) -> Result<Devres<Bar>> {
     }
 }
 
+impl Device<device::Core> {
+    /// Enable memory resources for this device.
+    pub fn enable_device_mem(&self) -> Result {
+        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
+        to_result(unsafe { bindings::pci_enable_device_mem(self.as_raw()) })
+    }
+
+    /// Enable bus-mastering for this device.
+    pub fn set_master(&self) {
+        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
+        unsafe { bindings::pci_set_master(self.as_raw()) };
+    }
+}
+
+impl Deref for Device<device::Core> {
+    type Target = Device;
+
+    fn deref(&self) -> &Self::Target {
+        let ptr: *const Self = self;
+
+        // CAST: `Device<Ctx>` is a transparent wrapper of `Opaque<bindings::pci_dev>`.
+        let ptr = ptr.cast::<Device>();
+
+        // SAFETY: `ptr` was derived from `&self`.
+        unsafe { &*ptr }
+    }
+}
+
+impl From<&Device<device::Core>> for ARef<Device> {
+    fn from(dev: &Device<device::Core>) -> Self {
+        (&**dev).into()
+    }
+}
+
+// SAFETY: Instances of `Device` are always reference-counted.
+unsafe impl crate::types::AlwaysRefCounted for Device {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
+        unsafe { bindings::pci_dev_get(self.as_raw()) };
+    }
+
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is non-zero.
+        unsafe { bindings::pci_dev_put(obj.cast().as_ptr()) }
+    }
+}
+
 impl AsRef<device::Device> for Device {
     fn as_ref(&self) -> &device::Device {
-        &self.0
+        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
+        // `struct pci_dev`.
+        let dev = unsafe { addr_of_mut!((*self.as_raw()).dev) };
+
+        // SAFETY: `dev` points to a valid `struct device`.
+        unsafe { device::Device::as_ref(dev) }
     }
 }
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 1fb6e44f3395..4f14e63f323e 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -4,7 +4,7 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{bindings, c_str, devres::Devres, pci, prelude::*};
+use kernel::{bindings, c_str, device::Core, devres::Devres, pci, prelude::*, types::ARef};
 
 struct Regs;
 
@@ -26,7 +26,7 @@ impl TestIndex {
 }
 
 struct SampleDriver {
-    pdev: pci::Device,
+    pdev: ARef<pci::Device>,
     bar: Devres<Bar0>,
 }
 
@@ -62,7 +62,7 @@ impl pci::Driver for SampleDriver {
 
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
-    fn probe(pdev: &mut pci::Device, info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
+    fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
         dev_dbg!(
             pdev.as_ref(),
             "Probe Rust PCI driver sample (PCI ID: 0x{:x}, 0x{:x}).\n",
@@ -77,7 +77,7 @@ fn probe(pdev: &mut pci::Device, info: &Self::IdInfo) -> Result<Pin<KBox<Self>>>
 
         let drvdata = KBox::new(
             Self {
-                pdev: pdev.clone(),
+                pdev: pdev.into(),
                 bar,
             },
             GFP_KERNEL,
-- 
2.48.1


