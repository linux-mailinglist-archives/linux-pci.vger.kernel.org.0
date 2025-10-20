Return-Path: <linux-pci+bounces-38815-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B032BF3EC4
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 00:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B09248166F
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 22:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5468D2F363C;
	Mon, 20 Oct 2025 22:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJXT7WZL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A852F0C79;
	Mon, 20 Oct 2025 22:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999743; cv=none; b=oQoaNDw9bHZ9YWSeCisSz8pmn8NW6o/amq4hODhCWeKbqTEOF4Lwb9p3G44GAzKAOWxvOMAdhpmyet/dM3BE/PKj1hOhG4XFL6txF1mYirWFveRaat6usuNQN9IkghnWeN67Vz7iwmfmwsS5HE2FzNWY+L9lQ5XY389Oht/E6Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999743; c=relaxed/simple;
	bh=qL5kYGECCC85OsPH4HQK2aOGaWUZce7Vw+aqubE50Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vznl0xL+8y6K8Ttx9BYbDIT75fVh9Ojc8XSUSnvbKCvgVY4/Ea1uGnoA+j0GTDs54/gWm0L3Qke4h6HuzXUVY5ro9xq9D85q142vyCFKRPEBKZQehLTG1gis90HY1SOPvga6TMy2ESlh3Rvl8EIoBnF0G6NrqbTPim1cO0coUPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJXT7WZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FF0C4CEFB;
	Mon, 20 Oct 2025 22:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760999743;
	bh=qL5kYGECCC85OsPH4HQK2aOGaWUZce7Vw+aqubE50Xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YJXT7WZLqSX3pJoQZatlOO8k357fgcmwT50/a9+0bpSwms5XS4r5Q/DODhkcWyw9j
	 2aMVPWmdph5X/WkyzB8MnJcIBX6uHBJ9mkRn1sEnO6EKLUOCsOmJLr59+hOslaFfhZ
	 awAzqrJPVSd5u/YOjiLgFOQYi7zVUgYuH3Fe75j2X9MuXr37ZpMK9EbMEi5tOFPMzN
	 eRNg71qoeswCCVxZiezMWVe1MhxtLH8AoEd2E06BqUCGC3XTOulnVxNTkuIqJwDRb4
	 RYLL141ypcXvsSLDWkNyM5fxWQPDGHkKWzr0XOVKiwRzSyHtxzv0r/EXjmnDtsUJWT
	 +wWNc+isw4ziw==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	acourbot@nvidia.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	pcolberg@redhat.com
Cc: rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 2/8] rust: device: introduce Device::drvdata()
Date: Tue, 21 Oct 2025 00:34:24 +0200
Message-ID: <20251020223516.241050-3-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020223516.241050-1-dakr@kernel.org>
References: <20251020223516.241050-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In C dev_get_drvdata() has specific requirements under which it is valid
to access the returned pointer. That is, drivers have to ensure that

  (1) for the duration the returned pointer is accessed the driver is
      bound and remains to be bound to the corresponding device,

  (2) the returned void * is treated according to the driver's private
      data type, i.e. according to what has been passed to
      dev_set_drvdata().

In Rust, (1) can be ensured by simply requiring the Bound device
context, i.e. provide the drvdata() method for Device<Bound> only.

For (2) we would usually make the device type generic over the driver
type, e.g. Device<T: Driver>, where <T as Driver>::Data is the type of
the driver's private data.

However, a device does not have a driver type known at compile time and
may be bound to multiple drivers throughout its lifetime.

Hence, in order to be able to provide a safe accessor for the driver's
device private data, we have to do the type check on runtime.

This is achieved by letting a driver assert the expected type, which is
then compared to a type hash stored in struct device_private when
dev_set_drvdata() is called.

Example:

	// `dev` is a `&Device<Bound>`.
	let data = dev.drvdata::<SampleDriver>()?;

There are two aspects to note:

  (1) Technically, the same check could be achieved by comparing the
      struct device_driver pointer of struct device with the struct
      device_driver pointer of the driver struct (e.g. struct
      pci_driver).

      However, this would - in addition the pointer comparison - require
      to tie back the private driver data type to the struct
      device_driver pointer of the driver struct to prove correctness.

      Besides that, accessing the driver struct (stored in the module
      structure) isn't trivial and would result into horrible code and
      API ergonomics.

  (2) Having a direct accessor to the driver's private data is not
      commonly required (at least in Rust): Bus callback methods already
      provide access to the driver's device private data through a &self
      argument, while other driver entry points such as IRQs,
      workqueues, timers, IOCTLs, etc. have their own private data with
      separate ownership and lifetime.

      In other words, a driver's device private data is only relevant
      for driver model contexts (such a file private is only relevant
      for file contexts).

Having that said, the motivation for accessing the driver's device
private data with Device<Bound>::drvdata() are interactions between
drivers. For instance, when an auxiliary driver calls back into its
parent, the parent has to be capable to derive its private data from the
corresponding device (i.e. the parent of the auxiliary device).

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/base/base.h             | 16 +++++++
 rust/bindings/bindings_helper.h |  6 +++
 rust/kernel/device.rs           | 79 +++++++++++++++++++++++++++++++--
 3 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 86fa7fbb3548..430cbefbc97f 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -85,6 +85,18 @@ struct driver_private {
 };
 #define to_driver(obj) container_of(obj, struct driver_private, kobj)
 
+#ifdef CONFIG_RUST
+/**
+ * struct driver_type - Representation of a Rust driver type.
+ */
+struct driver_type {
+	/**
+	 * @id: Representation of core::any::TypeId.
+	 */
+	u8 id[16];
+} __packed;
+#endif
+
 /**
  * struct device_private - structure to hold the private to the driver core portions of the device structure.
  *
@@ -100,6 +112,7 @@ struct driver_private {
  * @async_driver - pointer to device driver awaiting probe via async_probe
  * @device - pointer back to the struct device that this structure is
  * associated with.
+ * @driver_type - The type of the bound Rust driver.
  * @dead - This device is currently either in the process of or has been
  *	removed from the system. Any asynchronous events scheduled for this
  *	device should exit without taking any action.
@@ -116,6 +129,9 @@ struct device_private {
 	const struct device_driver *async_driver;
 	char *deferred_probe_reason;
 	struct device *device;
+#ifdef CONFIG_RUST
+	struct driver_type driver_type;
+#endif
 	u8 dead:1;
 };
 #define to_device_private_parent(obj)	\
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 2e43c66635a2..a79fd111f886 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -85,6 +85,12 @@
 #include <linux/xarray.h>
 #include <trace/events/rust_sample.h>
 
+/*
+ * The driver-core Rust code needs to know about some C driver-core private
+ * structures.
+ */
+#include <../../drivers/base/base.h>
+
 #if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
 // Used by `#[export]` in `drivers/gpu/drm/drm_panic_qr.rs`.
 #include <drm/drm_panic.h>
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 106aa57a6385..36c6eec0ceab 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -10,13 +10,19 @@
     sync::aref::ARef,
     types::{ForeignOwnable, Opaque},
 };
-use core::{marker::PhantomData, ptr};
+use core::{any::TypeId, marker::PhantomData, ptr};
 
 #[cfg(CONFIG_PRINTK)]
 use crate::c_str;
 
 pub mod property;
 
+// Compile-time checks.
+const _: () = {
+    // Assert that we can `read()` / `write()` a `TypeId` instance from / into `struct driver_type`.
+    static_assert!(core::mem::size_of::<bindings::driver_type>() == core::mem::size_of::<TypeId>());
+};
+
 /// The core representation of a device in the kernel's driver model.
 ///
 /// This structure represents the Rust abstraction for a C `struct device`. A [`Device`] can either
@@ -198,12 +204,29 @@ pub unsafe fn as_bound(&self) -> &Device<Bound> {
 }
 
 impl Device<CoreInternal> {
+    fn type_id_store<T: 'static>(&self) {
+        // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
+        let private = unsafe { (*self.as_raw()).p };
+
+        // SAFETY: For a bound device (implied by the `CoreInternal` device context), `private` is
+        // guaranteed to be a valid pointer to a `struct device_private`.
+        let driver_type = unsafe { &raw mut (*private).driver_type };
+
+        // SAFETY: `driver_type` is valid for (unaligned) writes of a `TypeId`.
+        unsafe {
+            driver_type
+                .cast::<TypeId>()
+                .write_unaligned(TypeId::of::<T>())
+        };
+    }
+
     /// Store a pointer to the bound driver's private data.
     pub fn set_drvdata<T: 'static>(&self, data: impl PinInit<T, Error>) -> Result {
         let data = KBox::pin_init(data, GFP_KERNEL)?;
 
         // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
         unsafe { bindings::dev_set_drvdata(self.as_raw(), data.into_foreign().cast()) };
+        self.type_id_store::<T>();
 
         Ok(())
     }
@@ -235,7 +258,23 @@ pub unsafe fn drvdata_obtain<T: 'static>(&self) -> Pin<KBox<T>> {
     ///   [`Device::drvdata_obtain`].
     /// - The type `T` must match the type of the `ForeignOwnable` previously stored by
     ///   [`Device::set_drvdata`].
-    pub unsafe fn drvdata_borrow<T: ForeignOwnable>(&self) -> T::Borrowed<'_> {
+    pub unsafe fn drvdata_borrow<T: 'static>(&self) -> Pin<&T> {
+        // SAFETY: `drvdata_unchecked()` has the exact same safety requirements as the ones
+        // required by this method.
+        unsafe { self.drvdata_unchecked() }
+    }
+}
+
+impl Device<Bound> {
+    /// Borrow the driver's private data bound to this [`Device`].
+    ///
+    /// # Safety
+    ///
+    /// - Must only be called after a preceding call to [`Device::set_drvdata`] and before
+    ///   [`Device::drvdata_obtain`].
+    /// - The type `T` must match the type of the `ForeignOwnable` previously stored by
+    ///   [`Device::set_drvdata`].
+    unsafe fn drvdata_unchecked<T: 'static>(&self) -> Pin<&T> {
         // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
         let ptr = unsafe { bindings::dev_get_drvdata(self.as_raw()) };
 
@@ -244,7 +283,41 @@ pub unsafe fn drvdata_borrow<T: ForeignOwnable>(&self) -> T::Borrowed<'_> {
         //   `into_foreign()`.
         // - `dev_get_drvdata()` guarantees to return the same pointer given to `dev_set_drvdata()`
         //   in `into_foreign()`.
-        unsafe { T::borrow(ptr.cast()) }
+        unsafe { Pin::<KBox<T>>::borrow(ptr.cast()) }
+    }
+
+    fn type_id_match<T: 'static>(&self) -> Result {
+        // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
+        let private = unsafe { (*self.as_raw()).p };
+
+        // SAFETY: For a bound device, `private` is guaranteed to be a valid pointer to a
+        // `struct device_private`.
+        let driver_type = unsafe { &raw mut (*private).driver_type };
+
+        // SAFETY:
+        // - `driver_type` is valid for (unaligned) reads of a `TypeId`.
+        // - A bound device guarantees that `driver_type` contains a valid `TypeId` value.
+        let type_id = unsafe { driver_type.cast::<TypeId>().read_unaligned() };
+
+        if type_id != TypeId::of::<T>() {
+            return Err(EINVAL);
+        }
+
+        Ok(())
+    }
+
+    /// Access a driver's private data.
+    ///
+    /// Returns a pinned reference to the driver's private data or [`EINVAL`] if it doesn't match
+    /// the asserted type `T`.
+    pub fn drvdata<T: 'static>(&self) -> Result<Pin<&T>> {
+        self.type_id_match::<T>()?;
+
+        // SAFETY:
+        // - The `Bound` device context guarantees that this is only ever call after a call
+        //   to `set_drvdata()` and before `drvdata_obtain()`.
+        // - We've just checked that the type of the driver's private data is in fact `T`.
+        Ok(unsafe { self.drvdata_unchecked() })
     }
 }
 
-- 
2.51.0


