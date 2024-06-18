Return-Path: <linux-pci+bounces-8948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B9590E018
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 01:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685611C2278D
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 23:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D5B1991BD;
	Tue, 18 Jun 2024 23:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F48fKsv4"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D43E1990A8
	for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 23:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754084; cv=none; b=Fq9T59tr1sSSi3OCb3womSNsjysDPgE1p0hXAsITx11mGXaTZrhZnez23uH88lNh9iNwGXhJO6MuJG+JWyO6Y3MXPUJvaZck7OxuZsKoTDy1m48Zi+Nk18E5zup271krCb0oa1OaG7Ah5k/fjn7NUmY0HmbWUXxouof4xDYgUGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754084; c=relaxed/simple;
	bh=UFnHR2b1RkzyMe8sQ//KZ/B2Dh7qxTRbvQElPMM07j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qos2GI+K4qa7a/iSKJgr49jubMQt6S+2369ucvz+qJ0/xtH2dxzdUWryuxddjTg73Cmi7oFZmzF5zILU5wS/b4Bcq+Oubjh2q7Y02OyZMsQWkO2edRV8HiozFXx7AhB3qGOYZKtjKkidRgcsReQXJeS5bJzl46Jn9+mWlD2dJeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F48fKsv4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718754081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QLRFxUPd3gb5I0rzZWJWZKgMG9lV0BT3fJ3l5tLlEmo=;
	b=F48fKsv49TnotR/Nnv3IWKpxcBBpmsXXx0pG9I91kChAv3fSYeI5vPnxpI7QTfYVzfXVC8
	wJqsC8lyIyMpHz09AyQRoi5IMrxshlSX1/00XREarSJLTqtykv/GDPyKSrdVvu9u+US0of
	FZ1BB/nQxrqnIsJz2cQpT8p9/nkkCho=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-jOFn9zqkNVi9A__jf8iZ7Q-1; Tue, 18 Jun 2024 19:41:20 -0400
X-MC-Unique: jOFn9zqkNVi9A__jf8iZ7Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3634a634f8aso113505f8f.2
        for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 16:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718754079; x=1719358879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLRFxUPd3gb5I0rzZWJWZKgMG9lV0BT3fJ3l5tLlEmo=;
        b=ClGfRFH9SwDxUBt1JAN+Wc5orMVZCylEvOj0kJFfgTXWcKsmh1yOPo4JaMMK2bb483
         ZPqxjfllqh6jtiEi2dXnZmpFYQOvg9hwPYLSmYZWq23rmdT3vdTPe25q18TrUAuiWh2r
         wPT07oFpMe5kTmjY8zejDFcdVKgfCayPsNC9N9VeD+dacPvMe7ji8EfBeTEtx3S8klJ7
         P1QROzMB3OuAMHuYZOC3z57hYNdO8l7Bmq0ONzg55/FG3sY9/P7kUfimtwV3d/Ju5feh
         9J81ne6RLEOorbagaPLh+RvAzPHoTq0lrgT0uQgYUhgnYo3mcUTThMzGeZ4cL+E5FLsp
         Z8yg==
X-Forwarded-Encrypted: i=1; AJvYcCXcgjK5t2MfxW2Rvzahn8aE2vnbzDdDChG4i72x0kFMBJUIOm6uU67x26bpvzgO65rFe5dzIb47yAF+Lvols8mAfW7TvUcx9HU+
X-Gm-Message-State: AOJu0Yxw5Rv4rR5mC5joMCPHzyQy3aoCD8Rn+KIlY9d+ppjdivaVihB0
	QSHIGHfUz3ll8HNVdurv9EayTiNzMB3WokQeTNjuvMmLsHZLqpZgbHMgUB1EhSxoA0aWK6NWWFs
	AzOl/bkIdjak+WTKH221w6a07s7gEpq+Mn0MeeTqbFfi8jIE/S1qD9ci7eA==
X-Received: by 2002:adf:e410:0:b0:35f:2211:5a28 with SMTP id ffacd0b85a97d-363192d0918mr787481f8f.54.1718754079050;
        Tue, 18 Jun 2024 16:41:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoWOFB721TrUZWeWqqkImFJ6hYgZXirnt34BXfyNcuar464EL2gQ55ZvdXbYLzJLPLHiHHfg==
X-Received: by 2002:adf:e410:0:b0:35f:2211:5a28 with SMTP id ffacd0b85a97d-363192d0918mr787466f8f.54.1718754078694;
        Tue, 18 Jun 2024 16:41:18 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f2303sm15502597f8f.87.2024.06.18.16.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 16:41:18 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	airlied@gmail.com,
	fujita.tomonori@gmail.com,
	lina@asahilina.net,
	pstanner@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	robh@kernel.org,
	daniel.almeida@collabora.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH v2 09/10] rust: pci: add basic PCI device / driver abstractions
Date: Wed, 19 Jun 2024 01:39:55 +0200
Message-ID: <20240618234025.15036-10-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240618234025.15036-1-dakr@redhat.com>
References: <20240618234025.15036-1-dakr@redhat.com>
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
provides `pci::Driver::probe` and `pci::Driver::remove` for the driver
to implement.

The `pci::Device` abstraction represents a `struct pci_dev` and provides
abstractions for common functions, such as `pci::Device::set_master`.

In order to provide the PCI specific parts to a generic
`driver::Registration` the `driver::DriverOps` trait is implemented by
the `pci::Adapter`.

`pci::DeviceId` implements PCI device IDs based on the generic
`driver::RawDevceId` abstraction.

This patch is based on previous work from FUJITA Tomonori.

Co-developed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Co-developed-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers.c                  |  18 ++
 rust/kernel/lib.rs              |   2 +
 rust/kernel/pci.rs              | 325 ++++++++++++++++++++++++++++++++
 4 files changed, 346 insertions(+)
 create mode 100644 rust/kernel/pci.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 18a3f05115cb..30ad2a0e22d7 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -12,6 +12,7 @@
 #include <linux/firmware.h>
 #include <linux/jiffies.h>
 #include <linux/mdio.h>
+#include <linux/pci.h>
 #include <linux/phy.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index 269f97698588..c7f90b457af5 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -28,6 +28,7 @@
 #include <linux/errname.h>
 #include <linux/io.h>
 #include <linux/mutex.h>
+#include <linux/pci.h>
 #include <linux/rcupdate.h>
 #include <linux/refcount.h>
 #include <linux/sched/signal.h>
@@ -293,6 +294,23 @@ int rust_helper_devm_add_action(struct device *dev, void (*action)(void *), void
 }
 EXPORT_SYMBOL_GPL(rust_helper_devm_add_action);
 
+void rust_helper_pci_set_drvdata(struct pci_dev *pdev, void *data)
+{
+	pci_set_drvdata(pdev, data);
+}
+EXPORT_SYMBOL_GPL(rust_helper_pci_set_drvdata);
+
+void *rust_helper_pci_get_drvdata(struct pci_dev *pdev)
+{
+	return pci_get_drvdata(pdev);
+}
+EXPORT_SYMBOL_GPL(rust_helper_pci_get_drvdata);
+
+u64 rust_helper_pci_resource_len(struct pci_dev *pdev, int barnr)
+{
+	return pci_resource_len(pdev, barnr);
+}
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ef9426e32c18..4a02946dbbd9 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -59,6 +59,8 @@
 pub use bindings;
 pub mod io;
 pub use macros;
+#[cfg(all(CONFIG_PCI, CONFIG_PCI_MSI))]
+pub mod pci;
 pub use uapi;
 
 #[doc(hidden)]
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
new file mode 100644
index 000000000000..a8230474e9b8
--- /dev/null
+++ b/rust/kernel/pci.rs
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Wrappers for the PCI subsystem
+//!
+//! C header: [`include/linux/pci.h`](srctree/include/linux/pci.h)
+
+use crate::{
+    bindings, container_of, device,
+    device_id::{IdTable, RawDeviceId},
+    driver,
+    error::{to_result, Result},
+    str::CStr,
+    types::{ARef, ForeignOwnable},
+    ThisModule,
+};
+use kernel::prelude::*; // for pinned_drop
+
+/// An adapter for the registration of PCI drivers.
+pub struct Adapter<T: Driver>(T);
+
+impl<T: Driver> driver::DriverOps for Adapter<T> {
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
+        pdrv.id_table = T::ID_TABLE.as_ref();
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
+impl<T: Driver> Adapter<T> {
+    extern "C" fn probe_callback(
+        pdev: *mut bindings::pci_dev,
+        id: *const bindings::pci_device_id,
+    ) -> core::ffi::c_int {
+        // SAFETY: Safe because the core kernel only ever calls the probe callback with a valid
+        // `pdev`.
+        let dev = unsafe { device::Device::from_raw(&mut (*pdev).dev) };
+        // SAFETY: Guaranteed by the rules described above.
+        let mut pdev = unsafe { Device::from_dev(dev) };
+
+        // SAFETY: `id` is a pointer within the static table, so it's always valid.
+        let offset = unsafe { (*id).driver_data };
+        let info = {
+            // SAFETY: The offset comes from a previous call to `offset_from` in `IdArray::new`,
+            // which guarantees that the resulting pointer is within the table.
+            let ptr = unsafe {
+                id.cast::<u8>()
+                    .offset(offset as _)
+                    .cast::<Option<T::IdInfo>>()
+            };
+            // SAFETY: Guaranteed by the preceding safety requirement.
+            unsafe { (*ptr).as_ref() }
+        };
+        match T::probe(&mut pdev, info) {
+            Ok(data) => {
+                // Let the `struct pci_dev` own a reference of the driver's private data.
+                // SAFETY: The core kernel only ever calls the probe callback with a valid `pdev`.
+                unsafe { bindings::pci_set_drvdata(pdev.as_raw(), data.into_foreign() as _) };
+            }
+            Err(err) => return Error::to_errno(err),
+        }
+
+        0
+    }
+
+    extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
+        // SAFETY: The core kernel only ever calls the probe callback with a valid `pdev`. `ptr`
+        // points to a valid reference of the driver's private data, as it was set by
+        // `Adapter::probe_callback`.
+        let data = unsafe {
+            let ptr = bindings::pci_get_drvdata(pdev);
+
+            T::Data::from_foreign(ptr)
+        };
+
+        T::remove(&data);
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
+    ($($f:tt)*) => {
+        $crate::module_driver!(<T>, $crate::pci::Adapter<T>, { $($f)* });
+    };
+}
+
+/// Abstraction for bindings::pci_device_id.
+#[derive(Clone, Copy)]
+pub struct DeviceId {
+    /// Vendor ID
+    pub vendor: u32,
+    /// Device ID
+    pub device: u32,
+    /// Subsystem vendor ID
+    pub subvendor: u32,
+    /// Subsystem device ID
+    pub subdevice: u32,
+    /// Device class and subclass
+    pub class: u32,
+    /// Limit which sub-fields of the class
+    pub class_mask: u32,
+}
+
+impl DeviceId {
+    const PCI_ANY_ID: u32 = !0;
+
+    /// PCI_DEVICE macro.
+    pub const fn new(vendor: u32, device: u32) -> Self {
+        Self {
+            vendor,
+            device,
+            subvendor: DeviceId::PCI_ANY_ID,
+            subdevice: DeviceId::PCI_ANY_ID,
+            class: 0,
+            class_mask: 0,
+        }
+    }
+
+    /// PCI_DEVICE_CLASS macro.
+    pub const fn with_class(class: u32, class_mask: u32) -> Self {
+        Self {
+            vendor: DeviceId::PCI_ANY_ID,
+            device: DeviceId::PCI_ANY_ID,
+            subvendor: DeviceId::PCI_ANY_ID,
+            subdevice: DeviceId::PCI_ANY_ID,
+            class,
+            class_mask,
+        }
+    }
+
+    /// PCI_DEVICE_ID macro.
+    pub const fn to_rawid(&self, offset: isize) -> bindings::pci_device_id {
+        bindings::pci_device_id {
+            vendor: self.vendor,
+            device: self.device,
+            subvendor: self.subvendor,
+            subdevice: self.subdevice,
+            class: self.class,
+            class_mask: self.class_mask,
+            driver_data: offset as _,
+            override_only: 0,
+        }
+    }
+}
+
+// SAFETY: `ZERO` is all zeroed-out and `to_rawid` stores `offset` in `pci_device_id::driver_data`.
+unsafe impl RawDeviceId for DeviceId {
+    type RawType = bindings::pci_device_id;
+
+    const ZERO: Self::RawType = bindings::pci_device_id {
+        vendor: 0,
+        device: 0,
+        subvendor: 0,
+        subdevice: 0,
+        class: 0,
+        class_mask: 0,
+        driver_data: 0,
+        override_only: 0,
+    };
+}
+
+/// Define a const pci device id table
+///
+/// # Examples
+///
+/// See [`Driver`]
+///
+#[macro_export]
+macro_rules! define_pci_id_table {
+    ($data_type:ty, $($t:tt)*) => {
+        type IdInfo = $data_type;
+        const ID_TABLE: $crate::device_id::IdTable<'static, $crate::pci::DeviceId, $data_type> = {
+            $crate::define_id_array!(ARRAY, $crate::pci::DeviceId, $data_type, $($t)* );
+            ARRAY.as_table()
+        };
+    };
+}
+pub use define_pci_id_table;
+
+/// The PCI driver trait.
+///
+/// # Example
+///
+///```
+/// # use kernel::{bindings, define_pci_id_table, pci, sync::Arc};
+///
+/// struct MyDriver;
+/// struct MyDeviceData;
+///
+/// impl pci::Driver for MyDriver {
+///     type Data = Arc<MyDeviceData>;
+///
+///     define_pci_id_table! {
+///         (),
+///         [ (pci::DeviceId::new(bindings::PCI_VENDOR_ID_REDHAT,
+///                               bindings::PCI_ANY_ID as u32),
+///            None)
+///         ]
+///     }
+///
+///     fn probe(
+///         _pdev: &mut pci::Device,
+///         _id_info: Option<&Self::IdInfo>
+///     ) -> Result<Self::Data> {
+///         Err(ENODEV)
+///     }
+///
+///     fn remove(_data: &Self::Data) {
+///     }
+/// }
+///```
+/// Drivers must implement this trait in order to get a PCI driver registered. Please refer to the
+/// `Adapter` documentation for an example.
+pub trait Driver {
+    /// Data stored on device by driver.
+    ///
+    /// Corresponds to the data set or retrieved via the kernel's
+    /// `pci_{set,get}_drvdata()` functions.
+    ///
+    /// Require that `Data` implements `ForeignOwnable`. We guarantee to
+    /// never move the underlying wrapped data structure.
+    ///
+    /// TODO: Use associated_type_defaults once stabilized:
+    ///
+    /// `type Data: ForeignOwnable = ();`
+    type Data: ForeignOwnable;
+
+    /// The type holding information about each device id supported by the driver.
+    ///
+    /// TODO: Use associated_type_defaults once stabilized:
+    ///
+    /// type IdInfo: 'static = ();
+    type IdInfo: 'static;
+
+    /// The table of device ids supported by the driver.
+    const ID_TABLE: IdTable<'static, DeviceId, Self::IdInfo>;
+
+    /// PCI driver probe.
+    ///
+    /// Called when a new platform device is added or discovered.
+    /// Implementers should attempt to initialize the device here.
+    fn probe(dev: &mut Device, id: Option<&Self::IdInfo>) -> Result<Self::Data>;
+
+    /// PCI driver remove.
+    ///
+    /// Called when a platform device is removed.
+    /// Implementers should prepare the device for complete removal here.
+    fn remove(data: &Self::Data);
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
+        // SAFETY: Guaranteed by the type invaraints.
+        unsafe { container_of!(self.0.as_raw(), bindings::pci_dev, dev) as _ }
+    }
+
+    /// Enable the Device's memory.
+    pub fn enable_device_mem(&self) -> Result {
+        // SAFETY: Safe by the type invariants.
+        let ret = unsafe { bindings::pci_enable_device_mem(self.as_raw()) };
+        if ret != 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(())
+        }
+    }
+
+    /// Set the Device's master.
+    pub fn set_master(&self) {
+        // SAFETY: Safe by the type invariants.
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
2.45.1


