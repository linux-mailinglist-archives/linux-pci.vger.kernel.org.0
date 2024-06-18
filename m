Return-Path: <linux-pci+bounces-8940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AC790E005
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 01:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1E9283982
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 23:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63355188CC8;
	Tue, 18 Jun 2024 23:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2Mu+U1e"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A338316FF28
	for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 23:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754055; cv=none; b=e+Ph6peRS1ZBEY/SZZ/M9bqcpHfstg5Wh3g6h/H1uM1HVob7DJCCpuORooIbM2GfFDlxqUOuFBUq82pO0fgSshz8CUR341ePktRBkm2uf5cCP1SwTf6C4ZRsYL4+t3sK79sG6k6C1MXknDGCuDawOgejpsK/xi34O6TCQwWIOOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754055; c=relaxed/simple;
	bh=NJ06HFiNnwp5HwQ1Yv82r8BnXq42M6HbbJtDiVlYhkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6COD/5rq6kzO7ZASneOgkfmA6YOSGVFc4VXuRs6U4mbkGjingfMFmdWHk8bRDPJ4Ql5FTX7MpOPS0k9Pu3MiR3gJkkNJbXFkwn5croEDeHK8DfoFVeyzRujTobPwfLNc0/m2/m7XhoiLEbzqyKUs9v4U4RAxK4tcisBCvcgQdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2Mu+U1e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718754052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FLt8R9mG7+Q5vVfP6l0HGRxBa2WWQOQ3AyEB5PRg0/8=;
	b=S2Mu+U1eqnofsmsd8CmdQfEt+RqOO/yIZD+CGNTiBLp9JVlCGzIIL0qpE8eJe5tiZuB8kw
	xKI6IrGJYsszFJBwUl1YiHvXIDJ8LPKwGScf/yzCLO6KdL4a+EKIs4vGmLgY8MGGgKsKtl
	ReC7GYcjMxisL+WVpPdIih8bYVW3MJ8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-3I7I7SV_NG63OyBryD2GbA-1; Tue, 18 Jun 2024 19:40:51 -0400
X-MC-Unique: 3I7I7SV_NG63OyBryD2GbA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3625b8355b5so628695f8f.3
        for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 16:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718754050; x=1719358850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLt8R9mG7+Q5vVfP6l0HGRxBa2WWQOQ3AyEB5PRg0/8=;
        b=cLjJ0HJQgcJUC4mjmjIb14OEV98wua5XGrIfwAgfxNqA04bMMuQVIlfTdlVaQrcTmM
         flhfk9NIQ3cOZBbIW6GnPdEBjYD8Ic+IkG9CJCm97rUP+p4u4IlhpLONCbQei8I0gp9w
         vs5zzSoVLFy6+dsMmw3sqL/nPaIvUU5oSwUblj199iQ+vKp9/5rMwNT24t7Riirvn9+p
         gKs19xbljFRet2LA/BFFIRGnH7XJ7+O6dZKnhf/h2WRSXLpXtoEZwhUWmhPIUaz5ZrE/
         G/G36gtUAVLDHsc1QfFsTUV5G4FaizJIdIyXTV1Hns+nWj9Ky+WIj4kOA8MP0uY2x7//
         HWGw==
X-Forwarded-Encrypted: i=1; AJvYcCV4xUsyH6tNo6FRU9kxSGvPVuMk3IBLOf7Y82r0ThQC4aGuVtPDcbgBEw9RLjMrWBn7Gd0OYObgsKJ+IiO98eCx7N/23lKepIjZ
X-Gm-Message-State: AOJu0Yzqz5Pbwl2XWg2sJALiAskH3pwdvzzJN7Z1GMTrcgFVYub4fM/T
	AT2Tvi3Nrnzq6P2SYlyTgUse2iSy40BLABdNO3g3RFD9H71NAy+qMh2p9pvI61T/cpDuhtPjr6c
	9dXbk3uUSdofzP0BOxg6qg9jRlEQAUI8sMlHJsQ177k3Y96upZK2n5jmW8g==
X-Received: by 2002:a5d:4535:0:b0:354:f218:9661 with SMTP id ffacd0b85a97d-363170ed3femr858512f8f.14.1718754050261;
        Tue, 18 Jun 2024 16:40:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU+U6Wm0EGp4IMDnnc/QucR5wKEoc9VgmpJhXeJunCegvyHy5rlDYh7FvIr5roHHV/75nmtw==
X-Received: by 2002:a5d:4535:0:b0:354:f218:9661 with SMTP id ffacd0b85a97d-363170ed3femr858498f8f.14.1718754049849;
        Tue, 18 Jun 2024 16:40:49 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360917c264bsm8131346f8f.56.2024.06.18.16.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 16:40:49 -0700 (PDT)
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
Subject: [PATCH v2 02/10] rust: implement generic driver registration
Date: Wed, 19 Jun 2024 01:39:48 +0200
Message-ID: <20240618234025.15036-3-dakr@redhat.com>
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

This patch is based on previous work from Wedson Almeida Filho.

Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/driver.rs | 128 ++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs    |   1 +
 2 files changed, 129 insertions(+)
 create mode 100644 rust/kernel/driver.rs

diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
new file mode 100644
index 000000000000..e04406b93b56
--- /dev/null
+++ b/rust/kernel/driver.rs
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Generic support for drivers of different buses (e.g., PCI, Platform, Amba, etc.).
+//!
+//! Each bus / subsystem is expected to implement [`DriverOps`], which allows drivers to register
+//! using the [`Registration`] class.
+
+use crate::error::{Error, Result};
+use crate::{init::PinInit, str::CStr, try_pin_init, types::Opaque, ThisModule};
+use core::pin::Pin;
+use macros::{pin_data, pinned_drop};
+
+/// The [`DriverOps`] trait serves as generic interface for subsystems (e.g., PCI, Platform, Amba,
+/// etc.) to privide the corresponding subsystem specific implementation to register / unregister a
+/// driver of the particular type (`RegType`).
+///
+/// For instance, the PCI subsystem would set `RegType` to `bindings::pci_driver` and call
+/// `bindings::__pci_register_driver` from `DriverOps::register` and
+/// `bindings::pci_unregister_driver` from `DriverOps::unregister`.
+pub trait DriverOps {
+    /// The type that holds information about the registration. This is typically a struct defined
+    /// by the C portion of the kernel.
+    type RegType: Default;
+
+    /// Registers a driver.
+    ///
+    /// # Safety
+    ///
+    /// `reg` must point to valid, initialised, and writable memory. It may be modified by this
+    /// function to hold registration state.
+    ///
+    /// On success, `reg` must remain pinned and valid until the matching call to
+    /// [`DriverOps::unregister`].
+    fn register(
+        reg: &mut Self::RegType,
+        name: &'static CStr,
+        module: &'static ThisModule,
+    ) -> Result;
+
+    /// Unregisters a driver previously registered with [`DriverOps::register`].
+    ///
+    /// # Safety
+    ///
+    /// `reg` must point to valid writable memory, initialised by a previous successful call to
+    /// [`DriverOps::register`].
+    fn unregister(reg: &mut Self::RegType);
+}
+
+/// A [`Registration`] is a generic type that represents the registration of some driver type (e.g.
+/// `bindings::pci_driver`). Therefore a [`Registration`] is initialized with some type that
+/// implements the [`DriverOps`] trait, such that the generic `T::register` and `T::unregister`
+/// calls result in the subsystem specific registration calls.
+///
+///Once the `Registration` structure is dropped, the driver is unregistered.
+#[pin_data(PinnedDrop)]
+pub struct Registration<T: DriverOps> {
+    #[pin]
+    reg: Opaque<T::RegType>,
+}
+
+// SAFETY: `Registration` has no fields or methods accessible via `&Registration`, so it is safe to
+// share references to it with multiple threads as nothing can be done.
+unsafe impl<T: DriverOps> Sync for Registration<T> {}
+
+// SAFETY: Both registration and unregistration are implemented in C and safe to be performed from
+// any thread, so `Registration` is `Send`.
+unsafe impl<T: DriverOps> Send for Registration<T> {}
+
+impl<T: DriverOps> Registration<T> {
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
+impl<T: DriverOps> PinnedDrop for Registration<T> {
+    fn drop(self: Pin<&mut Self>) {
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
+pub struct Module<T: DriverOps> {
+    #[pin]
+    _driver: Registration<T>,
+}
+
+impl<T: DriverOps + Sync + Send> crate::InPlaceModule for Module<T> {
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
index 5af00e072a58..5382402cd3db 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -29,6 +29,7 @@
 pub mod alloc;
 mod build_assert;
 pub mod device;
+pub mod driver;
 pub mod error;
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
 pub mod firmware;
-- 
2.45.1


