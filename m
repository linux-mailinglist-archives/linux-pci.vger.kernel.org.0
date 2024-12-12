Return-Path: <linux-pci+bounces-18311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8999B9EF204
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 17:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C7D828A17B
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 16:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF34E23A1A6;
	Thu, 12 Dec 2024 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgXyc0fG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E20522FDF9;
	Thu, 12 Dec 2024 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021358; cv=none; b=YSqrDwYsgDerXF/oeMk42UuY/eeJXCuaq30t+Y7rXse4Y0CckAw5Wx4Q7ONnuJ/NZYSmSfwdeK1dLd2qd77ORiYzAtUr1t7IgbIryATP+Du85zuEWx7z8y5P8+8mQFJZruxthDZ0DniT8mFMEtq73K5QVKBYOq/O+SRah2qpn8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021358; c=relaxed/simple;
	bh=FS6k/3P7hb+Q3aqjgFgDh5Zn9GFljRypnVrJKzAAgd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfR7OJ4GPOYaGwoRp9WXXIVoqh4PVn1unXU92If5ni5H2jszY9qXHvbIQlRAZ2fhPPHWP0Kv2GPu7WGQFRCMy1LIHJBDozZtowAqDANnIAyjR+4pTu1gsg2JlZ3s57vtRo5GL2COjjGKfY3BM6DLrtmT0T9hfYry1nRdlSVNqgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgXyc0fG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7755DC4CED4;
	Thu, 12 Dec 2024 16:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734021358;
	bh=FS6k/3P7hb+Q3aqjgFgDh5Zn9GFljRypnVrJKzAAgd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FgXyc0fGOh9uhQmzSYW/kjFgb5nvafPE3smw9Ncdtkju3qjcM5jh9qAMtFKHveB17
	 F1IsBW5xAYeQ8jBfGiQojuJESJr6dVCV2Hg27dcxtT+FbwmXSWaewfCzCiBcGRpr/3
	 fdYOBOyQU9PQrFVKGf9pw1UGNPrl66CAIeekgp36KvWzHBwZi8tFz1RTmW3UB9glEx
	 795BB4oY99rYfLbjKZBO9bS82tIY+5/Kkarw1Sb/Vk08k2zz2J9UJhXdEPifdKFC+L
	 6mEvivK+TqZ0KnM6wdX9BY89AXOLc72b7jnE6rXwx5JFp8phrGbRYVuWHXtTKcoTHu
	 tFQWD0yScdqew==
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
Subject: [PATCH v6 09/16] rust: pci: add basic PCI device / driver abstractions
Date: Thu, 12 Dec 2024 17:33:40 +0100
Message-ID: <20241212163357.35934-10-dakr@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212163357.35934-1-dakr@kernel.org>
References: <20241212163357.35934-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement the basic PCI abstractions required to write a basic PCI
driver. This includes the following data structures:

The `pci::Driver` trait represents the interface to the driver and
provides `pci::Driver::probe` for the driver to implement.

The `pci::Device` abstraction represents a `struct pci_dev` and provides
abstractions for common functions, such as `pci::Device::set_master`.

In order to provide the PCI specific parts to a generic
`driver::Registration` the `driver::RegistrationOps` trait is implemented
by `pci::Adapter`.

`pci::DeviceId` implements PCI device IDs based on the generic
`device_id::RawDevceId` abstraction.

Co-developed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 MAINTAINERS                     |   1 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/pci.c              |  18 ++
 rust/kernel/lib.rs              |   2 +
 rust/kernel/pci.rs              | 298 ++++++++++++++++++++++++++++++++
 6 files changed, 321 insertions(+)
 create mode 100644 rust/helpers/pci.c
 create mode 100644 rust/kernel/pci.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 096a7d9ee966..e143969265aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18102,6 +18102,7 @@ F:	include/asm-generic/pci*
 F:	include/linux/of_pci.h
 F:	include/linux/pci*
 F:	include/uapi/linux/pci*
+F:	rust/kernel/pci.rs
 
 PCIE BANDWIDTH CONTROLLER
 M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 5c4dfe22f41a..6d7a68e2ecb7 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -20,6 +20,7 @@
 #include <linux/jump_label.h>
 #include <linux/mdio.h>
 #include <linux/miscdevice.h>
+#include <linux/pci.h>
 #include <linux/phy.h>
 #include <linux/pid_namespace.h>
 #include <linux/poll.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index a3b52aa021de..3fda33cd42d4 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -20,6 +20,7 @@
 #include "kunit.c"
 #include "mutex.c"
 #include "page.c"
+#include "pci.c"
 #include "pid_namespace.c"
 #include "rbtree.c"
 #include "rcu.c"
diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
new file mode 100644
index 000000000000..8ba22f911459
--- /dev/null
+++ b/rust/helpers/pci.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/pci.h>
+
+void rust_helper_pci_set_drvdata(struct pci_dev *pdev, void *data)
+{
+	pci_set_drvdata(pdev, data);
+}
+
+void *rust_helper_pci_get_drvdata(struct pci_dev *pdev)
+{
+	return pci_get_drvdata(pdev);
+}
+
+resource_size_t rust_helper_pci_resource_len(struct pci_dev *pdev, int bar)
+{
+	return pci_resource_len(pdev, bar);
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 2b61bf99d1ee..1dc7eda6b480 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -82,6 +82,8 @@
 pub use bindings;
 pub mod io;
 pub use macros;
+#[cfg(all(CONFIG_PCI, CONFIG_PCI_MSI))]
+pub mod pci;
 pub use uapi;
 
 #[doc(hidden)]
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
new file mode 100644
index 000000000000..238eed06f388
--- /dev/null
+++ b/rust/kernel/pci.rs
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Abstractions for the PCI bus.
+//!
+//! C header: [`include/linux/pci.h`](srctree/include/linux/pci.h)
+
+use crate::{
+    bindings, container_of, device,
+    device_id::RawDeviceId,
+    driver,
+    error::{to_result, Result},
+    str::CStr,
+    types::{ARef, ForeignOwnable, Opaque},
+    ThisModule,
+};
+use core::{ops::Deref, ptr::addr_of_mut};
+use kernel::prelude::*;
+
+/// An adapter for the registration of PCI drivers.
+pub struct Adapter<T: Driver>(T);
+
+impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
+    type RegType = bindings::pci_driver;
+
+    fn register(
+        pdrv: &Opaque<Self::RegType>,
+        name: &'static CStr,
+        module: &'static ThisModule,
+    ) -> Result {
+        // SAFETY: It's safe to set the fields of `struct pci_driver` on initialization.
+        unsafe {
+            (*pdrv.get()).name = name.as_char_ptr();
+            (*pdrv.get()).probe = Some(Self::probe_callback);
+            (*pdrv.get()).remove = Some(Self::remove_callback);
+            (*pdrv.get()).id_table = T::ID_TABLE.as_ptr();
+        }
+
+        // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
+        to_result(unsafe {
+            bindings::__pci_register_driver(pdrv.get(), module.0, name.as_char_ptr())
+        })
+    }
+
+    fn unregister(pdrv: &Opaque<Self::RegType>) {
+        // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
+        unsafe { bindings::pci_unregister_driver(pdrv.get()) }
+    }
+}
+
+impl<T: Driver + 'static> Adapter<T> {
+    extern "C" fn probe_callback(
+        pdev: *mut bindings::pci_dev,
+        id: *const bindings::pci_device_id,
+    ) -> core::ffi::c_int {
+        // SAFETY: The PCI bus only ever calls the probe callback with a valid pointer to a
+        // `struct pci_dev`.
+        let dev = unsafe { device::Device::get_device(addr_of_mut!((*pdev).dev)) };
+        // SAFETY: `dev` is guaranteed to be embedded in a valid `struct pci_dev` by the call
+        // above.
+        let mut pdev = unsafe { Device::from_dev(dev) };
+
+        // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of `struct pci_device_id` and
+        // does not add additional invariants, so it's safe to transmute.
+        let id = unsafe { &*id.cast::<DeviceId>() };
+        let info = T::ID_TABLE.info(id.index());
+
+        match T::probe(&mut pdev, info) {
+            Ok(data) => {
+                // Let the `struct pci_dev` own a reference of the driver's private data.
+                // SAFETY: By the type invariant `pdev.as_raw` returns a valid pointer to a
+                // `struct pci_dev`.
+                unsafe { bindings::pci_set_drvdata(pdev.as_raw(), data.into_foreign() as _) };
+            }
+            Err(err) => return Error::to_errno(err),
+        }
+
+        0
+    }
+
+    extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
+        // SAFETY: The PCI bus only ever calls the remove callback with a valid pointer to a
+        // `struct pci_dev`.
+        let ptr = unsafe { bindings::pci_get_drvdata(pdev) };
+
+        // SAFETY: `remove_callback` is only ever called after a successful call to
+        // `probe_callback`, hence it's guaranteed that `ptr` points to a valid and initialized
+        // `KBox<T>` pointer created through `KBox::into_foreign`.
+        let _ = unsafe { KBox::<T>::from_foreign(ptr) };
+    }
+}
+
+/// Declares a kernel module that exposes a single PCI driver.
+///
+/// # Example
+///
+///```ignore
+/// kernel::module_pci_driver! {
+///     type: MyDriver,
+///     name: "Module name",
+///     author: "Author name",
+///     description: "Description",
+///     license: "GPL v2",
+/// }
+///```
+#[macro_export]
+macro_rules! module_pci_driver {
+($($f:tt)*) => {
+    $crate::module_driver!(<T>, $crate::pci::Adapter<T>, { $($f)* });
+};
+}
+
+/// Abstraction for bindings::pci_device_id.
+#[repr(transparent)]
+#[derive(Clone, Copy)]
+pub struct DeviceId(bindings::pci_device_id);
+
+impl DeviceId {
+    const PCI_ANY_ID: u32 = !0;
+
+    /// PCI_DEVICE macro.
+    pub const fn new(vendor: u32, device: u32) -> Self {
+        Self(bindings::pci_device_id {
+            vendor,
+            device,
+            subvendor: DeviceId::PCI_ANY_ID,
+            subdevice: DeviceId::PCI_ANY_ID,
+            class: 0,
+            class_mask: 0,
+            driver_data: 0,
+            override_only: 0,
+        })
+    }
+
+    /// PCI_DEVICE_CLASS macro.
+    pub const fn with_class(class: u32, class_mask: u32) -> Self {
+        Self(bindings::pci_device_id {
+            vendor: DeviceId::PCI_ANY_ID,
+            device: DeviceId::PCI_ANY_ID,
+            subvendor: DeviceId::PCI_ANY_ID,
+            subdevice: DeviceId::PCI_ANY_ID,
+            class,
+            class_mask,
+            driver_data: 0,
+            override_only: 0,
+        })
+    }
+}
+
+// Allow drivers R/O access to the fields of `pci_device_id`; should we prefer accessor functions
+// to void exposing C structure fields?
+impl Deref for DeviceId {
+    type Target = bindings::pci_device_id;
+
+    fn deref(&self) -> &Self::Target {
+        &self.0
+    }
+}
+
+// SAFETY:
+// * `DeviceId` is a `#[repr(transparent)` wrapper of `pci_device_id` and does not add
+//   additional invariants, so it's safe to transmute to `RawType`.
+// * `DRIVER_DATA_OFFSET` is the offset to the `driver_data` field.
+unsafe impl RawDeviceId for DeviceId {
+    type RawType = bindings::pci_device_id;
+
+    const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::pci_device_id, driver_data);
+
+    fn index(&self) -> usize {
+        self.driver_data as _
+    }
+}
+
+/// IdTable type for PCI
+pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<DeviceId, T>;
+
+/// Create a PCI `IdTable` with its alias for modpost.
+#[macro_export]
+macro_rules! pci_device_table {
+    ($table_name:ident, $module_table_name:ident, $id_info_type: ty, $table_data: expr) => {
+        const $table_name: $crate::device_id::IdArray<
+            $crate::pci::DeviceId,
+            $id_info_type,
+            { $table_data.len() },
+        > = $crate::device_id::IdArray::new($table_data);
+
+        $crate::module_device_table!("pci", $module_table_name, $table_name);
+    };
+}
+
+/// The PCI driver trait.
+///
+/// # Example
+///
+///```
+/// # use kernel::{bindings, pci};
+///
+/// struct MyDriver;
+///
+/// kernel::pci_device_table!(
+///     PCI_TABLE,
+///     MODULE_PCI_TABLE,
+///     <MyDriver as pci::Driver>::IdInfo,
+///     [
+///         (pci::DeviceId::new(bindings::PCI_VENDOR_ID_REDHAT, bindings::PCI_ANY_ID as u32), ())
+///     ]
+/// );
+///
+/// impl pci::Driver for MyDriver {
+///     type IdInfo = ();
+///     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
+///
+///     fn probe(
+///         _pdev: &mut pci::Device,
+///         _id_info: &Self::IdInfo,
+///     ) -> Result<Pin<KBox<Self>>> {
+///         Err(ENODEV)
+///     }
+/// }
+///```
+/// Drivers must implement this trait in order to get a PCI driver registered. Please refer to the
+/// `Adapter` documentation for an example.
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
+    /// PCI driver probe.
+    ///
+    /// Called when a new platform device is added or discovered.
+    /// Implementers should attempt to initialize the device here.
+    fn probe(dev: &mut Device, id_info: &Self::IdInfo) -> Result<Pin<KBox<Self>>>;
+}
+
+/// The PCI device representation.
+///
+/// A PCI device is based on an always reference counted `device:Device` instance. Cloning a PCI
+/// device, hence, also increments the base device' reference count.
+#[derive(Clone)]
+pub struct Device(ARef<device::Device>);
+
+impl Device {
+    /// Create a PCI Device instance from an existing `device::Device`.
+    ///
+    /// # Safety
+    ///
+    /// `dev` must be an `ARef<device::Device>` whose underlying `bindings::device` is a member of
+    /// a `bindings::pci_dev`.
+    pub unsafe fn from_dev(dev: ARef<device::Device>) -> Self {
+        Self(dev)
+    }
+
+    fn as_raw(&self) -> *mut bindings::pci_dev {
+        // SAFETY: By the type invariant `self.0.as_raw` is a pointer to the `struct device`
+        // embedded in `struct pci_dev`.
+        unsafe { container_of!(self.0.as_raw(), bindings::pci_dev, dev) as _ }
+    }
+
+    /// Returns the PCI vendor ID.
+    pub fn vendor_id(&self) -> u16 {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        unsafe { (*self.as_raw()).vendor }
+    }
+
+    /// Returns the PCI device ID.
+    pub fn device_id(&self) -> u16 {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        unsafe { (*self.as_raw()).device }
+    }
+
+    /// Enable memory resources for this device.
+    pub fn enable_device_mem(&self) -> Result {
+        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
+        let ret = unsafe { bindings::pci_enable_device_mem(self.as_raw()) };
+        if ret != 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(())
+        }
+    }
+
+    /// Enable bus-mastering for this device.
+    pub fn set_master(&self) {
+        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
+        unsafe { bindings::pci_set_master(self.as_raw()) };
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


