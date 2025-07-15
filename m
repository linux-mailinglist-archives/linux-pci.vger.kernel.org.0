Return-Path: <linux-pci+bounces-32170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7001FB062B4
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 17:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14D53A7261
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 15:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA642528F3;
	Tue, 15 Jul 2025 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZqyKb15J"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE12224E019;
	Tue, 15 Jul 2025 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592632; cv=none; b=G+PjovYtnDwx/ZWTuSASVOxZi7hhiixF/Z1s0KV+guaXMfj1K8EJ0HWJFmxhuKYvtPkecRXMJ515iZMiw1UlgND14tLniywicrs40oCgs0IZbcnTQypA6AUU2MUQvCoCE7VL0jXgoXCgz0XiMRwv0Jr2bU1HkIGmXGdOhYRZamg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592632; c=relaxed/simple;
	bh=GaqTGAvm/SZ/WWXgNLPIL8I1p20P80a2MfUJbHC9h3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BNX5mY1rGPjstrr0kD7mZ9zUi3E2CRtpGYZ+OB+KAI2XQM4ZE8aiCfAExRSqO2VECaNNYXFpnwq9IiMevX8y6cV4EODRZmPdepcHKGa7iPuvlSl/uSauEHQsRw3AiBY1rBUJ3rmLKV0jUxDtOXcNrdLIFP5hoSz2384vJ7TcZEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZqyKb15J; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752592629;
	bh=GaqTGAvm/SZ/WWXgNLPIL8I1p20P80a2MfUJbHC9h3k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZqyKb15JfttsACE4yi6CDpPWljpdwgd4XnV/UnUFWiAqScpDByQHg0ZGvImkI0uUS
	 jmcPYnzXqYg/y9Gn8ZEy0wQCB+X8K3PLNO8w2zM4qX57qzpgoMK0QJDZZUSc/Ej8YI
	 nIXifLOnpUGOnp2yBeIa4hqXvXLkHKf8+sl0pbe4OzmLqbQh37uktloSh5EdeWOgY6
	 TB3m+4E6ZPHNZmsivu7x4WDEozf/I2tMmuGG8Hnt1fItvlDXKlWMJj0CtCr9FqYoXn
	 NUKUFWgm0X8B1gypZd7TebG4AAtEizPCiw3TJbgv8cmXAckxzEQfNwJLOiyJs0cp9+
	 4SSVvxpiIDV2g==
Received: from [192.168.0.2] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 40DCF17E1293;
	Tue, 15 Jul 2025 17:17:06 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Tue, 15 Jul 2025 12:16:41 -0300
Subject: [PATCH v7 4/6] rust: irq: add support for threaded IRQs and
 handlers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-topics-tyr-request_irq2-v7-4-d469c0f37c07@collabora.com>
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
In-Reply-To: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
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
 linux-pci@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>
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

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/irq.rs         |   5 +-
 rust/kernel/irq/request.rs | 227 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 229 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
index 01bd08884b72c2a3a9460897bce751c732a19794..aaa40001bafca617c588c799bb41144921595cae 100644
--- a/rust/kernel/irq.rs
+++ b/rust/kernel/irq.rs
@@ -16,4 +16,7 @@
 /// IRQ allocation and handling.
 pub mod request;
 
-pub use request::{Handler, IrqRequest, IrqReturn, Registration};
+pub use request::{
+    Handler, IrqRequest, IrqReturn, Registration, ThreadedHandler, ThreadedIrqReturn,
+    ThreadedRegistration,
+};
diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
index 2f4637d8bc4c9fda23cbc8307687035957b0042a..aa1b957fa18f927df2f14b18076393e1be2cf1d6 100644
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
 
@@ -265,3 +266,225 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
     let handler = unsafe { &*(ptr as *const T) };
     T::handle(handler) as c_uint
 }
+
+/// The value that can be returned from `ThreadedHandler::handle_irq`.
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
+    fn handle(&self) -> ThreadedIrqReturn;
+
+    /// The threaded IRQ handler.
+    ///
+    /// This is executed in process context. The kernel creates a dedicated
+    /// kthread for this purpose.
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
+/// The thread handler is only called if the IRQ handler returns `WakeThread`.
+///
+/// # Examples
+///
+/// The following is an example of using `ThreadedRegistration`. It uses a
+/// [`AtomicU32`](core::sync::AtomicU32) to provide the interior mutability.
+///
+/// ```
+/// use core::sync::atomic::AtomicU32;
+/// use core::sync::atomic::Ordering;
+///
+/// use kernel::prelude::*;
+/// use kernel::device::Bound;
+/// use kernel::irq::flags;
+/// use kernel::irq::ThreadedIrqReturn;
+/// use kernel::irq::ThreadedRegistration;
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
+/// // [`kernel::irq::request::ThreadedHandler::handle`] takes `&self`. This example
+/// // illustrates how interior mutability can be used when sharing the data
+/// // between process context and IRQ context.
+/// type Handler = Data;
+///
+/// impl kernel::irq::request::ThreadedHandler for Handler {
+///     // This is executing in IRQ context in some CPU. Other CPUs can still
+///     // try to access the data.
+///     fn handle(&self) -> ThreadedIrqReturn {
+///         self.0.fetch_add(1, Ordering::Relaxed);
+///         // By returning `WakeThread`, we indicate to the system that the
+///         // thread function should be called. Otherwise, return
+///         // ThreadedIrqReturn::Handled.
+///         ThreadedIrqReturn::WakeThread
+///     }
+///
+///     // This will run (in a separate kthread) if and only if `handle`
+///     // returns `WakeThread`.
+///     fn handle_threaded(&self) -> IrqReturn {
+///         self.0.fetch_add(1, Ordering::Relaxed);
+///         IrqReturn::Handled
+///     }
+/// }
+///
+/// // Registers a threaded IRQ handler for the given IrqRequest.
+/// //
+/// // This is executing in process context and assumes that `request` was
+/// // previously acquired from a device.
+/// fn register_threaded_irq(handler: Handler, request: IrqRequest<'_>) -> Result<Arc<ThreadedRegistration<Handler>>> {
+///     let registration = ThreadedRegistration::new(request, flags::SHARED, c_str!("my_device"), handler);
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
+/// * We own an irq handler using `&T` as its private data.
+///
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
+        handler: T,
+    ) -> impl PinInit<Self, Error> + 'a {
+        try_pin_init!(&this in Self {
+            handler,
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
2.50.0


