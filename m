Return-Path: <linux-pci+bounces-23765-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C5FA61600
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 17:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2BB19C3F9C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 16:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BDE204C29;
	Fri, 14 Mar 2025 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCzDuS5D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9F5205AB5;
	Fri, 14 Mar 2025 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968593; cv=none; b=sy0GfntcOz7QLlSXJ3STLW+/sVbQXC15kr4i1CTIJg2nxKci/TboBEnsuOoTts56YkUQfvzCKgLnFIs0wmKPjJxwqMlyd5R/Xsez1VU0UfyX/QPrUwn/sx36DCbV4Ho5bukEfw89nPBium65GHhi8ALDGlyKhJLsmie+uZlz3Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968593; c=relaxed/simple;
	bh=9bMvDFkiEn0flcv2RD7JgC1AAL7/PYhrBNtwY663bsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8mOmAmo17NLXI+JU/L2Y3wXQHnkyxkTG4AJyY2IjX4/KA+eI6MoWXnSaxYDG0wmc9E0FTYdkRdjBOYddkA5Zcqz20vzCUAKJ8/Kh9bleSg9e8XODKdA3UU+whzBgJr6Cr5/JrO3ryz+kDded0x9+wKnIuKUFrn1s8aI8sgrQHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCzDuS5D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54B0C4CEEF;
	Fri, 14 Mar 2025 16:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741968592;
	bh=9bMvDFkiEn0flcv2RD7JgC1AAL7/PYhrBNtwY663bsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lCzDuS5DsdhWyhh4LM0y517nhTgA5DMESROTsLNpPQ1fiAxx94RIxs2RrcGX3K943
	 He8sBEWSL5luXxBTRcTQbQOmZV4imcvBifR9EUTMeuUGXyQkt8ViGqjmADqnMpLOzv
	 fmL5orQM0Jdz5Nzllnd24huaAkPpGPet2OP7uUu5+RxSTahVJ9MdXoim2CGrID9si8
	 nLybnRCUXUAbuiF2fnWpnt4okZix0Op8VQNpJy+BBrntjkIkRrPSOTIlob1VZr412g
	 md6h2DwZvwzXx6C38HuM2dmWq+4PquC1WXw7BHerkATWTe8qNIZpVHLtN4fmDXzeK2
	 8amjowJKKIrHg==
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
Subject: [PATCH v2 4/4] rust: platform: fix unrestricted &mut platform::Device
Date: Fri, 14 Mar 2025 17:09:07 +0100
Message-ID: <20250314160932.100165-5-dakr@kernel.org>
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
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/platform.rs              | 95 +++++++++++++++++++---------
 samples/rust/rust_driver_platform.rs | 11 ++--
 2 files changed, 72 insertions(+), 34 deletions(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 50e6b0421813..c77c9f2e9aea 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -5,7 +5,7 @@
 //! C header: [`include/linux/platform_device.h`](srctree/include/linux/platform_device.h)
 
 use crate::{
-    bindings, container_of, device, driver,
+    bindings, device, driver,
     error::{to_result, Result},
     of,
     prelude::*,
@@ -14,7 +14,11 @@
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
@@ -160,41 +164,72 @@ pub trait Driver {
     ///
     /// Called when a new platform device is added or discovered.
     /// Implementers should attempt to initialize the device here.
-    fn probe(dev: &mut Device, id_info: Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>>;
+    fn probe(dev: &Device<device::Core>, id_info: Option<&Self::IdInfo>)
+        -> Result<Pin<KBox<Self>>>;
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
index 8120609e2940..9bb66db0a4f4 100644
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
@@ -21,14 +21,17 @@ impl platform::Driver for SampleDriver {
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
+        let drvdata = KBox::new(Self { pdev: pdev.into() }, GFP_KERNEL)?;
 
         Ok(drvdata.into())
     }
-- 
2.48.1


