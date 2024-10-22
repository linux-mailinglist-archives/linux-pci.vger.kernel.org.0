Return-Path: <linux-pci+bounces-15051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4819AB87F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 23:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A3C1C22B2E
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 21:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E080E1CEE83;
	Tue, 22 Oct 2024 21:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dq6kYKkQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07F51CDA16;
	Tue, 22 Oct 2024 21:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632773; cv=none; b=HBlcesPox/35YMHefjNJAzyelqs3uN/ayYUn4Y/nlh/H8EMIXuJ9iqXtEhYO+6bKG/ARj+m/DhknKXzA2tUW41QsmCyoE2XzVVBNSeXZ4VrrfuERyrBDbAFiRVzBRJfA8bAHYFqMSO39XAf/9syja7paVFxaa+YDc7L5FM7s27s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632773; c=relaxed/simple;
	bh=Wcg5uOvd6OwKYJm21JYorr4CAYWRph8Sk4X/N1PKSrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pENcpF+/IWscwNy5g7AJtiarI9OA6WwXbn8YY2MxSLcDiNMjGxtqbn2XnAA5T2z+6mYZmuAlMAPsIncWhYXqjb60nIsT6G1/7jDwi4SJSB/d7p9giQbLsJ5XI60ApUEJRClQJHS9LLyqrOpMThAKZFv4ZGZWzO8wUUTx92aX73U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dq6kYKkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FD3C4CECD;
	Tue, 22 Oct 2024 21:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729632773;
	bh=Wcg5uOvd6OwKYJm21JYorr4CAYWRph8Sk4X/N1PKSrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dq6kYKkQ23T7jUlxRss0fQ7oxfu7MwGqPNEsogggg6KH10lQBo8GqSAKIi0WUijSo
	 GrUb9JXrKioo49BO4r8SdMDOkuiCZJJdBfQqr1PAT+w7S/tOPRxbodFFfR1txTLJfH
	 FpnkTWZosEXuOsfTGxDtymuP6znH+DD8UEj/yoVtmTFn0CoI1gIxa2qxhkmnYNxxIa
	 VTZjfNyqScyeAdos/QYsP6bBaC6LI9RKi5oggg0DKn2OgmbMsbEluaLNNgaYyehPQ1
	 bI5w/uW/WpCUoasJnwQ2UPKe83DcyREkPba0TkLw+xfe39PaAV4BBUlknoVd2kLYLs
	 e4Gt6ar3KWr2A==
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
	Danilo Krummrich <dakr@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: [PATCH v3 04/16] rust: implement generic driver registration
Date: Tue, 22 Oct 2024 23:31:41 +0200
Message-ID: <20241022213221.2383-5-dakr@kernel.org>
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

Implement the generic `Registration` type and the `DriverOps` trait.

The `Registration` structure is the common type that represents a driver
registration and is typically bound to the lifetime of a module. However,
it doesn't implement actual calls to the kernel's driver core to register
drivers itself.

Instead the `DriverOps` trait is provided to subsystems, which have to
implement `DriverOps::register` and `DrvierOps::unregister`. Subsystems
have to provide an implementation for both of those methods where the
subsystem specific variants to register / unregister a driver have to
implemented.

For instance, the PCI subsystem would call __pci_register_driver() from
`DriverOps::register` and pci_unregister_driver() from
`DrvierOps::unregister`.

Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 MAINTAINERS           |   1 +
 rust/kernel/driver.rs | 120 ++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs    |   1 +
 3 files changed, 122 insertions(+)
 create mode 100644 rust/kernel/driver.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index b77f4495dcf4..29b9ecb63f81 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6982,6 +6982,7 @@ F:	include/linux/kobj*
 F:	include/linux/property.h
 F:	lib/kobj*
 F:	rust/kernel/device.rs
+F:	rust/kernel/driver.rs
 
 DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
 M:	Nishanth Menon <nm@ti.com>
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
new file mode 100644
index 000000000000..c558f23c33d9
--- /dev/null
+++ b/rust/kernel/driver.rs
@@ -0,0 +1,120 @@
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
+/// Amba, etc.) to privide the corresponding subsystem specific implementation to register /
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
+        reg: &mut Self::RegType,
+        name: &'static CStr,
+        module: &'static ThisModule,
+    ) -> Result;
+
+    /// Unregisters a driver previously registered with [`RegistrationOps::register`].
+    fn unregister(reg: &mut Self::RegType);
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
+                let drv = unsafe { &mut *ptr };
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
+        // SAFETY: The existence of the `Registration` guarantees that `self.reg.get()` is properly
+        // aligned and points to a valid value.
+        let drv = unsafe { &mut *self.reg.get() };
+
+        T::unregister(drv);
+    }
+}
+
+/// A kernel module that only registers the given driver on init.
+///
+/// This is a helper struct to make it easier to define single-functionality modules, in this case,
+/// modules that offer a single driver.
+#[pin_data]
+pub struct Module<T: RegistrationOps> {
+    #[pin]
+    _driver: Registration<T>,
+}
+
+impl<T: RegistrationOps + Sync + Send> crate::InPlaceModule for Module<T> {
+    fn init(name: &'static CStr, module: &'static ThisModule) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            _driver <- Registration::<T>::new(name, module),
+        })
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
+        type ModuleType = $crate::driver::Module<Ops<$type>>;
+        $crate::prelude::module! {
+            type: ModuleType,
+            $($f)*
+        }
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 83f76dc7bad2..f70f258fbcdc 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -32,6 +32,7 @@
 pub mod block;
 mod build_assert;
 pub mod device;
+pub mod driver;
 pub mod error;
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
 pub mod firmware;
-- 
2.46.2


