Return-Path: <linux-pci+bounces-38817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1275BF3ED3
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 00:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DE564E4797
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 22:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04852F49E5;
	Mon, 20 Oct 2025 22:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezjbZV7f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DBD2F3C38;
	Mon, 20 Oct 2025 22:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999752; cv=none; b=H2jDfngGw5eQLlCrYWTH6BAB/X9r6715+cwafyW6E15A1xKbOBBkWq4RkrZIOMPAkIxtx3la38L3MG2MSFP/13Fe8PHrChpjCIc2GdScFgswM1i/5B/F77sw58W9hUyDZdtjhBT3LZ6KNyF26HRrsMZ1TRSp2bPVUgaKo6YZ2fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999752; c=relaxed/simple;
	bh=5W2Rc7W4plwT9rV2E/o75Pa4S1pZCmfpN1yvJ6DOa5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WumsTZWFoRAx/VJHcJWvBMIhM0Aj070sRsCgM5QGLMqbzK3gYf4/o9HOys8iwhduZZJLooJJv4gI9kIPMiPfjp5vIkRC436E94B7/82xMTMDF4V4q9vngXRE3/o7wfLP66oaeoH+NEVvfidxwlfULn9xv7Hzo3GZVCwiH/K3OLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezjbZV7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A042C116C6;
	Mon, 20 Oct 2025 22:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760999752;
	bh=5W2Rc7W4plwT9rV2E/o75Pa4S1pZCmfpN1yvJ6DOa5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ezjbZV7fD/n+h+Cw3+4SwhHrCbO7HJOZ5NuMsmqAfQIS8YjaF0/3/icq4qs85gQr6
	 zEwAm6gBLoXbISfOjW6Da3rguugidtlR1Xs6PHMtlWdxEBDx4eM2jsYV3PmF9UfnJz
	 Trtg+nEHoeQvCJNVA47z+IGgNQCCQB+FeK88YZy4RYxLZ1RSVvSWqUECechVRizb2n
	 UczIeXRMO1/tRd7JIhNhCh0q1MxuXUdY9CkaZsk2lKZE1MznYF0HhMQ4efB5LsWAu8
	 wJtIdL549wyGeFQurGNla7iPOKnhjH/99erECAFvwTonE/YvswCTyqelh3EH1OF9+U
	 m8iOUbQzR6raQ==
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
Subject: [PATCH 4/8] rust: auxiliary: unregister on parent device unbind
Date: Tue, 21 Oct 2025 00:34:26 +0200
Message-ID: <20251020223516.241050-5-dakr@kernel.org>
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

Guarantee that an auxiliary driver will be unbound before its parent is
unbound; there is no point in operating an auxiliary device whose parent
has been unbound.

In practice, this guarantee allows us to assume that for a bound
auxiliary device, also the parent device is bound.

This is useful when an auxiliary driver calls into its parent, since it
allows the parent to directly access device resources and its device
private data due to the guaranteed bound device context.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/driver.rs       |  8 ++-
 rust/kernel/auxiliary.rs              | 89 +++++++++++++++------------
 samples/rust/rust_driver_auxiliary.rs | 17 ++---
 3 files changed, 66 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index a83b86199182..ca0d5f8ad54b 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -3,6 +3,7 @@
 use kernel::{
     auxiliary, c_str,
     device::Core,
+    devres::Devres,
     pci,
     pci::{Class, ClassMask, Vendor},
     prelude::*,
@@ -16,7 +17,8 @@
 pub(crate) struct NovaCore {
     #[pin]
     pub(crate) gpu: Gpu,
-    _reg: auxiliary::Registration,
+    #[pin]
+    _reg: Devres<auxiliary::Registration>,
 }
 
 const BAR0_SIZE: usize = SZ_16M;
@@ -65,12 +67,12 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, E
 
             Ok(try_pin_init!(Self {
                 gpu <- Gpu::new(pdev, bar.clone(), bar.access(pdev.as_ref())?),
-                _reg: auxiliary::Registration::new(
+                _reg <- auxiliary::Registration::new(
                     pdev.as_ref(),
                     c_str!("nova-drm"),
                     0, // TODO[XARR]: Once it lands, use XArray; for now we don't use the ID.
                     crate::MODULE_NAME
-                )?,
+                ),
             }))
         })
     }
diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index e5bddb738d58..8c0a2472c26a 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -7,6 +7,7 @@
 use crate::{
     bindings, container_of, device,
     device_id::{RawDeviceId, RawDeviceIdIndex},
+    devres::Devres,
     driver,
     error::{from_result, to_result, Result},
     prelude::*,
@@ -279,8 +280,8 @@ unsafe impl Sync for Device {}
 
 /// The registration of an auxiliary device.
 ///
-/// This type represents the registration of a [`struct auxiliary_device`]. When an instance of this
-/// type is dropped, its respective auxiliary device will be unregistered from the system.
+/// This type represents the registration of a [`struct auxiliary_device`]. When its parent device
+/// is unbound, the corresponding auxiliary device will be unregistered from the system.
 ///
 /// # Invariants
 ///
@@ -290,44 +291,56 @@ unsafe impl Sync for Device {}
 
 impl Registration {
     /// Create and register a new auxiliary device.
-    pub fn new(parent: &device::Device, name: &CStr, id: u32, modname: &CStr) -> Result<Self> {
-        let boxed = KBox::new(Opaque::<bindings::auxiliary_device>::zeroed(), GFP_KERNEL)?;
-        let adev = boxed.get();
+    pub fn new<'a>(
+        parent: &'a device::Device<device::Bound>,
+        name: &'a CStr,
+        id: u32,
+        modname: &'a CStr,
+    ) -> impl PinInit<Devres<Self>, Error> + 'a {
+        pin_init::pin_init_scope(move || {
+            let boxed = KBox::new(Opaque::<bindings::auxiliary_device>::zeroed(), GFP_KERNEL)?;
+            let adev = boxed.get();
+
+            // SAFETY: It's safe to set the fields of `struct auxiliary_device` on initialization.
+            unsafe {
+                (*adev).dev.parent = parent.as_raw();
+                (*adev).dev.release = Some(Device::release);
+                (*adev).name = name.as_char_ptr();
+                (*adev).id = id;
+            }
 
-        // SAFETY: It's safe to set the fields of `struct auxiliary_device` on initialization.
-        unsafe {
-            (*adev).dev.parent = parent.as_raw();
-            (*adev).dev.release = Some(Device::release);
-            (*adev).name = name.as_char_ptr();
-            (*adev).id = id;
-        }
-
-        // SAFETY: `adev` is guaranteed to be a valid pointer to a `struct auxiliary_device`,
-        // which has not been initialized yet.
-        unsafe { bindings::auxiliary_device_init(adev) };
-
-        // Now that `adev` is initialized, leak the `Box`; the corresponding memory will be freed
-        // by `Device::release` when the last reference to the `struct auxiliary_device` is dropped.
-        let _ = KBox::into_raw(boxed);
-
-        // SAFETY:
-        // - `adev` is guaranteed to be a valid pointer to a `struct auxiliary_device`, which has
-        //   been initialialized,
-        // - `modname.as_char_ptr()` is a NULL terminated string.
-        let ret = unsafe { bindings::__auxiliary_device_add(adev, modname.as_char_ptr()) };
-        if ret != 0 {
             // SAFETY: `adev` is guaranteed to be a valid pointer to a `struct auxiliary_device`,
-            // which has been initialialized.
-            unsafe { bindings::auxiliary_device_uninit(adev) };
-
-            return Err(Error::from_errno(ret));
-        }
-
-        // SAFETY: `adev` is guaranteed to be non-null, since the `KBox` was allocated successfully.
-        //
-        // INVARIANT: The device will remain registered until `auxiliary_device_delete()` is called,
-        // which happens in `Self::drop()`.
-        Ok(Self(unsafe { NonNull::new_unchecked(adev) }))
+            // which has not been initialized yet.
+            unsafe { bindings::auxiliary_device_init(adev) };
+
+            // Now that `adev` is initialized, leak the `Box`; the corresponding memory will be
+            // freed by `Device::release` when the last reference to the `struct auxiliary_device`
+            // is dropped.
+            let _ = KBox::into_raw(boxed);
+
+            // SAFETY:
+            // - `adev` is guaranteed to be a valid pointer to a `struct auxiliary_device`, which
+            //   has been initialized,
+            // - `modname.as_char_ptr()` is a NULL terminated string.
+            let ret = unsafe { bindings::__auxiliary_device_add(adev, modname.as_char_ptr()) };
+            if ret != 0 {
+                // SAFETY: `adev` is guaranteed to be a valid pointer to a
+                // `struct auxiliary_device`, which has been initialized.
+                unsafe { bindings::auxiliary_device_uninit(adev) };
+
+                return Err(Error::from_errno(ret));
+            }
+
+            // SAFETY: `adev` is guaranteed to be non-null, since the `KBox` was allocated
+            // successfully.
+            //
+            // INVARIANT: The device will remain registered until `auxiliary_device_delete()` is
+            // called, which happens in `Self::drop()`.
+            Ok(Devres::new(
+                parent,
+                Self(unsafe { NonNull::new_unchecked(adev) }),
+            ))
+        })
     }
 }
 
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 2e9afeb83d4f..95c552ee9489 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -5,7 +5,8 @@
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
 use kernel::{
-    auxiliary, c_str, device::Core, driver, error::Error, pci, prelude::*, InPlaceModule,
+    auxiliary, c_str, device::Core, devres::Devres, driver, error::Error, pci, prelude::*,
+    InPlaceModule,
 };
 
 use pin_init::PinInit;
@@ -40,8 +41,12 @@ fn probe(adev: &auxiliary::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<S
     }
 }
 
+#[pin_data]
 struct ParentDriver {
-    _reg: [auxiliary::Registration; 2],
+    #[pin]
+    _reg0: Devres<auxiliary::Registration>,
+    #[pin]
+    _reg1: Devres<auxiliary::Registration>,
 }
 
 kernel::pci_device_table!(
@@ -57,11 +62,9 @@ impl pci::Driver for ParentDriver {
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
     fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
-        Ok(Self {
-            _reg: [
-                auxiliary::Registration::new(pdev.as_ref(), AUXILIARY_NAME, 0, MODULE_NAME)?,
-                auxiliary::Registration::new(pdev.as_ref(), AUXILIARY_NAME, 1, MODULE_NAME)?,
-            ],
+        try_pin_init!(Self {
+            _reg0 <- auxiliary::Registration::new(pdev.as_ref(), AUXILIARY_NAME, 0, MODULE_NAME),
+            _reg1 <- auxiliary::Registration::new(pdev.as_ref(), AUXILIARY_NAME, 1, MODULE_NAME),
         })
     }
 }
-- 
2.51.0


