Return-Path: <linux-pci+bounces-18803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2E69F8148
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 18:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50DC5162569
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 17:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B638E1BEF96;
	Thu, 19 Dec 2024 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyNAqLCa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835C71BEF76;
	Thu, 19 Dec 2024 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627969; cv=none; b=KlAogwPd8ZM/KIUMrqviNxVuWdQbl1cvzo9LYlBxQafLgDkcV0BpCEvyPUAY3fZUQIbkVohJ8agZZjTaP31TOJLYV7UdyGWQ6OnWWYFWrAP93ykx9T8ZsoKAFhjQix6QE3KPT50R3hnaqGDhg8DH3101Drp49s/iDlKDGQKX3Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627969; c=relaxed/simple;
	bh=Ph642GNX9rb38cU+ymFLPjeiZYFrpSrFmtV0/Sedv/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Heq41YpWu4nBTzVaexW9BrRSGIztceMxQmRHM7KIl82Wtu+LMxUFzKA8jzTSZUtSWPgWSQSVaOAeUeWN08L1tqBflE4lBWYWSXQf5GUQDu2IRX+qGlr6KFgJCTSk1Ccjxy2MT5vyXm5OVJnDwelNLtoNZrGb/PS6Wft0Le4C3Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyNAqLCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CE3C4CED7;
	Thu, 19 Dec 2024 17:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734627969;
	bh=Ph642GNX9rb38cU+ymFLPjeiZYFrpSrFmtV0/Sedv/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cyNAqLCaWKAOcZRbvQQk1uaQaYfjCu+A4QFChq4PAuHQOR1q5CMlckxUthTwK2ROy
	 GsZF88arI+D4JGNkRXAZiJ3deduWR1yunlkOauCVwTHrYHaDR9pBS2NM9fa7xciV8v
	 diilR7RQgMNNVQzLoqrTx1tg917GFVlakmOaPJSy1/8i+OpTZeGjuFDLd5wOQXkeVZ
	 2Ru5o8qw9r8NZW1IBXbSU5FXUQejFxjxKMYRMUN5F56ibdEe8s4vj1mN/wfkwXraGs
	 SbiMaH/uYsh7AQ21Plw2zz2kDe2Cq4PIdzNibnCAv0p92nIX/tVoMNPjEPQ+aikOh7
	 8AtvGjQFgkSDg==
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
Subject: [PATCH v7 14/16] rust: platform: add basic platform device / driver abstractions
Date: Thu, 19 Dec 2024 18:04:16 +0100
Message-ID: <20241219170425.12036-15-dakr@kernel.org>
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

Implement the basic platform bus abstractions required to write a basic
platform driver. This includes the following data structures:

The `platform::Driver` trait represents the interface to the driver and
provides `platform::Driver::probe` for the driver to implement.

The `platform::Device` abstraction represents a `struct platform_device`.

In order to provide the platform bus specific parts to a generic
`driver::Registration` the `driver::RegistrationOps` trait is implemented
by `platform::Adapter`.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 MAINTAINERS                     |   1 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/platform.c         |  13 +++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/platform.rs         | 198 ++++++++++++++++++++++++++++++++
 6 files changed, 215 insertions(+)
 create mode 100644 rust/helpers/platform.c
 create mode 100644 rust/kernel/platform.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 472cb259483e..798387acaefc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7036,6 +7036,7 @@ F:	rust/kernel/device.rs
 F:	rust/kernel/device_id.rs
 F:	rust/kernel/devres.rs
 F:	rust/kernel/driver.rs
+F:	rust/kernel/platform.rs
 
 DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
 M:	Nishanth Menon <nm@ti.com>
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 8fe70183a392..e9fdceb568b8 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -24,6 +24,7 @@
 #include <linux/pci.h>
 #include <linux/phy.h>
 #include <linux/pid_namespace.h>
+#include <linux/platform_device.h>
 #include <linux/poll.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 3fda33cd42d4..0640b7e115be 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -20,6 +20,7 @@
 #include "kunit.c"
 #include "mutex.c"
 #include "page.c"
+#include "platform.c"
 #include "pci.c"
 #include "pid_namespace.c"
 #include "rbtree.c"
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
index 27f914b0769b..e59250dc6c6e 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -59,6 +59,7 @@
 pub mod of;
 pub mod page;
 pub mod pid_namespace;
+pub mod platform;
 pub mod prelude;
 pub mod print;
 pub mod rbtree;
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
new file mode 100644
index 000000000000..03287794f9d0
--- /dev/null
+++ b/rust/kernel/platform.rs
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Abstractions for the platform bus.
+//!
+//! C header: [`include/linux/platform_device.h`](srctree/include/linux/platform_device.h)
+
+use crate::{
+    bindings, container_of, device, driver,
+    error::{to_result, Result},
+    of,
+    prelude::*,
+    str::CStr,
+    types::{ARef, ForeignOwnable, Opaque},
+    ThisModule,
+};
+
+use core::ptr::addr_of_mut;
+
+/// An adapter for the registration of platform drivers.
+pub struct Adapter<T: Driver>(T);
+
+impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
+    type RegType = bindings::platform_driver;
+
+    fn register(
+        pdrv: &Opaque<Self::RegType>,
+        name: &'static CStr,
+        module: &'static ThisModule,
+    ) -> Result {
+        let of_table = match T::OF_ID_TABLE {
+            Some(table) => table.as_ptr(),
+            None => core::ptr::null(),
+        };
+
+        // SAFETY: It's safe to set the fields of `struct platform_driver` on initialization.
+        unsafe {
+            (*pdrv.get()).driver.name = name.as_char_ptr();
+            (*pdrv.get()).probe = Some(Self::probe_callback);
+            (*pdrv.get()).remove = Some(Self::remove_callback);
+            (*pdrv.get()).driver.of_match_table = of_table;
+        }
+
+        // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
+        to_result(unsafe { bindings::__platform_driver_register(pdrv.get(), module.0) })
+    }
+
+    fn unregister(pdrv: &Opaque<Self::RegType>) {
+        // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
+        unsafe { bindings::platform_driver_unregister(pdrv.get()) };
+    }
+}
+
+impl<T: Driver + 'static> Adapter<T> {
+    extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ffi::c_int {
+        // SAFETY: The platform bus only ever calls the probe callback with a valid `pdev`.
+        let dev = unsafe { device::Device::get_device(addr_of_mut!((*pdev).dev)) };
+        // SAFETY: `dev` is guaranteed to be embedded in a valid `struct platform_device` by the
+        // call above.
+        let mut pdev = unsafe { Device::from_dev(dev) };
+
+        let info = <Self as driver::Adapter>::id_info(pdev.as_ref());
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
+impl<T: Driver + 'static> driver::Adapter for Adapter<T> {
+    type IdInfo = T::IdInfo;
+
+    fn of_id_table() -> Option<of::IdTable<Self::IdInfo>> {
+        T::OF_ID_TABLE
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
+/// The platform driver trait.
+///
+/// Drivers must implement this trait in order to get a platform driver registered.
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
+///         (of::DeviceId::new(c_str!("test,device")), ())
+///     ]
+/// );
+///
+/// impl platform::Driver for MyDriver {
+///     type IdInfo = ();
+///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+///
+///     fn probe(
+///         _pdev: &mut platform::Device,
+///         _id_info: Option<&Self::IdInfo>,
+///     ) -> Result<Pin<KBox<Self>>> {
+///         Err(ENODEV)
+///     }
+/// }
+///```
+pub trait Driver {
+    /// The type holding driver private data about each device id supported by the driver.
+    ///
+    /// TODO: Use associated_type_defaults once stabilized:
+    ///
+    /// type IdInfo: 'static = ();
+    type IdInfo: 'static;
+
+    /// The table of OF device ids supported by the driver.
+    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>>;
+
+    /// Platform driver probe.
+    ///
+    /// Called when a new platform device is added or discovered.
+    /// Implementers should attempt to initialize the device here.
+    fn probe(dev: &mut Device, id_info: Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>>;
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
2.47.1


