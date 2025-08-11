Return-Path: <linux-pci+bounces-33760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A7AB21171
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 18:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F5B66E1054
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD04A2E62C0;
	Mon, 11 Aug 2025 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OrhBvzmD"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9136D2E339E;
	Mon, 11 Aug 2025 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928265; cv=none; b=tp1tHcr5y00gWxC1ZQvJApPq1zrvbx7LOIDt3okOBFoB6NSPNKUH+dGG7tgdG0AFUEMq7OBoj/69g6BBmBOacAQ8PeNyFtISnL0/QFN8Qxdi6SY/+hsGzbk513BRiS6Mki0wY944GzGIMdWzKM9KhzMRaUuTR4U0j4ceBSjFghQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928265; c=relaxed/simple;
	bh=K0EhQkyhLaiw0Vz+iyHgrnyZW7UcIJtsvSPduP62RXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V9l0IdWBSkjwvbSCQCrg6ERfjcRYmJqQrpmQkt67ivmQnO9b7WlaXgpDndzGYGFOvctgVF4nXA2eocw8yr7Hijh2E2rqz5Rz+uihLOfw61AltzS1ginMx45U6XJy/3Jj+ZG2v/Ftxggm+RvPAq7ZHSBvC5CSB5Fr9R6kTwJgpxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OrhBvzmD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754928262;
	bh=K0EhQkyhLaiw0Vz+iyHgrnyZW7UcIJtsvSPduP62RXE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OrhBvzmDHxLkzvEQI9FusK9OPAwh5CVz6MUTr4qpJVP0aOMNV8FNSt8cHdhjhWuu0
	 +hrx9IQmdbkMfqLDQZI1PT1034ggDvQZQ1wIHycOqFF9gb1MT5GZWII7FAkGcKxc3r
	 246z62VpJC0OYjRoXoZWMpzO7tjIb6oKTp8x7L8M+4SSvScoHmhOiz3AoF5yvMmSt3
	 ggtW80VkCMAcrqXssbAwRMq82Nf1n5WhYE9hFv5vrm74iZc2oSX3jbF9ogXftIYp25
	 vyW7ieSBUCN315VoaumdnOif30YNHG7de4znxOSjMLS/X4wD4AIhhb1uU2KzjPBfnv
	 N5uhQsAvTeSng==
Received: from [192.168.0.23] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D535B17E0286;
	Mon, 11 Aug 2025 18:04:17 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Mon, 11 Aug 2025 13:03:42 -0300
Subject: [PATCH v9 4/7] rust: irq: add support for threaded IRQs and
 handlers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-topics-tyr-request_irq2-v9-4-0485dcd9bcbf@collabora.com>
References: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>
In-Reply-To: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-pci@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>, 
 Dirk Behme <dirk.behme@de.bosch.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2

This patch adds support for threaded IRQs and handlers through
irq::ThreadedRegistration and the irq::ThreadedHandler trait.

Threaded interrupts are more permissive in the sense that further
processing is possible in a kthread. This means that said execution takes
place outside of interrupt context, which is rather restrictive in many
ways.

Registering a threaded irq is dependent upon having an IrqRequest that
was previously allocated by a given device. This will be introduced in
subsequent patches.

Tested-by: Joel Fernandes <joelagnelf@nvidia.com>
Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/irq.rs         |   5 +-
 rust/kernel/irq/request.rs | 228 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 230 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
index c1019bc36ad1e7ae7dd3af8a8b5c14780bf70712..20abd40566559652eccd03f77ec873a16b6f48b0 100644
--- a/rust/kernel/irq.rs
+++ b/rust/kernel/irq.rs
@@ -18,4 +18,7 @@
 
 pub use flags::Flags;
 
-pub use request::{Handler, IrqRequest, IrqReturn, Registration};
+pub use request::{
+    Handler, IrqRequest, IrqReturn, Registration, ThreadedHandler, ThreadedIrqReturn,
+    ThreadedRegistration,
+};
diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
index 57e00ebf694d8e6e870d9ed57af7ee2ecf86ec05..4033df7d0dce1dbc9cc9b0b0f32fb9f8aa285d6b 100644
--- a/rust/kernel/irq/request.rs
+++ b/rust/kernel/irq/request.rs
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 // SPDX-FileCopyrightText: Copyright 2025 Collabora ltd.
 
-//! This module provides types like [`Registration`] which allow users to
-//! register handlers for a given IRQ line.
+//! This module provides types like [`Registration`] and
+//! [`ThreadedRegistration`], which allow users to register handlers for a given
+//! IRQ line.
 
 use core::marker::PhantomPinned;
 
@@ -262,3 +263,226 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
     let handler = unsafe { &*(ptr as *const T) };
     T::handle(handler) as c_uint
 }
+
+/// The value that can be returned from [`ThreadedHandler::handle`].
+#[repr(u32)]
+pub enum ThreadedIrqReturn {
+    /// The interrupt was not from this device or was not handled.
+    None = bindings::irqreturn_IRQ_NONE,
+
+    /// The interrupt was handled by this device.
+    Handled = bindings::irqreturn_IRQ_HANDLED,
+
+    /// The handler wants the handler thread to wake up.
+    WakeThread = bindings::irqreturn_IRQ_WAKE_THREAD,
+}
+
+/// Callbacks for a threaded IRQ handler.
+pub trait ThreadedHandler: Sync {
+    /// The hard IRQ handler.
+    ///
+    /// This is executed in interrupt context, hence all corresponding
+    /// limitations do apply. All work that does not necessarily need to be
+    /// executed from interrupt context, should be deferred to the threaded
+    /// handler, i.e. [`ThreadedHandler::handle_threaded`].
+    ///
+    /// The default implementation returns [`ThreadedIrqReturn::WakeThread`].
+    fn handle(&self) -> ThreadedIrqReturn {
+        ThreadedIrqReturn::WakeThread
+    }
+
+    /// The threaded IRQ handler.
+    ///
+    /// This is executed in process context. The kernel creates a dedicated
+    /// `kthread` for this purpose.
+    fn handle_threaded(&self) -> IrqReturn;
+}
+
+impl<T: ?Sized + ThreadedHandler + Send> ThreadedHandler for Arc<T> {
+    fn handle(&self) -> ThreadedIrqReturn {
+        T::handle(self)
+    }
+
+    fn handle_threaded(&self) -> IrqReturn {
+        T::handle_threaded(self)
+    }
+}
+
+impl<T: ?Sized + ThreadedHandler, A: Allocator> ThreadedHandler for Box<T, A> {
+    fn handle(&self) -> ThreadedIrqReturn {
+        T::handle(self)
+    }
+
+    fn handle_threaded(&self) -> IrqReturn {
+        T::handle_threaded(self)
+    }
+}
+
+/// A registration of a threaded IRQ handler for a given IRQ line.
+///
+/// Two callbacks are required: one to handle the IRQ, and one to handle any
+/// other work in a separate thread.
+///
+/// The thread handler is only called if the IRQ handler returns
+/// [`ThreadedIrqReturn::WakeThread`].
+///
+/// # Examples
+///
+/// The following is an example of using [`ThreadedRegistration`]. It uses a
+/// [`Mutex`](kernel::sync::Mutex) to provide interior mutability.
+///
+/// ```
+/// use kernel::c_str;
+/// use kernel::device::Bound;
+/// use kernel::irq::{
+///   self, Flags, IrqRequest, IrqReturn, ThreadedHandler, ThreadedIrqReturn,
+///   ThreadedRegistration,
+/// };
+/// use kernel::prelude::*;
+/// use kernel::sync::{Arc, Mutex};
+///
+/// // Declare a struct that will be passed in when the interrupt fires. The u32
+/// // merely serves as an example of some internal data.
+/// //
+/// // [`irq::ThreadedHandler::handle`] takes `&self`. This example
+/// // illustrates how interior mutability can be used when sharing the data
+/// // between process context and IRQ context.
+/// #[pin_data]
+/// struct Data {
+///     #[pin]
+///     value: Mutex<u32>,
+/// }
+///
+/// impl ThreadedHandler for Data {
+///     // This will run (in a separate kthread) if and only if
+///     // [`ThreadedHandler::handle`] returns [`WakeThread`], which it does by
+///     // default.
+///     fn handle_threaded(&self) -> IrqReturn {
+///         let mut data = self.value.lock();
+///         *data += 1;
+///         IrqReturn::Handled
+///     }
+/// }
+///
+/// // Registers a threaded IRQ handler for the given [`IrqRequest`].
+/// //
+/// // This is executing in process context and assumes that `request` was
+/// // previously acquired from a device.
+/// fn register_threaded_irq(
+///     handler: impl PinInit<Data, Error>,
+///     request: IrqRequest<'_>,
+/// ) -> Result<Arc<ThreadedRegistration<Data>>> {
+///     let registration =
+///         ThreadedRegistration::new(request, Flags::SHARED, c_str!("my_device"), handler);
+///
+///     let registration = Arc::pin_init(registration, GFP_KERNEL)?;
+///
+///     {
+///         // The data can be accessed from process context too.
+///         let mut data = registration.handler().value.lock();
+///         *data += 1;
+///     }
+///
+///     Ok(registration)
+/// }
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// # Invariants
+///
+/// * We own an irq handler using `&T` as its private data.
+#[pin_data]
+pub struct ThreadedRegistration<T: ThreadedHandler + 'static> {
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
+impl<T: ThreadedHandler + 'static> ThreadedRegistration<T> {
+    /// Registers the IRQ handler with the system for the given IRQ number.
+    pub fn new<'a>(
+        request: IrqRequest<'a>,
+        flags: Flags,
+        name: &'static CStr,
+        handler: impl PinInit<T, Error> + 'a,
+    ) -> impl PinInit<Self, Error> + 'a {
+        try_pin_init!(&this in Self {
+            handler <- handler,
+            inner <- Devres::new(
+                request.dev,
+                try_pin_init!(RegistrationInner {
+                    // SAFETY: `this` is a valid pointer to the `ThreadedRegistration` instance.
+                    cookie: unsafe { &raw mut (*this.as_ptr()).handler }.cast(),
+                    irq: {
+                        // SAFETY:
+                        // - The callbacks are valid for use with request_threaded_irq.
+                        // - If this succeeds, the slot is guaranteed to be valid until the
+                        // destructor of Self runs, which will deregister the callbacks
+                        // before the memory location becomes invalid.
+                        to_result(unsafe {
+                            bindings::request_threaded_irq(
+                                request.irq,
+                                Some(handle_threaded_irq_callback::<T>),
+                                Some(thread_fn_callback::<T>),
+                                flags.into_inner(),
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
+/// This function should be only used as the callback in `request_threaded_irq`.
+unsafe extern "C" fn handle_threaded_irq_callback<T: ThreadedHandler>(
+    _irq: i32,
+    ptr: *mut c_void,
+) -> c_uint {
+    // SAFETY: `ptr` is a pointer to T set in `ThreadedRegistration::new`
+    let handler = unsafe { &*(ptr as *const T) };
+    T::handle(handler) as c_uint
+}
+
+/// # Safety
+///
+/// This function should be only used as the callback in `request_threaded_irq`.
+unsafe extern "C" fn thread_fn_callback<T: ThreadedHandler>(_irq: i32, ptr: *mut c_void) -> c_uint {
+    // SAFETY: `ptr` is a pointer to T set in `ThreadedRegistration::new`
+    let handler = unsafe { &*(ptr as *const T) };
+    T::handle_threaded(handler) as c_uint
+}

-- 
2.50.1


