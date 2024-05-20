Return-Path: <linux-pci+bounces-7680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAD38CA161
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 19:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5608CB2257C
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 17:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3471C13AA43;
	Mon, 20 May 2024 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eEexPLJW"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BB613A89C
	for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716226055; cv=none; b=meo39T7ZX9rhcXrh7H102h1G5JUiIt+X0ME7ZGsLVbrKCt4yIcC1QEIF9Fb+5AQjHKOkHSA5x/cgXh7IO3wOnDM2WzTSzCvVTexPQl46X3vG8YkVBSYYqNIxVUl/4sFEOdb71bE/4ZzE+GhL5irqhpnpIU7W4YVDlUFjLSQ6iMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716226055; c=relaxed/simple;
	bh=5ysJ7veRsD9TP3SKhDxVg22CoKwjiIVIqxUU9mdur14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHCXOwVPzSqG7eBN/Tg5/B5J0YudI19u3DXgEJkyMuV5iv4/qMB2l4MtqncPlSUOplctmWMzpPKW+TcMuIqVYnynnCAzeUFa1LSZ4y7FRH8kWbVJ+jvq6VPMVfKQNEfAFG4VGZFOdUmdRr8wqP1VLa2p/kG/9dpsjU28Sr3VCa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eEexPLJW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716226052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6S1JMvs3wWwoYY5yLjwWSAqPBxm7FbzVGctvxFDmowc=;
	b=eEexPLJWNNzKfZkiLJ3SALMCPI9Gg4TZamzSfFBSYsuK4bP6qeGGSFS0yKy/roiEvIfX1C
	GwVcnMa8UDZUm6QRShpLgVTCLJaNXMmrp2Na/PpQgzaTMP4a9DpQ9ChG1oDkGfbDA7eZ4H
	Hmqeu8ud3P/w4fmzG7vtCKHWbzOmUCA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-GWFxlPLePXSDETWkYKBc0w-1; Mon, 20 May 2024 13:27:30 -0400
X-MC-Unique: GWFxlPLePXSDETWkYKBc0w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41ffc807e80so45571575e9.2
        for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 10:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716226049; x=1716830849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6S1JMvs3wWwoYY5yLjwWSAqPBxm7FbzVGctvxFDmowc=;
        b=W6G8qU+sCiauU+/IYtnB5irha/horFubdK1sTaJFngNHW+YEyfln933jmnKs7qGznk
         CZq3c+pSyuyrT1twYwNgJLHzjU72QRC+q5XcKCAPS56rPtQUAbIDhCW27K6anrWmiDLC
         DpM42lQUp0eV3yOnHUmdyUuniT1NzaibOZDgoLxdUDEI1aKMY7z4rGY1XfvZW9/an/Zb
         lE3n4h489s/HJQeon+1v5xRcdgkgWrAi6DWn75Zm7x2/J7Gs/aKcX/f9iPy7l4YMZdk/
         mXlzEYtxH3vtkF9ss5f4lezydEcjGi6cb7ZmiSSbj1hXeKGyQW2d1UtY+hcITkXYL3ZN
         2KXw==
X-Forwarded-Encrypted: i=1; AJvYcCWSFTl8LSTJo79e4yGXfqB2CT4DxF3ZUs1zQCA1ZTd9G///SNX/XHz1zQif/Gx3Ki2XxtdYwNgoPmWMmcCA43anVeh1ZlywtNFJ
X-Gm-Message-State: AOJu0YwydQKaDEbXTLQm9ISIoxsopmsjgkRAYrfjr1FblGHAUVwMMgEC
	lskCTKS1ixPynHxpsWqKndeODr7bCOv1xP6f6ZrkH6ZXMeiomb+sneY0k62KcwGiGnHTjxpDNpo
	kc98mXoNkWmobb8EibY6JBIZFBM7K51hn3JLBs8fQj+PyMhWGBVfjWM+PSA==
X-Received: by 2002:a05:600c:1547:b0:420:1078:a74c with SMTP id 5b1f17b1804b1-4201078a89cmr192092395e9.20.1716226049305;
        Mon, 20 May 2024 10:27:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEowXlkhLoQlD536HTIQse+gl+PqtvMMQTha8X+ha5edJrAVhb5zSf/srjBFRZN7CNK5aE/Hg==
X-Received: by 2002:a05:600c:1547:b0:420:1078:a74c with SMTP id 5b1f17b1804b1-4201078a89cmr192092225e9.20.1716226048892;
        Mon, 20 May 2024 10:27:28 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce24c0sm430961865e9.17.2024.05.20.10.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 10:27:28 -0700 (PDT)
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
	lyude@redhat.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [RFC PATCH 09/11] rust: add basic PCI driver abstractions
Date: Mon, 20 May 2024 19:25:46 +0200
Message-ID: <20240520172554.182094-10-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240520172554.182094-1-dakr@redhat.com>
References: <20240520172554.182094-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: FUJITA Tomonori <fujita.tomonori@gmail.com>

This commit implements the abstractions necessary to bind a most basic
PCI driver to a PCI device. It also serves as a ground layer for further
PCI functionality.

Specifically, a basic PCI driver has to provide register() and
unregister() methods, a PCI device structure for Rust, and probe() and
remove() callbacks for the C side.

A PCI driver shall be able to register itself for the desired devices,
recognized by their device ID. Another basic necessity is the ability to
store driver data, i.e., through pci_set_drvdata().

In congruency with the C implementation of pci_dev, a Rust PCI device
holds a basic device (device::Device) which is always reference counted
to ensure it cannot disappear as long as there are still users.

Holding a basic device allows for both using interfaces that require a
device, as well as such that demand a pci_dev, which can be obtained
through as_raw(), using the established container_of() macro.

Implement a basic driver model with probe() and remove() callbacks,
implementing the corresponding traits from the 'driver' crate.

Implement PCI device IDs.

Implement pci::Device with basic methods, holding an always reference
counted device::Device.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Co-developed-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Co-developed-by: Danilo Krummrich <dakr@redhat.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers.c                  |  18 ++
 rust/kernel/lib.rs              |   2 +
 rust/kernel/pci.rs              | 328 ++++++++++++++++++++++++++++++++
 4 files changed, 349 insertions(+)
 create mode 100644 rust/kernel/pci.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ddb5644d4fd9..32221de16e57 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -11,6 +11,7 @@
 #include <linux/ethtool.h>
 #include <linux/jiffies.h>
 #include <linux/mdio.h>
+#include <linux/pci.h>
 #include <linux/phy.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index 34061eca05a0..c3d80301185c 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -33,6 +33,7 @@
 #include <linux/spinlock.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <linux/pci.h>
 
 __noreturn void rust_helper_BUG(void)
 {
@@ -178,6 +179,23 @@ int rust_helper_devm_add_action(struct device *dev, void (*action)(void *), void
 	return devm_add_action(dev, action, data);
 }
 
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
index 11645060b444..606391cbff83 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -55,6 +55,8 @@
 #[doc(hidden)]
 pub use bindings;
 pub use macros;
+#[cfg(all(CONFIG_PCI, CONFIG_PCI_MSI))]
+pub mod pci;
 pub use uapi;
 
 #[doc(hidden)]
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
new file mode 100644
index 000000000000..323aea565d84
--- /dev/null
+++ b/rust/kernel/pci.rs
@@ -0,0 +1,328 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Wrappers for the PCI subsystem
+//!
+//! C header: [`include/linux/pci.h`](../../../../include/linux/pci.h)
+
+use crate::{
+    bindings, container_of, device, driver,
+    error::{to_result, Result},
+    str::CStr,
+    types::{ARef, ForeignOwnable},
+    ThisModule,
+};
+use kernel::prelude::*; // for pinned_drop
+
+/// An adapter for the registration of PCI drivers.
+///
+/// # Example
+///
+///```
+/// use kernel::pci;
+///
+/// impl pci::Driver for MyDriver {
+///     type Data = Arc<MyDeviceData>;
+///
+///     define_pci_id_table! {
+///         (),
+///         [ (pci::DeviceId::new(bindings::PCI_VENDOR_ID_MY_VENDOR,
+///                               bindings::PCI_ANY_ID as u32),
+///            None)
+///         ]
+///     }
+///
+///     fn probe(
+///         pdev: &mut pci::Device,
+///         id_info: Option<&Self::IdInfo>
+///     ) -> Result<Arc<Self::Data>> {
+///         ...
+///     }
+///
+///     fn remove(data: &Self::Data) {
+///         ...
+///     }
+/// }
+///
+/// struct MyModule {
+///     _registration: Pin<Box<driver::Registration<pci::Adapter<MyDriver>>>>,
+/// }
+///
+/// impl kernel::Module for MyModule {
+///     fn init(_name: &'static CStr, module: &'static ThisModule) -> Result<Self> {
+///         let registration = driver::Registration::new_pinned(c_str!("MyDriver"), module)?;
+///
+///         Ok(Self {
+///             _registration: registration,
+///         })
+///     }
+/// }
+///```
+pub struct Adapter<T: Driver>(T);
+
+impl<T: Driver> driver::DriverOps for Adapter<T> {
+    type RegType = bindings::pci_driver;
+
+    // SAFETY: The caller must ensure that `reg` is valid and unequal NULL.
+    unsafe fn register(
+        reg: *mut bindings::pci_driver,
+        name: &'static CStr,
+        module: &'static ThisModule,
+    ) -> Result {
+        // SAFETY: Guaranteed by the safety requirements of this function.
+        let pdrv: &mut bindings::pci_driver = unsafe { &mut *reg };
+
+        pdrv.name = name.as_char_ptr();
+        pdrv.probe = Some(Self::probe_callback);
+        pdrv.remove = Some(Self::remove_callback);
+        pdrv.id_table = T::ID_TABLE.as_ref();
+        // SAFETY: Guaranteed by the safety requirements of this function.
+        to_result(unsafe { bindings::__pci_register_driver(reg, module.0, name.as_char_ptr()) })
+    }
+
+    // SAFETY: The caller must ensure that `reg` is valid and unequal NULL.
+    unsafe fn unregister(reg: *mut bindings::pci_driver) {
+        // SAFETY: Guaranteed by the safety requirements of this function.
+        unsafe { bindings::pci_unregister_driver(reg) }
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
+                // SAFETY:
+                // A valid `pdev` is always passed to this function. `data` is always valid since
+                // it's created in Rust.
+                unsafe { bindings::pci_set_drvdata(pdev.as_raw(), data.into_foreign() as _) };
+            }
+            Err(err) => return Error::to_errno(err),
+        }
+
+        0
+    }
+
+    extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
+        // SAFETY: This function is called by the C side and always with a valid `pdev`.
+        let ptr = unsafe { bindings::pci_get_drvdata(pdev) };
+        // SAFETY: Guaranteed by the preceding safety requirement.
+        let data = unsafe { T::Data::from_foreign(ptr) };
+        T::remove(&data);
+        <T::Data as driver::DeviceRemoval>::device_remove(&data);
+    }
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
+unsafe impl driver::RawDeviceId for DeviceId {
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
+/// ```ignore
+/// # use kernel::{pci, define_pci_id_table};
+/// #
+/// struct MyDriver;
+/// impl pci::Driver for MyDriver {
+///     // [...]
+/// #   fn probe(_dev: &mut pci::Device, _id_info: Option<&Self::IdInfo>) -> Result {
+/// #       Ok(())
+/// #   }
+/// #   define_pci_id_table! {u32, [
+/// #       (pci::DeviceId::new(0x010800, 0xffffff), None),
+/// #       (pci::DeviceId::with_class(0x010802, 0xfffff), Some(0x10)),
+/// #   ]}
+/// }
+/// ```
+#[macro_export]
+macro_rules! define_pci_id_table {
+    ($data_type:ty, $($t:tt)*) => {
+        type IdInfo = $data_type;
+        const ID_TABLE: $crate::driver::IdTable<'static, $crate::pci::DeviceId, $data_type> = {
+            $crate::define_id_array!(ARRAY, $crate::pci::DeviceId, $data_type, $($t)* );
+            ARRAY.as_table()
+        };
+    };
+}
+pub use define_pci_id_table;
+
+/// The PCI driver trait.
+///
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
+    /// `type Data: ForeignOwnable + driver::DeviceRemoval = ();`
+    type Data: ForeignOwnable + driver::DeviceRemoval;
+
+    /// The type holding information about each device id supported by the driver.
+    ///
+    /// TODO: Use associated_type_defaults once stabilized:
+    ///
+    /// type IdInfo: 'static = ();
+    type IdInfo: 'static;
+
+    /// The table of device ids supported by the driver.
+    const ID_TABLE: driver::IdTable<'static, DeviceId, Self::IdInfo>;
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
+    fn remove(_data: &Self::Data);
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
+        // SAFETY: Guaranteed by the requirements described in pci::Device::new().
+        unsafe { container_of!(self.0.as_raw(), bindings::pci_dev, dev) as _ }
+    }
+
+    /// Enable the Device's memory.
+    pub fn enable_device_mem(&self) -> Result {
+        // SAFETY: By the type invariants, we know that `self.ptr` is non-null and valid.
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
+        // SAFETY: By the type invariants, we know that `self.ptr` is non-null and valid.
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


