Return-Path: <linux-pci+bounces-15058-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACDF9AB899
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 23:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA741C2313A
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 21:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31CE1D0DD5;
	Tue, 22 Oct 2024 21:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVOouSNX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C6E1CEAA7;
	Tue, 22 Oct 2024 21:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632813; cv=none; b=KjQvzdzLWDhOjCbMRERswE2qOtTmtq/SSybcqZRzcLPNkQvUgTfKhqSOpaUlaOWlCtgRL/iISxwrtMnHqM12ylvRouTwBtt2m6+f1I0uPZeMG/otrFhh6bZf+p9yVAnuqQSYdtEMuPQb3RXqFXWZcAnVWtVF6xcQg3orIEO0oAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632813; c=relaxed/simple;
	bh=f1g2lGypUnMSWSiEHr5MqHApk0asEuig3kZAXhnIuWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdoAsdGfhVZ1zPWrIe5rRvv0n8WAJNjM/HNVqPv/t9YODvrYxcR1L8zNYRktfqr5c4VciJvL7SOAFg0fer9mIDQb4VRx4IeWG4Le2uQE9TvgY4TYDLcjPsmGf9W3uMuGXDNfZFlIHas3X8VdeEzdQsW2pskmhJaAqj4iRncCgi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVOouSNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7EDC4CEC7;
	Tue, 22 Oct 2024 21:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729632813;
	bh=f1g2lGypUnMSWSiEHr5MqHApk0asEuig3kZAXhnIuWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cVOouSNXzvADmoyI/wvdj2wDtmokqY5U9leZT76/y3i5e24o3NkpM03wnbiQHpoMx
	 KA576ZT7L1OQvom3SGBlgHojy1Ci0lpuTSL/pupWKPskmLOwOtQ7Nhah4YG0+T6kkE
	 zIzIPrXAquwkOHPrGwvg5/bA2SW4V61DBCYyjBrNjMtLORONQwwQrly50yKm73mUUt
	 DjlsRvJBeUBw7rb6RCQNdznmWE/OcUhd3LYlXFnFQpdg0S8SXrKnGdeY02ForiKcqW
	 1GfAugh3JZU84cp+nA/t8BghiU7VYYQd9fhJ5C08e7Pv+Cy9mL1nPBRBKGNO7Z50yL
	 c6vhOKvIvAjsw==
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
Subject: [PATCH v3 11/16] rust: pci: add basic PCI device / driver abstractions
Date: Tue, 22 Oct 2024 23:31:48 +0200
Message-ID: <20241022213221.2383-12-dakr@kernel.org>
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
 rust/kernel/pci.rs              | 284 ++++++++++++++++++++++++++++++++
 6 files changed, 307 insertions(+)
 create mode 100644 rust/helpers/pci.c
 create mode 100644 rust/kernel/pci.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 97914d0752fb..2d00d3845b4a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17939,6 +17939,7 @@ F:	include/asm-generic/pci*
 F:	include/linux/of_pci.h
 F:	include/linux/pci*
 F:	include/uapi/linux/pci*
+F:	rust/kernel/pci.rs
 
 PCIE DRIVER FOR AMAZON ANNAPURNA LABS
 M:	Jonathan Chocron <jonnyc@amazon.com>
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index a80783fcbe04..cd4edd6496ae 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -15,6 +15,7 @@
 #include <linux/firmware.h>
 #include <linux/jiffies.h>
 #include <linux/mdio.h>
+#include <linux/pci.h>
 #include <linux/phy.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 3acb2b9e52ec..8bc6e9735589 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -17,6 +17,7 @@
 #include "kunit.c"
 #include "mutex.c"
 #include "page.c"
+#include "pci.c"
 #include "rbtree.c"
 #include "rcu.c"
 #include "refcount.c"
diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
new file mode 100644
index 000000000000..7c4f3ba49486
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
+u64 rust_helper_pci_resource_len(struct pci_dev *pdev, int bar)
+{
+	return pci_resource_len(pdev, bar);
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 5cb892419453..3ec690eb6d43 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -73,6 +73,8 @@
 pub use bindings;
 pub mod io;
 pub use macros;
+#[cfg(all(CONFIG_PCI, CONFIG_PCI_MSI))]
+pub mod pci;
 pub use uapi;
 
 #[doc(hidden)]
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
new file mode 100644
index 000000000000..ccc9a5f322e4
--- /dev/null
+++ b/rust/kernel/pci.rs
@@ -0,0 +1,284 @@
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
+    types::{ARef, ForeignOwnable},
+    ThisModule,
+};
+use core::ops::Deref;
+use kernel::prelude::*;
+
+/// An adapter for the registration of PCI drivers.
+pub struct Adapter<T: Driver>(T);
+
+impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
+    type RegType = bindings::pci_driver;
+
+    fn register(
+        pdrv: &mut Self::RegType,
+        name: &'static CStr,
+        module: &'static ThisModule,
+    ) -> Result {
+        pdrv.name = name.as_char_ptr();
+        pdrv.probe = Some(Self::probe_callback);
+        pdrv.remove = Some(Self::remove_callback);
+        pdrv.id_table = T::ID_TABLE.as_ptr();
+
+        // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
+        to_result(unsafe {
+            bindings::__pci_register_driver(pdrv as _, module.0, name.as_char_ptr())
+        })
+    }
+
+    fn unregister(pdrv: &mut Self::RegType) {
+        // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
+        unsafe { bindings::pci_unregister_driver(pdrv) }
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
+        let dev = unsafe { device::Device::from_raw(&mut (*pdev).dev) };
+        // SAFETY: `dev` is guaranteed to be embedded in a valid `struct pci_dev` by the call
+        // above.
+        let mut pdev = unsafe { Device::from_dev(dev) };
+
+        // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of `struct pci_device_id` and
+        // does not add additional invariants, so it's safe to transmute.
+        let id = unsafe { &*id.cast::<DeviceId>() };
+        let info = T::ID_TABLE.info(id.index());
+
+        match T::probe(&mut pdev, id, info) {
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
+///         _id: &pci::DeviceId,
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
+    fn probe(dev: &mut Device, id: &DeviceId, id_info: &Self::IdInfo) -> Result<Pin<KBox<Self>>>;
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
2.46.2


