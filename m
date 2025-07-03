Return-Path: <linux-pci+bounces-31453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 498F2AF8168
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 21:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83CA37AD7D3
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 19:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844162FF475;
	Thu,  3 Jul 2025 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="QYWQlwd3"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5569E2FEE34;
	Thu,  3 Jul 2025 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751571084; cv=pass; b=AzkkFmqZJR6WPGV0OIIhLYpNFGjTdqNrRYwmY6sfkIY2ejZy2smtkUIyMcjo8XOVTliia+0GV8A1EQTYsOxXESObl52U+WWEr+Ocv2D3g4yPPx/YEt34M5HakcXm4WNc9JCEBnXwjtV+VXD4QLT8gQ1UxBd8zwO9krVAJq95/wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751571084; c=relaxed/simple;
	bh=R141UbZ2MJ+Lmd8p/5NuzNewQfpmG80jwub4dwATn98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fjb/o7VTC2YVoDF0ZmqxVp1emzUG4eN02uub/OWNT366DMw9WSCPS/dJrF58U4DDIt/+/9uFgV2oVdYTXihxteIPDFAKCInhO2mC87GoDafBUuNhWWPcMWSh/wTvryvH6Z7wa5QnOKlDNsxwBSnn9pXZxyleU8G7jXMyjSjZUw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=QYWQlwd3; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751571054; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=V9g3C6c2BG7NoM1zqAQBgI43XlPCDTsXEch5jwn2/F5ue99WSBer+npmmEFKDEvp9+5ivG9xREO2J0r0ExNU3Rcy1z/l/Z5AKLVIiG9jAIH4ndEz52/08AYStuzcvc1UA3dbk82JWYrjNnGaWzN889fi+UDGaHsuUXMgqbtpPTs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751571054; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7tzGk2bWskELc3lBl6isyxFZIxOYyDuIcmJBxgT3gsA=; 
	b=mJzvDbVhT8NAf0uOdNPEisfKUbgFqvWU9jx3d/EWYbrGQ4nzUQtU3bYc0/gY0Eqs7I6ZzZ08MBS/TpCmgJiVEW0w0agVxVJHLdLDVnP/IN+IngYXMhtBMGMFPZBubbc/4+ZRqQSjMFta8raSkrgpVKIRQQ3xpLkX0ubxxxqsF9M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751571054;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=7tzGk2bWskELc3lBl6isyxFZIxOYyDuIcmJBxgT3gsA=;
	b=QYWQlwd3qHW730BCZQ8kv224QN8W8Yj5axCCS7CSCqSZmQuEn6ZcD0vPfFfePIDL
	76nyEj83m+bgB1cq/ctewk9qerarfsFy3ET8nB4d2l9Ud4tLdy2ZKnfxSixEreruA+s
	25M2nhWTZsZOJDoOjWcMH0puFX5qhVq4erv/k7Eg=
Received: by mx.zohomail.com with SMTPS id 17515710517921006.8159695544626;
	Thu, 3 Jul 2025 12:30:51 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 03 Jul 2025 16:30:01 -0300
Subject: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
In-Reply-To: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
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

Registering an irq is dependent upon having a IrqRequest that was
previously allocated by a given device. This will be introduced in
subsequent patches.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/irq.c              |   9 ++
 rust/kernel/irq.rs              |   5 +
 rust/kernel/irq/request.rs      | 273 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 289 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 8cbb660e2ec218021d16e6e0144acf6f4d7cca13..da0bd23fad59a2373bd873d12ad69c55208aaa38 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -51,6 +51,7 @@
 #include <linux/ethtool.h>
 #include <linux/file.h>
 #include <linux/firmware.h>
+#include <linux/interrupt.h>
 #include <linux/fs.h>
 #include <linux/jiffies.h>
 #include <linux/jump_label.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 393ad201befb80a9ae39866a725744ab88620fbb..e3579fc7e1cfc30c913207a4a78b790259d7ae7a 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -22,6 +22,7 @@
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
index 9abd9a6dc36f3e3ecc1f92ad7b0040176b56a079..01bd08884b72c2a3a9460897bce751c732a19794 100644
--- a/rust/kernel/irq.rs
+++ b/rust/kernel/irq.rs
@@ -12,3 +12,8 @@
 
 /// Flags to be used when registering IRQ handlers.
 pub mod flags;
+
+/// IRQ allocation and handling.
+pub mod request;
+
+pub use request::{Handler, IrqRequest, IrqReturn, Registration};
diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
new file mode 100644
index 0000000000000000000000000000000000000000..4f4beaa3c7887660440b9ddc52414020a0d165ac
--- /dev/null
+++ b/rust/kernel/irq/request.rs
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright 2025 Collabora ltd.
+
+//! This module provides types like [`Registration`] which allow users to
+//! register handlers for a given IRQ line.
+
+use core::marker::PhantomPinned;
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
+    /// The hard IRQ handler.
+    ///
+    /// This is executed in interrupt context, hence all corresponding
+    /// limitations do apply.
+    ///
+    /// All work that does not necessarily need to be executed from
+    /// interrupt context, should be deferred to a threaded handler.
+    /// See also [`ThreadedRegistration`].
+    fn handle(&self) -> IrqReturn;
+}
+
+impl<T: ?Sized + Handler + Send> Handler for Arc<T> {
+    fn handle(&self) -> IrqReturn {
+        T::handle(self)
+    }
+}
+
+impl<T: ?Sized + Handler, A: Allocator> Handler for Box<T, A> {
+    fn handle(&self) -> IrqReturn {
+        T::handle(self)
+    }
+}
+
+/// # Invariants
+///
+/// - `self.irq` is the same as the one passed to `request_{threaded}_irq`.
+/// - `cookie` was passed to `request_{threaded}_irq` as the cookie. It
+/// is guaranteed to be unique by the type system, since each call to
+/// `new` will return a different instance of `Registration`.
+#[pin_data(PinnedDrop)]
+struct RegistrationInner {
+    irq: u32,
+    cookie: *mut kernel::ffi::c_void,
+}
+
+impl RegistrationInner {
+    fn synchronize(&self) {
+        // SAFETY: safe as per the invariants of `RegistrationInner`
+        unsafe { bindings::synchronize_irq(self.irq) };
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for RegistrationInner {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY:
+        //
+        // Safe as per the invariants of `RegistrationInner` and:
+        //
+        // - The containing struct is `!Unpin` and was initialized using
+        // pin-init, so it occupied the same memory location for the entirety of
+        // its lifetime.
+        //
+        // Notice that this will block until all handlers finish executing,
+        // i.e.: at no point will &self be invalid while the handler is running.
+        unsafe { bindings::free_irq(self.irq, self.cookie) };
+    }
+}
+
+// SAFETY: We only use `inner` on drop, which called at most once with no
+// concurrent access.
+unsafe impl Sync for RegistrationInner {}
+
+// SAFETY: It is safe to send `RegistrationInner` across threads.
+unsafe impl Send for RegistrationInner {}
+
+/// A request for an IRQ line for a given device.
+///
+/// # Invariants
+///
+/// - `ìrq` is the number of an interrupt source of `dev`.
+/// - `irq` has not been registered yet.
+pub struct IrqRequest<'a> {
+    dev: &'a Device<Bound>,
+    irq: u32,
+}
+
+impl<'a> IrqRequest<'a> {
+    /// Creates a new IRQ request for the given device and IRQ number.
+    ///
+    /// # Safety
+    ///
+    /// - `irq` should be a valid IRQ number for `dev`.
+    pub(crate) unsafe fn new(dev: &'a Device<Bound>, irq: u32) -> Self {
+        IrqRequest { dev, irq }
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
+/// use kernel::irq::IrqRequest;
+/// use kernel::irq::IrqReturn;
+/// use kernel::sync::Arc;
+/// use kernel::c_str;
+/// use kernel::alloc::flags::GFP_KERNEL;
+///
+/// // Declare a struct that will be passed in when the interrupt fires. The u32
+/// // merely serves as an example of some internal data.
+/// struct Data(AtomicU32);
+///
+/// // [`kernel::irq::request::Handler::handle`] takes `&self`. This example
+/// // illustrates how interior mutability can be used when sharing the data
+/// // between process context and IRQ context.
+///
+/// type Handler = Data;
+///
+/// impl kernel::irq::request::Handler for Handler {
+///     // This is executing in IRQ context in some CPU. Other CPUs can still
+///     // try to access to data.
+///     fn handle(&self) -> IrqReturn {
+///         self.0.fetch_add(1, Ordering::Relaxed);
+///
+///         IrqReturn::Handled
+///     }
+/// }
+///
+/// // Registers an IRQ handler for the given IrqRequest.
+/// //
+/// // This is executing in process context and assumes that `request` was
+/// // previously acquired from a device.
+/// fn register_irq(handler: Handler, request: IrqRequest<'_>) -> Result<Arc<Registration<Handler>>> {
+///     let registration = Registration::new(request, flags::SHARED, c_str!("my_device"), handler);
+///
+///     let registration = Arc::pin_init(registration, GFP_KERNEL)?;
+///
+///     // The data can be accessed from process context too.
+///     registration.handler().0.fetch_add(1, Ordering::Relaxed);
+///
+///     Ok(registration)
+/// }
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// # Invariants
+///
+/// * We own an irq handler using `&self.handler` as its private data.
+///
+#[pin_data]
+pub struct Registration<T: Handler + 'static> {
+    #[pin]
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
+    pub fn new<'a>(
+        request: IrqRequest<'a>,
+        flags: Flags,
+        name: &'static CStr,
+        handler: T,
+    ) -> impl PinInit<Self, Error> + 'a {
+        try_pin_init!(&this in Self {
+            handler,
+            inner <- Devres::new(
+                request.dev,
+                try_pin_init!(RegistrationInner {
+                    // SAFETY: `this` is a valid pointer to the `Registration` instance
+                    cookie: unsafe { &raw mut (*this.as_ptr()).handler }.cast(),
+                    irq: {
+                        // SAFETY:
+                        // - The callbacks are valid for use with request_irq.
+                        // - If this succeeds, the slot is guaranteed to be valid until the
+                        // destructor of Self runs, which will deregister the callbacks
+                        // before the memory location becomes invalid.
+                        to_result(unsafe {
+                            bindings::request_irq(
+                                request.irq,
+                                Some(handle_irq_callback::<T>),
+                                flags.into_inner() as usize,
+                                name.as_char_ptr(),
+                                (&raw mut (*this.as_ptr()).handler).cast(),
+                            )
+                        })?;
+                        request.irq
+                    }
+                })
+            ),
+            _pin: PhantomPinned,
+        })
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
+    // SAFETY: `ptr` is a pointer to T set in `Registration::new`
+    let handler = unsafe { &*(ptr as *const T) };
+    T::handle(handler).into_inner()
+}

-- 
2.50.0


