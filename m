Return-Path: <linux-pci+bounces-29176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF9DAD1568
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 00:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB45167DA5
	for <lists+linux-pci@lfdr.de>; Sun,  8 Jun 2025 22:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D202720B1FC;
	Sun,  8 Jun 2025 22:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="i310zMII"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D27255227;
	Sun,  8 Jun 2025 22:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749423442; cv=pass; b=PWvrh5SaEQMQ42NXTneNav/KJW8soAZ0LbnzYmBG/PSoBcEWG7SUn1onTbQxk25NoGOkGhXw4g5cuKaYFaNEHWNI2VGpxdrlw76CasrTk+4icozRbwyeqdvFcoQPgyRHN0YuczS6fBdOCxvNHpBVstQmDEY5TdcMvei3xWo+TNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749423442; c=relaxed/simple;
	bh=gh+6EtzXiUfDWdKQEjvCNr/9/IjCVCghKGJx58PTMXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VHvFEQCHNOCXSaP94py+Zx+IUYh/3mnefsceN3SNC1L5sqMY1DwVA87HEA0cguLp4VvR4YMHl97PN9+q0jdNuiyID06wTuC3aJGthm74dS9LO0am61bKt5BFi9uHE7rpRAYZtKFgetUrurx4IccFuxCk5SBoXuCGk/7EXjrEZ04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=i310zMII; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1749423421; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hqth1oD0NveDamzoKv4oZgYunyWtNj8auKJ0Fj+D7N3+9uRus76LPmrB6Xc1nqL2PQ11uka93Ub+D/v9vLYbAYXSeVA+QvPLwzw6WppI2gey03O1g89467nWZllwTFdRAiZbaAGcR62q16f/WkDzPoED6UdIn9ahXBlB3JybWcs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749423421; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kZL7F68rAg5pQS7p283U9ApghHH6AheX1Cu2Ie/NtA4=; 
	b=fc86/LpA7CAn6BR36TPQAqJcubJhYzrBfX/uo3Lbnwa56OSS5MxMSJ1RBsmypBsT2hMGjQM62T50JsP6zELMQO25nL8B2F7GKY7EJPz85Sh1SPO+ql6Y/WbPLVBxtlc9LbLvlWB5Lepe8oDqT7Ae2W6syMk/dhurlSPMGmOWvQw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749423421;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=kZL7F68rAg5pQS7p283U9ApghHH6AheX1Cu2Ie/NtA4=;
	b=i310zMIIlHjBHa/K1kZrkmYfNV5lT7olJsOb3m3vEzNLNU16+eOGR60c4MqFoiP7
	5sME1vFBmfC4+TK6BNc2vLyqzCz2xKNXuskL9Q8s2361vQjqeGqxKHTu7nTB6Ev6Muo
	gYm8Le8Tta21bZ5zXNaZUb5OqEbsb2SUhdoYjsDg=
Received: by mx.zohomail.com with SMTPS id 1749423419379950.0537688709596;
	Sun, 8 Jun 2025 15:56:59 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Sun, 08 Jun 2025 19:51:08 -0300
Subject: [PATCH v4 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250608-topics-tyr-request_irq-v4-3-81cb81fb8073@collabora.com>
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
In-Reply-To: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Benno Lossin <lossin@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-pci@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

This patch adds support for non-threaded IRQs and handlers through
irq::Registration and the irq::Handler trait.

Registering an IRQ is defined as pub(crate) so that future patches can
define proper (safe) accessors for the IRQs exposed by a device. Said
accessors are bus-specific.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/irq.c              |   9 ++
 rust/kernel/irq.rs              |   5 +
 rust/kernel/irq/request.rs      | 259 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 275 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index bc494745f67b82e7a3a6f53055ece0fc3acf6e0d..32b95df509f1aec2d05035a1c49ec262d1ed7624 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -50,6 +50,7 @@
 #include <linux/ethtool.h>
 #include <linux/file.h>
 #include <linux/firmware.h>
+#include <linux/interrupt.h>
 #include <linux/fs.h>
 #include <linux/jiffies.h>
 #include <linux/jump_label.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 0f1b5d11598591bc62bb6439747211af164b76d6..25c927264835271f84d8c95d79f4ad6a381a7071 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -20,6 +20,7 @@
 #include "dma.c"
 #include "drm.c"
 #include "err.c"
+#include "irq.c"
 #include "fs.c"
 #include "io.c"
 #include "jump_label.c"
diff --git a/rust/helpers/irq.c b/rust/helpers/irq.c
new file mode 100644
index 0000000000000000000000000000000000000000..1faca428e2c047a656dec3171855c1508d67e60b
--- /dev/null
+++ b/rust/helpers/irq.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/interrupt.h>
+
+int rust_helper_request_irq(unsigned int irq, irq_handler_t handler,
+			    unsigned long flags, const char *name, void *dev)
+{
+	return request_irq(irq, handler, flags, name, dev);
+}
diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
index 9abd9a6dc36f3e3ecc1f92ad7b0040176b56a079..650c9409a86ba25dfc2453cd10350f299de2450d 100644
--- a/rust/kernel/irq.rs
+++ b/rust/kernel/irq.rs
@@ -12,3 +12,8 @@
 
 /// Flags to be used when registering IRQ handlers.
 pub mod flags;
+
+/// IRQ allocation and handling.
+pub mod request;
+
+pub use request::{Handler, IrqReturn, Registration};
diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
new file mode 100644
index 0000000000000000000000000000000000000000..e0bf8ca192e7b27c6dbfe611c3a6cc8df8153c35
--- /dev/null
+++ b/rust/kernel/irq/request.rs
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright 2025 Collabora ltd.
+
+//! This module provides types like [`Registration`] and
+//! [`ThreadedRegistration`], which allow users to register handlers for a given
+//! IRQ line.
+
+use core::marker::PhantomPinned;
+
+use pin_init::pin_init_from_closure;
+
+use crate::alloc::Allocator;
+use crate::device::Bound;
+use crate::device::Device;
+use crate::devres::Devres;
+use crate::error::to_result;
+use crate::irq::flags::Flags;
+use crate::prelude::*;
+use crate::str::CStr;
+use crate::sync::Arc;
+
+/// The value that can be returned from an IrqHandler or a ThreadedIrqHandler.
+pub enum IrqReturn {
+    /// The interrupt was not from this device or was not handled.
+    None,
+
+    /// The interrupt was handled by this device.
+    Handled,
+}
+
+impl IrqReturn {
+    fn into_inner(self) -> u32 {
+        match self {
+            IrqReturn::None => bindings::irqreturn_IRQ_NONE,
+            IrqReturn::Handled => bindings::irqreturn_IRQ_HANDLED,
+        }
+    }
+}
+
+/// Callbacks for an IRQ handler.
+pub trait Handler: Sync {
+    /// The actual handler function. As usual, sleeps are not allowed in IRQ
+    /// context.
+    fn handle_irq(&self) -> IrqReturn;
+}
+
+impl<T: ?Sized + Handler + Send> Handler for Arc<T> {
+    fn handle_irq(&self) -> IrqReturn {
+        T::handle_irq(self)
+    }
+}
+
+impl<T: ?Sized + Handler, A: Allocator> Handler for Box<T, A> {
+    fn handle_irq(&self) -> IrqReturn {
+        T::handle_irq(self)
+    }
+}
+
+struct RegistrationInner {
+    irq: u32,
+    cookie: *mut kernel::ffi::c_void,
+}
+
+impl RegistrationInner {
+    fn synchronize(&self) {
+        // SAFETY:
+        // - `self.irq` is the same as the one passed to `request_{threaded}_irq`.
+        unsafe { bindings::synchronize_irq(self.irq) };
+    }
+}
+
+impl Drop for RegistrationInner {
+    fn drop(&mut self) {
+        // SAFETY:
+        // - `self.irq` is the same as the one passed to `request_{threaded}_irq`.
+        //
+        // -  `cookie` was passed to `request_{threaded}_irq` as the cookie. It
+        // is guaranteed to be unique by the type system, since each call to
+        // `register` will return a different instance of `Registration`.
+        //
+        // - `&self` is `!Unpin` and was initializing using pin-init, so it
+        // occupied the same memory location for the entirety of its lifetime.
+        //
+        // Notice that this will block until all handlers finish executing,
+        // i.e.: at no point will &self be invalid while the handler is running.
+        unsafe { bindings::free_irq(self.irq, self.cookie) };
+    }
+}
+
+/// A registration of an IRQ handler for a given IRQ line.
+///
+/// # Examples
+///
+/// The following is an example of using `Registration`. It uses a
+/// [`AtomicU32`](core::sync::AtomicU32) to provide the interior mutability.
+///
+/// ```
+/// use core::sync::atomic::AtomicU32;
+/// use core::sync::atomic::Ordering;
+///
+/// use kernel::prelude::*;
+/// use kernel::device::Bound;
+/// use kernel::irq::flags;
+/// use kernel::irq::Registration;
+/// use kernel::irq::IrqReturn;
+/// use kernel::platform;
+/// use kernel::sync::Arc;
+/// use kernel::c_str;
+/// use kernel::alloc::flags::GFP_KERNEL;
+///
+/// // Declare a struct that will be passed in when the interrupt fires. The u32
+/// // merely serves as an example of some internal data.
+/// struct Data(AtomicU32);
+///
+/// // [`handle_irq`] takes &self. This example illustrates interior
+/// // mutability can be used when share the data between process context and IRQ
+/// // context.
+///
+/// type Handler = Data;
+///
+/// impl kernel::irq::request::Handler for Handler {
+///     // This is executing in IRQ context in some CPU. Other CPUs can still
+///     // try to access to data.
+///     fn handle_irq(&self) -> IrqReturn {
+///         self.0.fetch_add(1, Ordering::Relaxed);
+///
+///         IrqReturn::Handled
+///     }
+/// }
+///
+/// // This is running in process context.
+/// fn register_irq(handler: Handler, dev: &platform::Device<Bound>) -> Result<Arc<Registration<Handler>>> {
+///     let registration = dev.irq_by_index(0, flags::SHARED, c_str!("my-device"), handler)?;
+///
+///     // You can have as many references to the registration as you want, so
+///     // multiple parts of the driver can access it.
+///     let registration = Arc::pin_init(registration, GFP_KERNEL)?;
+///
+///     // The handler may be called immediately after the function above
+///     // returns, possibly in a different CPU.
+///
+///     {
+///         // The data can be accessed from the process context too.
+///         registration.handler().0.fetch_add(1, Ordering::Relaxed);
+///     }
+///
+///     Ok(registration)
+/// }
+///
+/// # Ok::<(), Error>(())
+///```
+///
+/// # Invariants
+///
+/// * We own an irq handler using `&self` as its private data.
+///
+#[pin_data]
+pub struct Registration<T: Handler + 'static> {
+    inner: Devres<RegistrationInner>,
+
+    #[pin]
+    handler: T,
+
+    /// Pinned because we need address stability so that we can pass a pointer
+    /// to the callback.
+    #[pin]
+    _pin: PhantomPinned,
+}
+
+impl<T: Handler + 'static> Registration<T> {
+    /// Registers the IRQ handler with the system for the given IRQ number.
+    pub(crate) fn register<'a>(
+        dev: &'a Device<Bound>,
+        irq: u32,
+        flags: Flags,
+        name: &'static CStr,
+        handler: T,
+    ) -> impl PinInit<Self, Error> + 'a {
+        let closure = move |slot: *mut Self| {
+            // SAFETY: The slot passed to pin initializer is valid for writing.
+            unsafe {
+                slot.write(Self {
+                    inner: Devres::new(
+                        dev,
+                        RegistrationInner {
+                            irq,
+                            cookie: slot.cast(),
+                        },
+                        GFP_KERNEL,
+                    )?,
+                    handler,
+                    _pin: PhantomPinned,
+                })
+            };
+
+            // SAFETY:
+            // - The callbacks are valid for use with request_irq.
+            // - If this succeeds, the slot is guaranteed to be valid until the
+            // destructor of Self runs, which will deregister the callbacks
+            // before the memory location becomes invalid.
+            let res = to_result(unsafe {
+                bindings::request_irq(
+                    irq,
+                    Some(handle_irq_callback::<T>),
+                    flags.into_inner() as usize,
+                    name.as_char_ptr(),
+                    slot.cast(),
+                )
+            });
+
+            if res.is_err() {
+                // SAFETY: We are returning an error, so we can destroy the slot.
+                unsafe { core::ptr::drop_in_place(&raw mut (*slot).handler) };
+            }
+
+            res
+        };
+
+        // SAFETY:
+        // - if this returns Ok, then every field of `slot` is fully
+        // initialized.
+        // - if this returns an error, then the slot does not need to remain
+        // valid.
+        unsafe { pin_init_from_closure(closure) }
+    }
+
+    /// Returns a reference to the handler that was registered with the system.
+    pub fn handler(&self) -> &T {
+        &self.handler
+    }
+
+    /// Wait for pending IRQ handlers on other CPUs.
+    ///
+    /// This will attempt to access the inner [`Devres`] container.
+    pub fn try_synchronize(&self) -> Result {
+        let inner = self.inner.try_access().ok_or(ENODEV)?;
+        inner.synchronize();
+        Ok(())
+    }
+
+    /// Wait for pending IRQ handlers on other CPUs.
+    pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
+        let inner = self.inner.access(dev)?;
+        inner.synchronize();
+        Ok(())
+    }
+}
+
+/// # Safety
+///
+/// This function should be only used as the callback in `request_irq`.
+unsafe extern "C" fn handle_irq_callback<T: Handler>(
+    _irq: i32,
+    ptr: *mut core::ffi::c_void,
+) -> core::ffi::c_uint {
+    // SAFETY: `ptr` is a pointer to Registration<T> set in `Registration::new`
+    let data = unsafe { &*(ptr as *const Registration<T>) };
+    T::handle_irq(&data.handler).into_inner()
+}

-- 
2.49.0


