Return-Path: <linux-pci+bounces-30558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222ABAE71C8
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 23:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728C2178C1E
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 21:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C491E25B2F9;
	Tue, 24 Jun 2025 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RF9IcWfw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F412550A4;
	Tue, 24 Jun 2025 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750802181; cv=none; b=kLCbLg05XIsearv2ZZSFvvlx+0VDq8lWe/R/YbxXDMp1bPSNp+vmSgitGu0yiuY9/M5efwC+fBWNSsPJbBOahKyBL9udM4GTXCdrxk7euyRKjl/f8jSnrcz/UtapsFZUy0jBYfDHx3MmP3/nAp29ft/QocF3+LySKCmgwsaidOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750802181; c=relaxed/simple;
	bh=dx4a+bZV5PhRq106yEHXAnSF/szd9gVYUC+VoZ6iawU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTJIb/fwhYSdsy2bW+/HgU6T22KTLW1/n69U3aR2A4T/DqlCYZl09xBZtiTGJgoYkXba7awxPz/TqgxXEzuY2cbqWM5OWim42ZaHN8i0SWOc8exdA7IZo+SFdQJIpxMlMEuLhzE6cvUG1dbK86W9WdQepBOdaKX+AC31O7Co2ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RF9IcWfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19266C4CEF0;
	Tue, 24 Jun 2025 21:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750802181;
	bh=dx4a+bZV5PhRq106yEHXAnSF/szd9gVYUC+VoZ6iawU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RF9IcWfw0dM3URYiIt3+mvZbseedpWL+SCw6Za4KbBA8XvDjD+Udc/PU1I/sGNJo0
	 ka1//ElVGOwgzDRBv8eKWyP7D+SL9SLZQwLiBetk+2OYw5dkKeBvTfldR6R1x5zRge
	 35/7+3CA7Sj3pqkfH2Vzj7q4SywAazBPFWm8RJ56r/r3DCedaCZarGfcCkC6apk2Fu
	 9dKUmMt7ilE7yi3EVjKNdsdH1YdXEVNJEO7gz+MV8afJg1jEiWyngv3YXG1j6zPQRK
	 lwCwaFT70ar+/2FLcnTNKS3KJ0wyyr+Dykik3mTw83C2yM+w+DAiHrLE9LvE93BdJh
	 +4CUTXvbwXa8w==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 3/4] rust: devres: get rid of Devres' inner Arc
Date: Tue, 24 Jun 2025 23:54:01 +0200
Message-ID: <20250624215600.221167-4-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624215600.221167-1-dakr@kernel.org>
References: <20250624215600.221167-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So far Devres uses an inner memory allocation and reference count, i.e.
an inner Arc, in order to ensure that the devres callback can't run into
a use-after-free in case where the Devres object is dropped while the
devres callback runs concurrently.

Instead, use a completion in order to avoid a potential UAF: In
Devres::drop(), if we detect that we can't remove the devres action
anymore, we wait for the completion that is completed from the devres
callback. If, in turn, we were able to successfully remove the devres
action, we can just go ahead.

This, again, allows us to get rid of the internal Arc, and instead let
Devres consume an `impl PinInit<T, E>` in order to return an
`impl PinInit<Devres<T>, E>`, which enables us to get away with less
memory allocations.

Additionally, having the resulting explicit synchronization in
Devres::drop() prevents potential subtle undesired side effects of the
devres callback dropping the final Arc reference asynchronously within
the devres callback.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/driver.rs |   7 +-
 drivers/gpu/nova-core/gpu.rs    |   6 +-
 rust/kernel/devres.rs           | 210 +++++++++++++++++++-------------
 rust/kernel/pci.rs              |  20 +--
 samples/rust/rust_driver_pci.rs |  19 +--
 5 files changed, 151 insertions(+), 111 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 8c86101c26cb..110f2b355db4 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::{auxiliary, bindings, c_str, device::Core, pci, prelude::*};
+use kernel::{auxiliary, bindings, c_str, device::Core, pci, prelude::*, sync::Arc};
 
 use crate::gpu::Gpu;
 
@@ -34,7 +34,10 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self
         pdev.enable_device_mem()?;
         pdev.set_master();
 
-        let bar = pdev.iomap_region_sized::<BAR0_SIZE>(0, c_str!("nova-core/bar0"))?;
+        let bar = Arc::pin_init(
+            pdev.iomap_region_sized::<BAR0_SIZE>(0, c_str!("nova-core/bar0")),
+            GFP_KERNEL,
+        )?;
 
         let this = KBox::pin_init(
             try_pin_init!(Self {
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 60b86f370284..47653c14838b 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::{device, devres::Devres, error::code::*, pci, prelude::*};
+use kernel::{device, devres::Devres, error::code::*, pci, prelude::*, sync::Arc};
 
 use crate::driver::Bar0;
 use crate::firmware::{Firmware, FIRMWARE_VERSION};
@@ -161,14 +161,14 @@ fn new(bar: &Bar0) -> Result<Spec> {
 pub(crate) struct Gpu {
     spec: Spec,
     /// MMIO mapping of PCI BAR 0
-    bar: Devres<Bar0>,
+    bar: Arc<Devres<Bar0>>,
     fw: Firmware,
 }
 
 impl Gpu {
     pub(crate) fn new(
         pdev: &pci::Device<device::Bound>,
-        devres_bar: Devres<Bar0>,
+        devres_bar: Arc<Devres<Bar0>>,
     ) -> Result<impl PinInit<Self>> {
         let bar = devres_bar.access(pdev.as_ref())?;
         let spec = Spec::new(bar)?;
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 47ead37faf4c..eeffdc8115aa 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -13,16 +13,21 @@
     ffi::c_void,
     prelude::*,
     revocable::{Revocable, RevocableGuard},
-    sync::{rcu, Arc, Completion},
-    types::{ARef, ForeignOwnable},
+    sync::{rcu, Completion},
+    types::{ARef, ForeignOwnable, ScopeGuard, Opaque},
 };
 
+use pin_init::Wrapper;
+
+/// [`Devres`] inner data accessed from [`Devres::callback`].
 #[pin_data]
-struct DevresInner<T> {
-    dev: ARef<Device>,
-    callback: unsafe extern "C" fn(*mut c_void),
+struct Inner<T> {
     #[pin]
     data: Revocable<T>,
+    /// Tracks whether [`Devres::callback`] has been completed.
+    #[pin]
+    devm: Completion,
+    /// Tracks whether revoking [`Self::data`] has been completed.
     #[pin]
     revoke: Completion,
 }
@@ -44,6 +49,10 @@ struct DevresInner<T> {
 /// [`Devres`] users should make sure to simply free the corresponding backing resource in `T`'s
 /// [`Drop`] implementation.
 ///
+/// # Invariants
+///
+/// [`Self::inner`] is guaranteed to be initialized and is always accessed read-only.
+///
 /// # Example
 ///
 /// ```no_run
@@ -88,100 +97,108 @@ struct DevresInner<T> {
 /// # fn no_run(dev: &Device<Bound>) -> Result<(), Error> {
 /// // SAFETY: Invalid usage for example purposes.
 /// let iomem = unsafe { IoMem::<{ core::mem::size_of::<u32>() }>::new(0xBAAAAAAD)? };
-/// let devres = Devres::new(dev, iomem, GFP_KERNEL)?;
+/// let devres = KBox::pin_init(Devres::new(dev, iomem), GFP_KERNEL)?;
 ///
 /// let res = devres.try_access().ok_or(ENXIO)?;
 /// res.write8(0x42, 0x0);
 /// # Ok(())
 /// # }
 /// ```
-pub struct Devres<T>(Arc<DevresInner<T>>);
+#[pin_data(PinnedDrop)]
+pub struct Devres<T> {
+    dev: ARef<Device>,
+    /// Pointer to [`Self::devres_callback`].
+    ///
+    /// Has to be stored, since Rust does not guarantee to always return the same address for a
+    /// function. However, the C API uses the address as a key.
+    callback: unsafe extern "C" fn(*mut c_void),
+    /// Contains all the fields shared with [`Self::callback`].
+    // TODO: Replace with `UnsafePinned`, once available.
+    #[pin]
+    inner: Opaque<Inner<T>>,
+}
+
+impl<T> Devres<T> {
+    /// Creates a new [`Devres`] instance of the given `data`.
+    ///
+    /// The `data` encapsulated within the returned `Devres` instance' `data` will be
+    /// (revoked)[`Revocable`] once the device is detached.
+    pub fn new<'a, E>(
+        dev: &'a Device<Bound>,
+        data: impl PinInit<T, E> + 'a,
+    ) -> impl PinInit<Self, Error> + 'a
+    where
+        T: 'a,
+        Error: From<E>,
+    {
+        let callback = Self::devres_callback;
 
-impl<T> DevresInner<T> {
-    fn new(dev: &Device<Bound>, data: T, flags: Flags) -> Result<Arc<DevresInner<T>>> {
-        let inner = Arc::pin_init(
-            try_pin_init!( DevresInner {
-                dev: dev.into(),
-                callback: Self::devres_callback,
+        try_pin_init!(&this in Self {
+            // INVARIANT: `inner` is properly initialized.
+            inner <- Opaque::pin_init(try_pin_init!(Inner {
                 data <- Revocable::new(data),
+                devm <- Completion::new(),
                 revoke <- Completion::new(),
-            }),
-            flags,
-        )?;
-
-        // Convert `Arc<DevresInner>` into a raw pointer and make devres own this reference until
-        // `Self::devres_callback` is called.
-        let data = inner.clone().into_raw();
+            })),
+            callback,
+            dev: {
+                // SAFETY: `this` is a valid pointer to uninitialized memory.
+                let inner = unsafe { &raw mut (*this.as_ptr()).inner };
 
-        // SAFETY: `devm_add_action` guarantees to call `Self::devres_callback` once `dev` is
-        // detached.
-        let ret =
-            unsafe { bindings::devm_add_action(dev.as_raw(), Some(inner.callback), data as _) };
-
-        if ret != 0 {
-            // SAFETY: We just created another reference to `inner` in order to pass it to
-            // `bindings::devm_add_action`. If `bindings::devm_add_action` fails, we have to drop
-            // this reference accordingly.
-            let _ = unsafe { Arc::from_raw(data) };
-            return Err(Error::from_errno(ret));
-        }
+                // SAFETY:
+                // - `dev.as_raw()` is a pointer to a valid bound device.
+                // - `inner` is guaranteed to be a valid for the duration of the lifetime of `Self`.
+                // - `devm_add_action()` is guaranteed not to call `callback` until `this` has been
+                //    properly initialized, because we require `dev` (i.e. the *bound* device) to
+                //    live at least as long as the returned `impl PinInit<Self, Error>`.
+                to_result(unsafe {
+                    bindings::devm_add_action(dev.as_raw(), Some(callback), inner.cast())
+                })?;
 
-        Ok(inner)
+                dev.into()
+            },
+        })
     }
 
-    fn as_ptr(&self) -> *const Self {
-        self as _
+    fn inner(&self) -> &Inner<T> {
+        // SAFETY: By the type invairants of `Self`, `inner` is properly initialized and always
+        // accessed read-only.
+        unsafe { &*self.inner.get() }
     }
 
-    fn remove_action(this: &Arc<Self>) -> bool {
-        // SAFETY:
-        // - `self.inner.dev` is a valid `Device`,
-        // - the `action` and `data` pointers are the exact same ones as given to devm_add_action()
-        //   previously,
-        // - `self` is always valid, even if the action has been released already.
-        let success = unsafe {
-            bindings::devm_remove_action_nowarn(
-                this.dev.as_raw(),
-                Some(this.callback),
-                this.as_ptr() as _,
-            )
-        } == 0;
-
-        if success {
-            // SAFETY: We leaked an `Arc` reference to devm_add_action() in `DevresInner::new`; if
-            // devm_remove_action_nowarn() was successful we can (and have to) claim back ownership
-            // of this reference.
-            let _ = unsafe { Arc::from_raw(this.as_ptr()) };
-        }
-
-        success
+    fn data(&self) -> &Revocable<T> {
+        &self.inner().data
     }
 
     #[allow(clippy::missing_safety_doc)]
     unsafe extern "C" fn devres_callback(ptr: *mut kernel::ffi::c_void) {
-        let ptr = ptr as *mut DevresInner<T>;
-        // Devres owned this memory; now that we received the callback, drop the `Arc` and hence the
-        // reference.
-        // SAFETY: Safe, since we leaked an `Arc` reference to devm_add_action() in
-        //         `DevresInner::new`.
-        let inner = unsafe { Arc::from_raw(ptr) };
+        // SAFETY: In `Self::new` we've passed a valid pointer to `Inner` to `devm_add_action()`,
+        // hence `ptr` must be a valid pointer to `Inner`.
+        let inner = unsafe { &*ptr.cast::<Inner<T>>() };
+
+        // Ensure that `inner` can't be used anymore after we signal completion of this callback.
+        let inner = ScopeGuard::new_with_data(inner, |inner| inner.devm.complete_all());
 
         if !inner.data.revoke() {
             // If `revoke()` returns false, it means that `Devres::drop` already started revoking
-            // `inner.data` for us. Hence we have to wait until `Devres::drop()` signals that it
-            // completed revoking `inner.data`.
+            // `data` for us. Hence we have to wait until `Devres::drop` signals that it
+            // completed revoking `data`.
             inner.revoke.wait_for_completion();
         }
     }
-}
 
-impl<T> Devres<T> {
-    /// Creates a new [`Devres`] instance of the given `data`. The `data` encapsulated within the
-    /// returned `Devres` instance' `data` will be revoked once the device is detached.
-    pub fn new(dev: &Device<Bound>, data: T, flags: Flags) -> Result<Self> {
-        let inner = DevresInner::new(dev, data, flags)?;
-
-        Ok(Devres(inner))
+    fn remove_action(&self) -> bool {
+        // SAFETY:
+        // - `self.dev` is a valid `Device`,
+        // - the `action` and `data` pointers are the exact same ones as given to
+        //   `devm_add_action()` previously,
+        (unsafe {
+            bindings::devm_remove_action_nowarn(
+                self.dev.as_raw(),
+                Some(self.callback),
+                core::ptr::from_ref(self.inner()).cast_mut().cast(),
+            )
+        } == 0)
     }
 
     /// Obtain `&'a T`, bypassing the [`Revocable`].
@@ -213,44 +230,63 @@ pub fn new(dev: &Device<Bound>, data: T, flags: Flags) -> Result<Self> {
     /// }
     /// ```
     pub fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Result<&'a T> {
-        if self.0.dev.as_raw() != dev.as_raw() {
+        if self.dev.as_raw() != dev.as_raw() {
             return Err(EINVAL);
         }
 
         // SAFETY: `dev` being the same device as the device this `Devres` has been created for
-        // proves that `self.0.data` hasn't been revoked and is guaranteed to not be revoked as
-        // long as `dev` lives; `dev` lives at least as long as `self`.
-        Ok(unsafe { self.0.data.access() })
+        // proves that `self.data` hasn't been revoked and is guaranteed to not be revoked as long
+        // as `dev` lives; `dev` lives at least as long as `self`.
+        Ok(unsafe { self.data().access() })
     }
 
     /// [`Devres`] accessor for [`Revocable::try_access`].
     pub fn try_access(&self) -> Option<RevocableGuard<'_, T>> {
-        self.0.data.try_access()
+        self.data().try_access()
     }
 
     /// [`Devres`] accessor for [`Revocable::try_access_with`].
     pub fn try_access_with<R, F: FnOnce(&T) -> R>(&self, f: F) -> Option<R> {
-        self.0.data.try_access_with(f)
+        self.data().try_access_with(f)
     }
 
     /// [`Devres`] accessor for [`Revocable::try_access_with_guard`].
     pub fn try_access_with_guard<'a>(&'a self, guard: &'a rcu::Guard) -> Option<&'a T> {
-        self.0.data.try_access_with_guard(guard)
+        self.data().try_access_with_guard(guard)
     }
 }
 
-impl<T> Drop for Devres<T> {
-    fn drop(&mut self) {
+// SAFETY: `Devres` can be send to any task, if `T: Send`.
+unsafe impl<T: Send> Send for Devres<T> {}
+
+// SAFETY: `Devres` can be shared with any task, if `T: Sync`.
+unsafe impl<T: Sync> Sync for Devres<T> {}
+
+#[pinned_drop]
+impl<T> PinnedDrop for Devres<T> {
+    fn drop(self: Pin<&mut Self>) {
         // SAFETY: When `drop` runs, it is guaranteed that nobody is accessing the revocable data
         // anymore, hence it is safe not to wait for the grace period to finish.
-        if unsafe { self.0.data.revoke_nosync() } {
-            // We revoked `self.0.data` before the devres action did, hence try to remove it.
-            if !DevresInner::remove_action(&self.0) {
+        if unsafe { self.data().revoke_nosync() } {
+            // We revoked `self.data` before the devres action did, hence try to remove it.
+            if !self.remove_action() {
                 // We could not remove the devres action, which means that it now runs concurrently,
-                // hence signal that `self.0.data` has been revoked successfully.
-                self.0.revoke.complete_all();
+                // hence signal that `self.data` has been revoked by us successfully.
+                self.inner().revoke.complete_all();
+
+                // Wait for `Self::devres_callback` to be done using this object.
+                self.inner().devm.wait_for_completion();
             }
+        } else {
+            // `Self::devres_callback` revokes `self.data` for us, hence wait for it to be done
+            // using this object.
+            self.inner().devm.wait_for_completion();
         }
+
+        // INVARIANT: At this point it is guaranteed that `inner` can't be accessed any more.
+        //
+        // SAFETY: `inner` is valid for dropping.
+        unsafe { core::ptr::drop_in_place(self.inner.get()) };
     }
 }
 
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 8435f8132e38..db0eb7eaf9b1 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -5,7 +5,6 @@
 //! C header: [`include/linux/pci.h`](srctree/include/linux/pci.h)
 
 use crate::{
-    alloc::flags::*,
     bindings, container_of, device,
     device_id::RawDeviceId,
     devres::Devres,
@@ -398,19 +397,20 @@ pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
 impl Device<device::Bound> {
     /// Mapps an entire PCI-BAR after performing a region-request on it. I/O operation bound checks
     /// can be performed on compile time for offsets (plus the requested type size) < SIZE.
-    pub fn iomap_region_sized<const SIZE: usize>(
-        &self,
+    pub fn iomap_region_sized<'a, const SIZE: usize>(
+        &'a self,
         bar: u32,
-        name: &CStr,
-    ) -> Result<Devres<Bar<SIZE>>> {
-        let bar = Bar::<SIZE>::new(self, bar, name)?;
-        let devres = Devres::new(self.as_ref(), bar, GFP_KERNEL)?;
-
-        Ok(devres)
+        name: &'a CStr,
+    ) -> impl PinInit<Devres<Bar<SIZE>>, Error> + 'a {
+        Devres::new(self.as_ref(), Bar::<SIZE>::new(self, bar, name))
     }
 
     /// Mapps an entire PCI-BAR after performing a region-request on it.
-    pub fn iomap_region(&self, bar: u32, name: &CStr) -> Result<Devres<Bar>> {
+    pub fn iomap_region<'a>(
+        &'a self,
+        bar: u32,
+        name: &'a CStr,
+    ) -> impl PinInit<Devres<Bar>, Error> + 'a {
         self.iomap_region_sized::<0>(bar, name)
     }
 }
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 15147e4401b2..5c35f1414172 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -25,8 +25,10 @@ impl TestIndex {
     const NO_EVENTFD: Self = Self(0);
 }
 
+#[pin_data(PinnedDrop)]
 struct SampleDriver {
     pdev: ARef<pci::Device>,
+    #[pin]
     bar: Devres<Bar0>,
 }
 
@@ -73,13 +75,11 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>
         pdev.enable_device_mem()?;
         pdev.set_master();
 
-        let bar = pdev.iomap_region_sized::<{ Regs::END }>(0, c_str!("rust_driver_pci"))?;
-
-        let drvdata = KBox::new(
-            Self {
+        let drvdata = KBox::pin_init(
+            try_pin_init!(Self {
                 pdev: pdev.into(),
-                bar,
-            },
+                bar <- pdev.iomap_region_sized::<{ Regs::END }>(0, c_str!("rust_driver_pci")),
+            }),
             GFP_KERNEL,
         )?;
 
@@ -90,12 +90,13 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>
             Self::testdev(info, bar)?
         );
 
-        Ok(drvdata.into())
+        Ok(drvdata)
     }
 }
 
-impl Drop for SampleDriver {
-    fn drop(&mut self) {
+#[pinned_drop]
+impl PinnedDrop for SampleDriver {
+    fn drop(self: Pin<&mut Self>) {
         dev_dbg!(self.pdev.as_ref(), "Remove Rust PCI driver sample.\n");
     }
 }
-- 
2.49.0


