Return-Path: <linux-pci+bounces-18791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6C79F8113
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 18:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054BF167D84
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 17:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F0919E966;
	Thu, 19 Dec 2024 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/8/9kw8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7584119E7E2;
	Thu, 19 Dec 2024 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627888; cv=none; b=Wp2SwDk4f88Abb+V1JTlGkIlikWm34kdPvAiVHWKPepEJgTqJVzkdSbkKdS+Pxrv4zEVFCDAms+TfnuR0U9Ns5X97uahtJn9HrpaGO5SCsYu0W7dcppP7YmikyYi8xjRdgyaD8uipnX13zBPmTBzeGxUf87Kh+LwN4e25YQDS7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627888; c=relaxed/simple;
	bh=UTiNgkSPA42wFmnim1I8+BekGbQRYCqLffGJQ/UINN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/HQlIOCsRpYRe/dWcqU+Osrqjpix7zL8tsrpuBRhSkRNF/XDD3cwjBWR2phD9SdzzJrPmMlfleWi+Il/EeqjOFsZv8zoCxfnadTdX6tnliBErwc+tU9R3mAiw49NbUn1z1NQWbCCUAUOrBx3lk2qDo186JfC07/kE1wtTBwr2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/8/9kw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E082FC4CECE;
	Thu, 19 Dec 2024 17:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734627888;
	bh=UTiNgkSPA42wFmnim1I8+BekGbQRYCqLffGJQ/UINN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u/8/9kw8LxmDK5OzdN1w8KzMN2KBQpvdoy6lCC1kaC94CnSYuc4Ep2DfSEzEEESw3
	 i0r3Mj5bZbWF/dqYXtm7IGF6m8QFUf8nH3NyUBk5HRf4WsZmw0pmbyKuLQx8ZqfLlS
	 NxgGGoysGpmR6261mhwlxa6KSf19bkIJxp14ZzvOEBCc5iBcyaOROV4BCRtTcp8V41
	 UzUEl2xJg6WPb4zSWu91YcjccdiYW4tlwQo5cn6YjTLZqp4btCG+ei207tPDjqUAdT
	 ekci/59aYtZvncq4L0k9INyh5eSK7RFTFB6vcQWUfRdc5DV0Q75O1D1tXI85WXL6C+
	 PEhqVrBTWCL8g==
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
	Danilo Krummrich <dakr@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: [PATCH v7 02/16] rust: implement generic driver registration
Date: Thu, 19 Dec 2024 18:04:04 +0100
Message-ID: <20241219170425.12036-3-dakr@kernel.org>
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

Implement the generic `Registration` type and the `RegistrationOps`
trait.

The `Registration` structure is the common type that represents a driver
registration and is typically bound to the lifetime of a module. However,
it doesn't implement actual calls to the kernel's driver core to register
drivers itself.

Instead the `RegistrationOps` trait is provided to subsystems, which have
to implement `RegistrationOps::register` and
`RegistrationOps::unregister`. Subsystems have to provide an
implementation for both of those methods where the subsystem specific
variants to register / unregister a driver have to implemented.

For instance, the PCI subsystem would call __pci_register_driver() from
`RegistrationOps::register` and pci_unregister_driver() from
`DrvierOps::unregister`.

Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 MAINTAINERS           |   1 +
 rust/kernel/driver.rs | 117 ++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs    |   1 +
 3 files changed, 119 insertions(+)
 create mode 100644 rust/kernel/driver.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index baf0eeb9a355..2ad58ed40079 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7033,6 +7033,7 @@ F:	include/linux/kobj*
 F:	include/linux/property.h
 F:	lib/kobj*
 F:	rust/kernel/device.rs
+F:	rust/kernel/driver.rs
 
 DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
 M:	Nishanth Menon <nm@ti.com>
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
new file mode 100644
index 000000000000..c1957ee7bb7e
--- /dev/null
+++ b/rust/kernel/driver.rs
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Generic support for drivers of different buses (e.g., PCI, Platform, Amba, etc.).
+//!
+//! Each bus / subsystem is expected to implement [`RegistrationOps`], which allows drivers to
+//! register using the [`Registration`] class.
+
+use crate::error::{Error, Result};
+use crate::{init::PinInit, str::CStr, try_pin_init, types::Opaque, ThisModule};
+use core::pin::Pin;
+use macros::{pin_data, pinned_drop};
+
+/// The [`RegistrationOps`] trait serves as generic interface for subsystems (e.g., PCI, Platform,
+/// Amba, etc.) to provide the corresponding subsystem specific implementation to register /
+/// unregister a driver of the particular type (`RegType`).
+///
+/// For instance, the PCI subsystem would set `RegType` to `bindings::pci_driver` and call
+/// `bindings::__pci_register_driver` from `RegistrationOps::register` and
+/// `bindings::pci_unregister_driver` from `RegistrationOps::unregister`.
+pub trait RegistrationOps {
+    /// The type that holds information about the registration. This is typically a struct defined
+    /// by the C portion of the kernel.
+    type RegType: Default;
+
+    /// Registers a driver.
+    ///
+    /// On success, `reg` must remain pinned and valid until the matching call to
+    /// [`RegistrationOps::unregister`].
+    fn register(
+        reg: &Opaque<Self::RegType>,
+        name: &'static CStr,
+        module: &'static ThisModule,
+    ) -> Result;
+
+    /// Unregisters a driver previously registered with [`RegistrationOps::register`].
+    fn unregister(reg: &Opaque<Self::RegType>);
+}
+
+/// A [`Registration`] is a generic type that represents the registration of some driver type (e.g.
+/// `bindings::pci_driver`). Therefore a [`Registration`] must be initialized with a type that
+/// implements the [`RegistrationOps`] trait, such that the generic `T::register` and
+/// `T::unregister` calls result in the subsystem specific registration calls.
+///
+///Once the `Registration` structure is dropped, the driver is unregistered.
+#[pin_data(PinnedDrop)]
+pub struct Registration<T: RegistrationOps> {
+    #[pin]
+    reg: Opaque<T::RegType>,
+}
+
+// SAFETY: `Registration` has no fields or methods accessible via `&Registration`, so it is safe to
+// share references to it with multiple threads as nothing can be done.
+unsafe impl<T: RegistrationOps> Sync for Registration<T> {}
+
+// SAFETY: Both registration and unregistration are implemented in C and safe to be performed from
+// any thread, so `Registration` is `Send`.
+unsafe impl<T: RegistrationOps> Send for Registration<T> {}
+
+impl<T: RegistrationOps> Registration<T> {
+    /// Creates a new instance of the registration object.
+    pub fn new(name: &'static CStr, module: &'static ThisModule) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            reg <- Opaque::try_ffi_init(|ptr: *mut T::RegType| {
+                // SAFETY: `try_ffi_init` guarantees that `ptr` is valid for write.
+                unsafe { ptr.write(T::RegType::default()) };
+
+                // SAFETY: `try_ffi_init` guarantees that `ptr` is valid for write, and it has
+                // just been initialised above, so it's also valid for read.
+                let drv = unsafe { &*(ptr as *const Opaque<T::RegType>) };
+
+                T::register(drv, name, module)
+            }),
+        })
+    }
+}
+
+#[pinned_drop]
+impl<T: RegistrationOps> PinnedDrop for Registration<T> {
+    fn drop(self: Pin<&mut Self>) {
+        T::unregister(&self.reg);
+    }
+}
+
+/// Declares a kernel module that exposes a single driver.
+///
+/// It is meant to be used as a helper by other subsystems so they can more easily expose their own
+/// macros.
+#[macro_export]
+macro_rules! module_driver {
+    (<$gen_type:ident>, $driver_ops:ty, { type: $type:ty, $($f:tt)* }) => {
+        type Ops<$gen_type> = $driver_ops;
+
+        #[$crate::prelude::pin_data]
+        struct DriverModule {
+            #[pin]
+            _driver: $crate::driver::Registration<Ops<$type>>,
+        }
+
+        impl $crate::InPlaceModule for DriverModule {
+            fn init(
+                module: &'static $crate::ThisModule
+            ) -> impl $crate::init::PinInit<Self, $crate::error::Error> {
+                $crate::try_pin_init!(Self {
+                    _driver <- $crate::driver::Registration::new(
+                        <Self as $crate::ModuleMetadata>::NAME,
+                        module,
+                    ),
+                })
+            }
+        }
+
+        $crate::prelude::module! {
+            type: DriverModule,
+            $($f)*
+        }
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 61b82b78b915..7818407f9aac 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -35,6 +35,7 @@
 mod build_assert;
 pub mod cred;
 pub mod device;
+pub mod driver;
 pub mod error;
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
 pub mod firmware;
-- 
2.47.1


