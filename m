Return-Path: <linux-pci+bounces-23562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3724CA5E9BB
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 03:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51C41898E74
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 02:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BF1155382;
	Thu, 13 Mar 2025 02:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqqO7bNS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE6F155326;
	Thu, 13 Mar 2025 02:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741832268; cv=none; b=S05K+n6leSRWag+lxO/G5FoJNhLN0SJg8160B5glmfq4vq14GlJG7uElj3DEnAortyHS7EWmSxyc4FS2bX+/RpsabJJNh/EZl72nAd4N+h5ZXhmb4OHTDv0KQmIf/0ZX5KMUJBMT8ZQahz8Nz1uBghMsgyJ52uKnna7eU7l1ey8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741832268; c=relaxed/simple;
	bh=mqDFFPi4nAfJBJc1IyFPq2rVJ3Jp3UyQkGeG1puHpwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sxnc+7YB/IRiISVeIkEfYdj4ifnbsxBJ/leVrwXu4jbVd57X0ncnCDajgegA5/dBrRYjyDVCoQJWlo10Ej5f/6MjVqdlZdlJ45AM8GZH5VRZwERLuCqEPyziAzvDmGLIGFkJwFUc2R8X2ybS5jkUgkOxn7RSHlCY+sMBqd82suU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqqO7bNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB37AC4CEED;
	Thu, 13 Mar 2025 02:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741832268;
	bh=mqDFFPi4nAfJBJc1IyFPq2rVJ3Jp3UyQkGeG1puHpwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pqqO7bNSEN8xpK89054mf1LSka3f9Mshy8zkau1w2uCX1kKdjzR06rj2xbWkKvRGV
	 xhAUESaIrQrYU0vZaoppHu3PGJi/8vn11B/k40VtWPV6Gg5+ylqCYhWgRkhfqmXyoh
	 yRCHSVFC5lvRisAthYo2EUnZQ8bC5oG8xAmILErNKGZ7A0UUbXHlPGqpXDRRwZExwb
	 3G4jVyVIFgaLool/MJToouvSpP6gsIfbsmPHjWPq+tSzdRo+6aW/W0D3TMa73BGKXZ
	 b9Rf5ok4dwNwDywU+IGHe+Csclj5IZk3Ba9xT/7mXqeuJzM5//RtOUoNh1alo2O8Y0
	 e9rWvbq9tLfmw==
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
Subject: [PATCH 4/4] rust: platform: fix unrestricted &mut platform::Device
Date: Thu, 13 Mar 2025 03:13:34 +0100
Message-ID: <20250313021550.133041-5-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313021550.133041-1-dakr@kernel.org>
References: <20250313021550.133041-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As by now, platform::Device is implemented as:

	#[derive(Clone)]
	pub struct Device(ARef<device::Device>);

This may be convenient, but has the implication that drivers can call
device methods that require a mutable reference concurrently at any
point of time.

Instead define platform::Device as

	pub struct Device<Ctx: DeviceContext = Normal>(
		Opaque<bindings::platform_dev>,
		PhantomData<Ctx>,
	);

and manually implement the AlwaysRefCounted trait.

With this we can implement methods that should only be called from
bus callbacks (such as probe()) for platform::Device<Core>. Consequently,
we make this type accessible in bus callbacks only.

Arbitrary references taken by the driver are still of type
ARef<platform::Device> and hence don't provide access to methods that are
reserved for bus callbacks.

Fixes: 683a63befc73 ("rust: platform: add basic platform device / driver abstractions")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/platform.rs              | 93 ++++++++++++++++++----------
 samples/rust/rust_driver_platform.rs | 16 +++--
 2 files changed, 74 insertions(+), 35 deletions(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 50e6b0421813..f7a055739143 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -5,16 +5,20 @@
 //! C header: [`include/linux/platform_device.h`](srctree/include/linux/platform_device.h)
 
 use crate::{
-    bindings, container_of, device, driver,
+    bindings, device, driver,
     error::{to_result, Result},
     of,
     prelude::*,
     str::CStr,
-    types::{ARef, ForeignOwnable, Opaque},
+    types::{ForeignOwnable, Opaque},
     ThisModule,
 };
 
-use core::ptr::addr_of_mut;
+use core::{
+    marker::PhantomData,
+    ops::Deref,
+    ptr::{addr_of_mut, NonNull},
+};
 
 /// An adapter for the registration of platform drivers.
 pub struct Adapter<T: Driver>(T);
@@ -54,14 +58,14 @@ unsafe fn unregister(pdrv: &Opaque<Self::RegType>) {
 
 impl<T: Driver + 'static> Adapter<T> {
     extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ffi::c_int {
-        // SAFETY: The platform bus only ever calls the probe callback with a valid `pdev`.
-        let dev = unsafe { device::Device::get_device(addr_of_mut!((*pdev).dev)) };
-        // SAFETY: `dev` is guaranteed to be embedded in a valid `struct platform_device` by the
-        // call above.
-        let mut pdev = unsafe { Device::from_dev(dev) };
+        // SAFETY: The platform bus only ever calls the probe callback with a valid pointer to a
+        // `struct platform_device`.
+        //
+        // INVARIANT: `pdev` is valid for the duration of `probe_callback()`.
+        let pdev = unsafe { &*pdev.cast::<Device<device::Core>>() };
 
         let info = <Self as driver::Adapter>::id_info(pdev.as_ref());
-        match T::probe(&mut pdev, info) {
+        match T::probe(pdev, info) {
             Ok(data) => {
                 // Let the `struct platform_device` own a reference of the driver's private data.
                 // SAFETY: By the type invariant `pdev.as_raw` returns a valid pointer to a
@@ -120,7 +124,7 @@ macro_rules! module_platform_driver {
 /// # Example
 ///
 ///```
-/// # use kernel::{bindings, c_str, of, platform};
+/// # use kernel::{bindings, c_str, device::Core, of, platform};
 ///
 /// struct MyDriver;
 ///
@@ -138,7 +142,7 @@ macro_rules! module_platform_driver {
 ///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 ///
 ///     fn probe(
-///         _pdev: &mut platform::Device,
+///         _pdev: &platform::Device<Core>,
 ///         _id_info: Option<&Self::IdInfo>,
 ///     ) -> Result<Pin<KBox<Self>>> {
 ///         Err(ENODEV)
@@ -160,41 +164,68 @@ pub trait Driver {
     ///
     /// Called when a new platform device is added or discovered.
     /// Implementers should attempt to initialize the device here.
-    fn probe(dev: &mut Device, id_info: Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>>;
+    fn probe(
+        dev: &Device<device::Core>,
+        id_info: Option<&Self::IdInfo>,
+    ) -> Result<Pin<KBox<Self>>>;
 }
 
 /// The platform device representation.
 ///
-/// A platform device is based on an always reference counted `device:Device` instance. Cloning a
-/// platform device, hence, also increments the base device' reference count.
+/// This structure represents the Rust abstraction for a C `struct platform_device`. The
+/// implementation abstracts the usage of an already existing C `struct platform_device` within Rust
+/// code that we get passed from the C side.
 ///
 /// # Invariants
 ///
-/// `Device` holds a valid reference of `ARef<device::Device>` whose underlying `struct device` is a
-/// member of a `struct platform_device`.
-#[derive(Clone)]
-pub struct Device(ARef<device::Device>);
+/// A [`Device`] instance represents a valid `struct platform_device` created by the C portion of
+/// the kernel.
+#[repr(transparent)]
+pub struct Device<Ctx: device::DeviceContext = device::Normal>(
+    Opaque<bindings::platform_device>,
+    PhantomData<Ctx>,
+);
 
 impl Device {
-    /// Convert a raw kernel device into a `Device`
-    ///
-    /// # Safety
-    ///
-    /// `dev` must be an `Aref<device::Device>` whose underlying `bindings::device` is a member of a
-    /// `bindings::platform_device`.
-    unsafe fn from_dev(dev: ARef<device::Device>) -> Self {
-        Self(dev)
+    fn as_raw(&self) -> *mut bindings::platform_device {
+        self.0.get()
     }
+}
 
-    fn as_raw(&self) -> *mut bindings::platform_device {
-        // SAFETY: By the type invariant `self.0.as_raw` is a pointer to the `struct device`
-        // embedded in `struct platform_device`.
-        unsafe { container_of!(self.0.as_raw(), bindings::platform_device, dev) }.cast_mut()
+impl Deref for Device<device::Core> {
+    type Target = Device;
+
+    fn deref(&self) -> &Self::Target {
+        let ptr: *const Self = self;
+
+        // CAST: `Device<Ctx>` is a transparent wrapper of `Opaque<bindings::platform_device>`.
+        let ptr = ptr.cast::<Device>();
+
+        // SAFETY: `ptr` was derived from `&self`.
+        unsafe { &*ptr }
+    }
+}
+
+// SAFETY: Instances of `Device` are always reference-counted.
+unsafe impl crate::types::AlwaysRefCounted for Device {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
+        unsafe { bindings::get_device(self.as_ref().as_raw()) };
+    }
+
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is non-zero.
+        unsafe { bindings::platform_device_put(obj.cast().as_ptr()) }
     }
 }
 
 impl AsRef<device::Device> for Device {
     fn as_ref(&self) -> &device::Device {
-        &self.0
+        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
+        // `struct platform_device`.
+        let dev = unsafe { addr_of_mut!((*self.as_raw()).dev) };
+
+        // SAFETY: `dev` points to a valid `struct device`.
+        unsafe { device::Device::as_ref(dev) }
     }
 }
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 8120609e2940..0fb4c6033d60 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -2,10 +2,10 @@
 
 //! Rust Platform driver sample.
 
-use kernel::{c_str, of, platform, prelude::*};
+use kernel::{c_str, device::Core, of, platform, prelude::*, types::ARef};
 
 struct SampleDriver {
-    pdev: platform::Device,
+    pdev: ARef<platform::Device>,
 }
 
 struct Info(u32);
@@ -21,14 +21,22 @@ impl platform::Driver for SampleDriver {
     type IdInfo = Info;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 
-    fn probe(pdev: &mut platform::Device, info: Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>> {
+    fn probe(
+        pdev: &platform::Device<Core>,
+        info: Option<&Self::IdInfo>,
+    ) -> Result<Pin<KBox<Self>>> {
         dev_dbg!(pdev.as_ref(), "Probe Rust Platform driver sample.\n");
 
         if let Some(info) = info {
             dev_info!(pdev.as_ref(), "Probed with info: '{}'.\n", info.0);
         }
 
-        let drvdata = KBox::new(Self { pdev: pdev.clone() }, GFP_KERNEL)?;
+        let drvdata = KBox::new(
+            Self {
+                pdev: (&**pdev).into(),
+            },
+            GFP_KERNEL,
+        )?;
 
         Ok(drvdata.into())
     }
-- 
2.48.1


