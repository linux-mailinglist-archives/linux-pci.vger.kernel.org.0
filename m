Return-Path: <linux-pci+bounces-15057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3529AB897
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 23:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85DEEB23506
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 21:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349491D04A3;
	Tue, 22 Oct 2024 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouhLQVcL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067261CEAA7;
	Tue, 22 Oct 2024 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632808; cv=none; b=IQb3ysiYnBuv4t4/8dpTjjg4Lb3lTg6S2g+2DnadbPLvLYrmdzGoYp0swbe9FGjvtk/VuhAN80dWpuDMaLDmxEuCUonH6iNK5QovBbzhVaMZlIB2PkfFvB3Bi0jpboso32P6UjZFAM4o9Bw0pcWf0F/4hrjSgbYh2zfxdC9EkKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632808; c=relaxed/simple;
	bh=6D9H3UuKuTE0IPg8G7njtpvFnsNHPt874oP5qIsVUV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGYSPntXweHj1H8X2dD3YhyyhYV7towTyPszboKxa37fExvaLnUt6NZFTYow7U+W8JGtll8aFDFXdn32JLaOrQWwOiqhTSXhjQzhQcp0gmjN6mCpYSBq1Z7ceZiNlX4EPGQOa4TkNPBoFNEiNr8/0bmqILIg3JlsKeCqSzuoqXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouhLQVcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26C7C4CEE3;
	Tue, 22 Oct 2024 21:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729632807;
	bh=6D9H3UuKuTE0IPg8G7njtpvFnsNHPt874oP5qIsVUV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ouhLQVcLbi3+OzRtIXgZ9jQNj5YwA2iqdRfT2SplCFyW3IJ5pjKSIQtwE+VvUgROg
	 GjeT3F+YzyI4JYcIyvTBpgMlu+mIzJxv5XYcSQqQCSWAzxNNPWr3A40bmLdK8khM+Y
	 5kd4xN+DYqtabtAs6UnUZxXJcDatcm0ujBGLGRWD3xm/ClhT/+9qpxk5KBW/hwhGdh
	 P2ecU8RuySsRVgs1BUrICEo8lbwfkPz7LOpEZCG6qOsOorST7xrKPddnJTsbLvI4q9
	 WelGQRtH+BPK7zHgOqnMCjWi+2xUx83WOjH/6IDITs0tw2eImUojHFYXm+LcW4yD0F
	 zzY693TFYDedQ==
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
	saravanak@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 10/16] rust: add devres abstraction
Date: Tue, 22 Oct 2024 23:31:47 +0200
Message-ID: <20241022213221.2383-11-dakr@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241022213221.2383-1-dakr@kernel.org>
References: <20241022213221.2383-1-dakr@kernel.org>
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
 rust/kernel/devres.rs  | 180 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |   1 +
 5 files changed, 193 insertions(+)
 create mode 100644 rust/helpers/device.c
 create mode 100644 rust/kernel/devres.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a8882252257..97914d0752fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6983,6 +6983,7 @@ F:	include/linux/property.h
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
index e2f6b2197061..3acb2b9e52ec 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -11,6 +11,7 @@
 #include "bug.c"
 #include "build_assert.c"
 #include "build_bug.c"
+#include "device.c"
 #include "err.c"
 #include "io.c"
 #include "kunit.c"
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
new file mode 100644
index 000000000000..b23559f55214
--- /dev/null
+++ b/rust/kernel/devres.rs
@@ -0,0 +1,180 @@
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
+use core::ffi::c_void;
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
+/// # use kernel::{bindings, c_str, device::Device, devres::Devres, io::Io};
+/// # use core::ops::Deref;
+///
+/// // See also [`pci::Bar`] for a real example.
+/// struct IoMem<const SIZE: usize>(Io<SIZE>);
+///
+/// impl<const SIZE: usize> IoMem<SIZE> {
+///     /// # Safety
+///     ///
+///     /// [`paddr`, `paddr` + `SIZE`) must be a valid MMIO region that is mappable into the CPUs
+///     /// virtual address space.
+///     unsafe fn new(paddr: usize) -> Result<Self>{
+///
+///         // SAFETY: By the safety requirements of this function [`paddr`, `paddr` + `SIZE`) is
+///         // valid for `ioremap`.
+///         let addr = unsafe { bindings::ioremap(paddr as _, SIZE.try_into().unwrap()) };
+///         if addr.is_null() {
+///             return Err(ENOMEM);
+///         }
+///
+///         // SAFETY: `addr` is guaranteed to be the start of a valid I/O mapped memory region of
+///         // size `SIZE`.
+///         let io = unsafe { Io::new(addr as _, SIZE)? };
+///
+///         Ok(IoMem(io))
+///     }
+/// }
+///
+/// impl<const SIZE: usize> Drop for IoMem<SIZE> {
+///     fn drop(&mut self) {
+///         // SAFETY: Safe as by the invariant of `Io`.
+///         unsafe { bindings::iounmap(self.0.base_addr() as _); };
+///     }
+/// }
+///
+/// impl<const SIZE: usize> Deref for IoMem<SIZE> {
+///    type Target = Io<SIZE>;
+///
+///    fn deref(&self) -> &Self::Target {
+///        &self.0
+///    }
+/// }
+///
+/// # fn no_run() -> Result<(), Error> {
+/// # // SAFETY: Invalid usage; just for the example to get an `ARef<Device>` instance.
+/// # let dev = unsafe { Device::from_raw(core::ptr::null_mut()) };
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
+    unsafe extern "C" fn devres_callback(ptr: *mut c_void) {
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
+        // `DevresInner` has to stay alive until the devres callback has been called. This is
+        // necessary since we don't know when `Devres` is dropped and calling
+        // `devm_remove_action()` instead could race with `devres_release_all()`.
+        self.revoke();
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index fa3b7514e6ae..5cb892419453 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -39,6 +39,7 @@
 mod build_assert;
 pub mod device;
 pub mod device_id;
+pub mod devres;
 pub mod driver;
 pub mod error;
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
-- 
2.46.2


