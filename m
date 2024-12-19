Return-Path: <linux-pci+bounces-18797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5899F812F
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 18:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B5C18963CE
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 17:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FD11AA1E6;
	Thu, 19 Dec 2024 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THf07S2Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E76119D88D;
	Thu, 19 Dec 2024 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627929; cv=none; b=UeCFacguEoKFgj9UfzRf8mkJKLI+3R9UH5LUWnxNSQ5eE+JkJ6tCVSYHAPLIwI7o2HSqk7XTD8NbAvR9ttNMGVPIzt5dWe5kWcZR/6rmTr5vBR32W+AM9WGGlaReU/IVoz16eguC7stv2pQqt1Bb2ks6VZO4D3rgW0sYGJ15Exw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627929; c=relaxed/simple;
	bh=806sGdc+WXZZM6TTuQ4uEjpa4z7uGQglRwCVAjKgUZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6FBlQXhvSxs8Y/GVfKNB/CO6Ac7zHLSyrsq/a2WmuvIsvs4sSfo/WF2PVWKsMgmZcSkdiB9XFzixgyPu/R1SFi7pF2pcpBKvYkghsnyXERptCks+Xx2q9ByzWI6ol6aeAsFpKZaI5gcf/wGKOD530POEx66Cl2MeX1+4xgZuj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THf07S2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E97C4CED6;
	Thu, 19 Dec 2024 17:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734627929;
	bh=806sGdc+WXZZM6TTuQ4uEjpa4z7uGQglRwCVAjKgUZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=THf07S2YWz1p3vcbubW65zuxLGN9pCyklN/8IKxGduM+Doc9No4DSoV+12cS3kNrG
	 hH6p391G/WRP7TiGog7P1Ja1zMxkzmYGPStqQuvylXvZ1QVzpgul9M4xwDRK4tM0wz
	 I9ujEJlGu8ioqHTiRkowNrTjlXs+qpnYoT3jABGaRrPtgZMrtk2pD26a+BFwxqN7ph
	 vtllRg9PSxzr/y3bcUkHc8L5mNRuaOkederYq2s+gt0IYKAoDuvX0KS/Y+1hVv118r
	 p0Foh7/6Z8vA0FUlqhDCq0RpzHIBe+KsXtzqr758U07ag+jqyx/1ay5SPoKU40xWv1
	 I7xmr9oe4jPYw==
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
	tmgross@umich.edu,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	airlied@gmail.com,
	fujita.tomonori@gmail.com,
	lina@asahilina.net,
	pstanner@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	robh@kernel.org,
	daniel.almeida@collabora.com,
	saravanak@google.com,
	dirk.behme@de.bosch.com,
	j@jannau.net,
	fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com,
	paulmck@kernel.org
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	rcu@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v7 08/16] rust: add devres abstraction
Date: Thu, 19 Dec 2024 18:04:10 +0100
Message-ID: <20241219170425.12036-9-dakr@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219170425.12036-1-dakr@kernel.org>
References: <20241219170425.12036-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a Rust abstraction for the kernel's devres (device resource
management) implementation.

The Devres type acts as a container to manage the lifetime and
accessibility of device bound resources. Therefore it registers a
devres callback and revokes access to the resource on invocation.

Users of the Devres abstraction can simply free the corresponding
resources in their Drop implementation, which is invoked when either the
Devres instance goes out of scope or the devres callback leads to the
resource being revoked, which implies a call to drop_in_place().

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 MAINTAINERS            |   1 +
 rust/helpers/device.c  |  10 +++
 rust/helpers/helpers.c |   1 +
 rust/kernel/devres.rs  | 178 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |   1 +
 5 files changed, 191 insertions(+)
 create mode 100644 rust/helpers/device.c
 create mode 100644 rust/kernel/devres.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 0cc69e282889..a9ae2d69f961 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7034,6 +7034,7 @@ F:	include/linux/property.h
 F:	lib/kobj*
 F:	rust/kernel/device.rs
 F:	rust/kernel/device_id.rs
+F:	rust/kernel/devres.rs
 F:	rust/kernel/driver.rs
 
 DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
diff --git a/rust/helpers/device.c b/rust/helpers/device.c
new file mode 100644
index 000000000000..b2135c6686b0
--- /dev/null
+++ b/rust/helpers/device.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/device.h>
+
+int rust_helper_devm_add_action(struct device *dev,
+				void (*action)(void *),
+				void *data)
+{
+	return devm_add_action(dev, action, data);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 63f9b1da179f..a3b52aa021de 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -12,6 +12,7 @@
 #include "build_assert.c"
 #include "build_bug.c"
 #include "cred.c"
+#include "device.c"
 #include "err.c"
 #include "fs.c"
 #include "io.c"
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
new file mode 100644
index 000000000000..9c9dd39584eb
--- /dev/null
+++ b/rust/kernel/devres.rs
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Devres abstraction
+//!
+//! [`Devres`] represents an abstraction for the kernel devres (device resource management)
+//! implementation.
+
+use crate::{
+    alloc::Flags,
+    bindings,
+    device::Device,
+    error::{Error, Result},
+    prelude::*,
+    revocable::Revocable,
+    sync::Arc,
+};
+
+use core::ops::Deref;
+
+#[pin_data]
+struct DevresInner<T> {
+    #[pin]
+    data: Revocable<T>,
+}
+
+/// This abstraction is meant to be used by subsystems to containerize [`Device`] bound resources to
+/// manage their lifetime.
+///
+/// [`Device`] bound resources should be freed when either the resource goes out of scope or the
+/// [`Device`] is unbound respectively, depending on what happens first.
+///
+/// To achieve that [`Devres`] registers a devres callback on creation, which is called once the
+/// [`Device`] is unbound, revoking access to the encapsulated resource (see also [`Revocable`]).
+///
+/// After the [`Devres`] has been unbound it is not possible to access the encapsulated resource
+/// anymore.
+///
+/// [`Devres`] users should make sure to simply free the corresponding backing resource in `T`'s
+/// [`Drop`] implementation.
+///
+/// # Example
+///
+/// ```no_run
+/// # use kernel::{bindings, c_str, device::Device, devres::Devres, io::{Io, IoRaw}};
+/// # use core::ops::Deref;
+///
+/// // See also [`pci::Bar`] for a real example.
+/// struct IoMem<const SIZE: usize>(IoRaw<SIZE>);
+///
+/// impl<const SIZE: usize> IoMem<SIZE> {
+///     /// # Safety
+///     ///
+///     /// [`paddr`, `paddr` + `SIZE`) must be a valid MMIO region that is mappable into the CPUs
+///     /// virtual address space.
+///     unsafe fn new(paddr: usize) -> Result<Self>{
+///         // SAFETY: By the safety requirements of this function [`paddr`, `paddr` + `SIZE`) is
+///         // valid for `ioremap`.
+///         let addr = unsafe { bindings::ioremap(paddr as _, SIZE as _) };
+///         if addr.is_null() {
+///             return Err(ENOMEM);
+///         }
+///
+///         Ok(IoMem(IoRaw::new(addr as _, SIZE)?))
+///     }
+/// }
+///
+/// impl<const SIZE: usize> Drop for IoMem<SIZE> {
+///     fn drop(&mut self) {
+///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
+///         unsafe { bindings::iounmap(self.0.addr() as _); };
+///     }
+/// }
+///
+/// impl<const SIZE: usize> Deref for IoMem<SIZE> {
+///    type Target = Io<SIZE>;
+///
+///    fn deref(&self) -> &Self::Target {
+///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
+///         unsafe { Io::from_raw(&self.0) }
+///    }
+/// }
+/// # fn no_run() -> Result<(), Error> {
+/// # // SAFETY: Invalid usage; just for the example to get an `ARef<Device>` instance.
+/// # let dev = unsafe { Device::get_device(core::ptr::null_mut()) };
+///
+/// // SAFETY: Invalid usage for example purposes.
+/// let iomem = unsafe { IoMem::<{ core::mem::size_of::<u32>() }>::new(0xBAAAAAAD)? };
+/// let devres = Devres::new(&dev, iomem, GFP_KERNEL)?;
+///
+/// let res = devres.try_access().ok_or(ENXIO)?;
+/// res.writel(0x42, 0x0);
+/// # Ok(())
+/// # }
+/// ```
+pub struct Devres<T>(Arc<DevresInner<T>>);
+
+impl<T> DevresInner<T> {
+    fn new(dev: &Device, data: T, flags: Flags) -> Result<Arc<DevresInner<T>>> {
+        let inner = Arc::pin_init(
+            pin_init!( DevresInner {
+                data <- Revocable::new(data),
+            }),
+            flags,
+        )?;
+
+        // Convert `Arc<DevresInner>` into a raw pointer and make devres own this reference until
+        // `Self::devres_callback` is called.
+        let data = inner.clone().into_raw();
+
+        // SAFETY: `devm_add_action` guarantees to call `Self::devres_callback` once `dev` is
+        // detached.
+        let ret = unsafe {
+            bindings::devm_add_action(dev.as_raw(), Some(Self::devres_callback), data as _)
+        };
+
+        if ret != 0 {
+            // SAFETY: We just created another reference to `inner` in order to pass it to
+            // `bindings::devm_add_action`. If `bindings::devm_add_action` fails, we have to drop
+            // this reference accordingly.
+            let _ = unsafe { Arc::from_raw(data) };
+            return Err(Error::from_errno(ret));
+        }
+
+        Ok(inner)
+    }
+
+    #[allow(clippy::missing_safety_doc)]
+    unsafe extern "C" fn devres_callback(ptr: *mut kernel::ffi::c_void) {
+        let ptr = ptr as *mut DevresInner<T>;
+        // Devres owned this memory; now that we received the callback, drop the `Arc` and hence the
+        // reference.
+        // SAFETY: Safe, since we leaked an `Arc` reference to devm_add_action() in
+        //         `DevresInner::new`.
+        let inner = unsafe { Arc::from_raw(ptr) };
+
+        inner.data.revoke();
+    }
+}
+
+impl<T> Devres<T> {
+    /// Creates a new [`Devres`] instance of the given `data`. The `data` encapsulated within the
+    /// returned `Devres` instance' `data` will be revoked once the device is detached.
+    pub fn new(dev: &Device, data: T, flags: Flags) -> Result<Self> {
+        let inner = DevresInner::new(dev, data, flags)?;
+
+        Ok(Devres(inner))
+    }
+
+    /// Same as [`Devres::new`], but does not return a `Devres` instance. Instead the given `data`
+    /// is owned by devres and will be revoked / dropped, once the device is detached.
+    pub fn new_foreign_owned(dev: &Device, data: T, flags: Flags) -> Result {
+        let _ = DevresInner::new(dev, data, flags)?;
+
+        Ok(())
+    }
+}
+
+impl<T> Deref for Devres<T> {
+    type Target = Revocable<T>;
+
+    fn deref(&self) -> &Self::Target {
+        &self.0.data
+    }
+}
+
+impl<T> Drop for Devres<T> {
+    fn drop(&mut self) {
+        // Revoke the data, such that it gets dropped already and the actual resource is freed.
+        //
+        // `DevresInner` has to stay alive until the devres callback has been called. This is
+        // necessary since we don't know when `Devres` is dropped and calling
+        // `devm_remove_action()` instead could race with `devres_release_all()`.
+        //
+        // SAFETY: When `drop` runs, it's guaranteed that nobody is accessing the revocable data
+        // anymore, hence it is safe not to wait for the grace period to finish.
+        unsafe { self.revoke_nosync() };
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 6c836ab73771..2b61bf99d1ee 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -41,6 +41,7 @@
 pub mod cred;
 pub mod device;
 pub mod device_id;
+pub mod devres;
 pub mod driver;
 pub mod error;
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
-- 
2.47.1


