Return-Path: <linux-pci+bounces-15062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E529AB8A6
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 23:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58880B2232A
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 21:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EB81CEE93;
	Tue, 22 Oct 2024 21:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifJpBmMC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1CC1CCECA;
	Tue, 22 Oct 2024 21:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632836; cv=none; b=X3Pj2fvi658B9JrlaEa0MNymQkWZXekAVdxif7nnKLlwFKbbRrAPdcjdNnfXTFE7xjrmIw0FaG23YUFG+0uw3DjLyuW8mlds75HgxvgJ3vhOrYWnEZwxpAzsraXMX1LCdgPdsXMsdKCSHHIZ8hqZ9UNfRy+mIvcRMeG48BnYGBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632836; c=relaxed/simple;
	bh=I99bItPUGGImSDmgGsci4gBQnJK7yi7CqarWLCTyKN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEuVSdsVCHcW7y4gxwtfPXX/XqTo97WtVeGsR6+KmoDXfvFXXmqRh4B7UrFTgBcwDGted8pU5WF82oLGeGdNVpApl27qVeZPytFaWGK1Ha1oWVP1db8Q9RSGGiRI9qvVn4Rq+MAx3/jBJRgk1xUL8LuvM1qIseGLC6LIFvxuKD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifJpBmMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61774C4CEE6;
	Tue, 22 Oct 2024 21:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729632835;
	bh=I99bItPUGGImSDmgGsci4gBQnJK7yi7CqarWLCTyKN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ifJpBmMC34RJoPDWNMaaGZVmYJaezRiEsY/Ed8u7gjsJRtstuREBufmQRI4LMzxm0
	 1Eo72sH3Fo53t6qgBbqvAbpJrDh0Ifa7c6CqKo0vCiHiqVfKp5aYSEToEOImPZu/G/
	 0DOW+L0L3Ox3uXYANdAPZwHBOwtwlU4ODSQH8fQEXHNXsoNBIJca5MjnJQPBdYIZMT
	 RpvJ3jYLRNnHMrKgja1ip257Ws0g/lnGF/b42uzpyV6MNB8Y3mEtfQMivfwSExBxeW
	 +zk1N6pFFfwVkFe/H50CtUN5+jj/Iz5TXs05YDZz+9jdmWjrvk9RDRLyR4Nuo03dGw
	 zQomzAGFpnXSw==
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
Subject: [PATCH v3 15/16] rust: platform: add basic platform device / driver abstractions
Date: Tue, 22 Oct 2024 23:31:52 +0200
Message-ID: <20241022213221.2383-16-dakr@kernel.org>
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

Implement the basic platform bus abstractions required to write a basic
platform driver. This includes the following data structures:

The `platform::Driver` trait represents the interface to the driver and
provides `pci::Driver::probe` for the driver to implement.

The `platform::Device` abstraction represents a `struct platform_device`.

In order to provide the platform bus specific parts to a generic
`driver::Registration` the `driver::RegistrationOps` trait is implemented
by `platform::Adapter`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 MAINTAINERS                     |   1 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/platform.c         |  13 ++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/platform.rs         | 217 ++++++++++++++++++++++++++++++++
 6 files changed, 234 insertions(+)
 create mode 100644 rust/helpers/platform.c
 create mode 100644 rust/kernel/platform.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 87eb9a7869eb..173540375863 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6985,6 +6985,7 @@ F:	rust/kernel/device.rs
 F:	rust/kernel/device_id.rs
 F:	rust/kernel/devres.rs
 F:	rust/kernel/driver.rs
+F:	rust/kernel/platform.rs
 
 DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
 M:	Nishanth Menon <nm@ti.com>
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 312f03cbdce9..217c776615b9 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -18,6 +18,7 @@
 #include <linux/of_device.h>
 #include <linux/pci.h>
 #include <linux/phy.h>
+#include <linux/platform_device.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 8bc6e9735589..663cdc2a45e0 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -17,6 +17,7 @@
 #include "kunit.c"
 #include "mutex.c"
 #include "page.c"
+#include "platform.c"
 #include "pci.c"
 #include "rbtree.c"
 #include "rcu.c"
diff --git a/rust/helpers/platform.c b/rust/helpers/platform.c
new file mode 100644
index 000000000000..ab9b9f317301
--- /dev/null
+++ b/rust/helpers/platform.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/platform_device.h>
+
+void *rust_helper_platform_get_drvdata(const struct platform_device *pdev)
+{
+	return platform_get_drvdata(pdev);
+}
+
+void rust_helper_platform_set_drvdata(struct platform_device *pdev, void *data)
+{
+	platform_set_drvdata(pdev, data);
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 5946f59f1688..9e8dcd6d7c01 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -53,6 +53,7 @@
 pub mod net;
 pub mod of;
 pub mod page;
+pub mod platform;
 pub mod prelude;
 pub mod print;
 pub mod rbtree;
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
new file mode 100644
index 000000000000..addf5356f44f
--- /dev/null
+++ b/rust/kernel/platform.rs
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Abstractions for the platform bus.
+//!
+//! C header: [`include/linux/platform_device.h`](srctree/include/linux/platform_device.h)
+
+use crate::{
+    bindings, container_of, device,
+    device_id::RawDeviceId,
+    driver,
+    error::{to_result, Result},
+    of,
+    prelude::*,
+    str::CStr,
+    types::{ARef, ForeignOwnable},
+    ThisModule,
+};
+
+/// An adapter for the registration of platform drivers.
+pub struct Adapter<T: Driver>(T);
+
+impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
+    type RegType = bindings::platform_driver;
+
+    fn register(
+        pdrv: &mut Self::RegType,
+        name: &'static CStr,
+        module: &'static ThisModule,
+    ) -> Result {
+        pdrv.driver.name = name.as_char_ptr();
+        pdrv.probe = Some(Self::probe_callback);
+
+        // Both members of this union are identical in data layout and semantics.
+        pdrv.__bindgen_anon_1.remove = Some(Self::remove_callback);
+        pdrv.driver.of_match_table = T::ID_TABLE.as_ptr();
+
+        // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
+        to_result(unsafe { bindings::__platform_driver_register(pdrv, module.0) })
+    }
+
+    fn unregister(pdrv: &mut Self::RegType) {
+        // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
+        unsafe { bindings::platform_driver_unregister(pdrv) };
+    }
+}
+
+impl<T: Driver + 'static> Adapter<T> {
+    fn id_info(pdev: &Device) -> Option<&'static T::IdInfo> {
+        let table = T::ID_TABLE;
+        let id = T::of_match_device(pdev)?;
+
+        Some(table.info(id.index()))
+    }
+
+    extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> core::ffi::c_int {
+        // SAFETY: The platform bus only ever calls the probe callback with a valid `pdev`.
+        let dev = unsafe { device::Device::from_raw(&mut (*pdev).dev) };
+        // SAFETY: `dev` is guaranteed to be embedded in a valid `struct platform_device` by the
+        // call above.
+        let mut pdev = unsafe { Device::from_dev(dev) };
+
+        let info = Self::id_info(&pdev);
+        match T::probe(&mut pdev, info) {
+            Ok(data) => {
+                // Let the `struct platform_device` own a reference of the driver's private data.
+                // SAFETY: By the type invariant `pdev.as_raw` returns a valid pointer to a
+                // `struct platform_device`.
+                unsafe { bindings::platform_set_drvdata(pdev.as_raw(), data.into_foreign() as _) };
+            }
+            Err(err) => return Error::to_errno(err),
+        }
+
+        0
+    }
+
+    extern "C" fn remove_callback(pdev: *mut bindings::platform_device) {
+        // SAFETY: `pdev` is a valid pointer to a `struct platform_device`.
+        let ptr = unsafe { bindings::platform_get_drvdata(pdev) };
+
+        // SAFETY: `remove_callback` is only ever called after a successful call to
+        // `probe_callback`, hence it's guaranteed that `ptr` points to a valid and initialized
+        // `KBox<T>` pointer created through `KBox::into_foreign`.
+        let _ = unsafe { KBox::<T>::from_foreign(ptr) };
+    }
+}
+
+/// Declares a kernel module that exposes a single platform driver.
+///
+/// # Examples
+///
+/// ```ignore
+/// kernel::module_platform_driver! {
+///     type: MyDriver,
+///     name: "Module name",
+///     author: "Author name",
+///     description: "Description",
+///     license: "GPL v2",
+/// }
+/// ```
+#[macro_export]
+macro_rules! module_platform_driver {
+    ($($f:tt)*) => {
+        $crate::module_driver!(<T>, $crate::platform::Adapter<T>, { $($f)* });
+    };
+}
+
+/// IdTable type for platform drivers.
+pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<of::DeviceId, T>;
+
+/// The platform driver trait.
+///
+/// # Example
+///
+///```
+/// # use kernel::{bindings, c_str, of, platform};
+///
+/// struct MyDriver;
+///
+/// kernel::of_device_table!(
+///     OF_TABLE,
+///     MODULE_OF_TABLE,
+///     <MyDriver as platform::Driver>::IdInfo,
+///     [
+///         (of::DeviceId::new(c_str!("redhat,my-device")), ())
+///     ]
+/// );
+///
+/// impl platform::Driver for MyDriver {
+///     type IdInfo = ();
+///     const ID_TABLE: platform::IdTable<Self::IdInfo> = &OF_TABLE;
+///
+///     fn probe(
+///         _pdev: &mut platform::Device,
+///         _id_info: Option<&Self::IdInfo>,
+///     ) -> Result<Pin<KBox<Self>>> {
+///         Err(ENODEV)
+///     }
+/// }
+///```
+/// Drivers must implement this trait in order to get a platform driver registered. Please refer to
+/// the `Adapter` documentation for an example.
+pub trait Driver {
+    /// The type holding information about each device id supported by the driver.
+    ///
+    /// TODO: Use associated_type_defaults once stabilized:
+    ///
+    /// type IdInfo: 'static = ();
+    type IdInfo: 'static;
+
+    /// The table of device ids supported by the driver.
+    const ID_TABLE: IdTable<Self::IdInfo>;
+
+    /// Platform driver probe.
+    ///
+    /// Called when a new platform device is added or discovered.
+    /// Implementers should attempt to initialize the device here.
+    fn probe(dev: &mut Device, id_info: Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>>;
+
+    /// Find the [`of::DeviceId`] within [`Driver::ID_TABLE`] matching the given [`Device`], if any.
+    fn of_match_device(pdev: &Device) -> Option<&of::DeviceId> {
+        let table = Self::ID_TABLE;
+
+        // SAFETY:
+        // - `table` has static lifetime, hence it's valid for read,
+        // - `dev` is guaranteed to be valid while it's alive, and so is
+        //   `pdev.as_dev().as_raw()`.
+        let raw_id = unsafe { bindings::of_match_device(table.as_ptr(), pdev.as_dev().as_raw()) };
+
+        if raw_id.is_null() {
+            None
+        } else {
+            // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of `struct of_device_id` and
+            // does not add additional invariants, so it's safe to transmute.
+            Some(unsafe { &*raw_id.cast::<of::DeviceId>() })
+        }
+    }
+}
+
+/// The platform device representation.
+///
+/// A platform device is based on an always reference counted `device:Device` instance. Cloning a
+/// platform device, hence, also increments the base device' reference count.
+///
+/// # Invariants
+///
+/// `Device` holds a valid reference of `ARef<device::Device>` whose underlying `struct device` is a
+/// member of a `struct platform_device`.
+#[derive(Clone)]
+pub struct Device(ARef<device::Device>);
+
+impl Device {
+    /// Convert a raw kernel device into a `Device`
+    ///
+    /// # Safety
+    ///
+    /// `dev` must be an `Aref<device::Device>` whose underlying `bindings::device` is a member of a
+    /// `bindings::platform_device`.
+    unsafe fn from_dev(dev: ARef<device::Device>) -> Self {
+        Self(dev)
+    }
+
+    fn as_dev(&self) -> &device::Device {
+        &self.0
+    }
+
+    fn as_raw(&self) -> *mut bindings::platform_device {
+        // SAFETY: By the type invariant `self.0.as_raw` is a pointer to the `struct device`
+        // embedded in `struct platform_device`.
+        unsafe { container_of!(self.0.as_raw(), bindings::platform_device, dev) }.cast_mut()
+    }
+}
+
+impl AsRef<device::Device> for Device {
+    fn as_ref(&self) -> &device::Device {
+        &self.0
+    }
+}
-- 
2.46.2


