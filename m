Return-Path: <linux-pci+bounces-31451-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A146AF8167
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 21:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684D8483BAA
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 19:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0512FE30B;
	Thu,  3 Jul 2025 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="HPEmjJyY"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB63A2E6D1A;
	Thu,  3 Jul 2025 19:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751571079; cv=pass; b=TBxfDWMZSFBU8u10+PJrKnyiIq6stvHgn2y/lkmKi8Z3CMPFZLZ0fq7YjbCxQugycatue19PSHvwE5bQr3qvqePYgTwVYuAcczqrun7jZF6dMXb1d7ktoHTI7AezyXU+BqBxcQosjh5LaJE3ugvPPcVbpuRCE4fHOOUIC0Lf4qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751571079; c=relaxed/simple;
	bh=eOG5pQABl4JYkNqWR/rxul6Cu7pK4+O9VAC3fnHhKUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WB92Rr0AILBD4JgMMt1jOaSXuq5L/GCmB34F3w30kGzBZBVzquHX7i9Th6cK0cy0RATHBV/qNxM37vcvuzcpqQMcKzMAq3qOlGai01TUn1JO4ugy1hc+lW/yQLUO9cEKJ+9hk5j4kJQ9ucbyK0CtcAQsJhJO1/pFM1LLvC1fU9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=HPEmjJyY; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751571058; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hrnC1gji5Fpk8HCSv9DKuJt0Nc1nnDGCx1EwCjW0Erwdh6e+FyburzGQJYKMMeipCcLkIQc/NOqrt2cObyeN4rPOi2tlsfo3k91bkYxBSLWA9FXvdItecBTLriUyNhMdOYv/ESfldfNnwjGHxjtHypsBbnKd6/KGaAJ0h1RktyA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751571058; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=osUfrQWHNPE7M9En9unBFOgkYLz7UPzVl5xTOtphdyI=; 
	b=nLgQStmC0oF3pthS5u2r5AFk6MOjnxmaOI8osVISkkC/EKRI98BOG/wPgHXB9NYgGZo2WGYCoI1uDKXv+X6VawPqWbtO3IxU8GRl6Xsg2wW69w0/QqseB0jJm6+txJrddmM/DqOvfjE2slH55ocpUTN23+f6z3PI+ZyHj7TcxHo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751571058;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=osUfrQWHNPE7M9En9unBFOgkYLz7UPzVl5xTOtphdyI=;
	b=HPEmjJyYm2hteCtqdMp+VdLoQTEd5Whwjpr33yBA+KCZAwYyt/KS3V9Sh8mWEsKT
	QJqe1ABb8y6nsoGg6AiTxH5fhK8//Ym3TtwNhzgm2JN/bnr6CvUhekH3yGhqU14amAF
	ovEvcvMJJLOrIgWcd57CPuMDzTKBf3N9tEJodVIo=
Received: by mx.zohomail.com with SMTPS id 1751571056420222.88377847435845;
	Thu, 3 Jul 2025 12:30:56 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 03 Jul 2025 16:30:02 -0300
Subject: [PATCH v6 4/6] rust: irq: add support for threaded IRQs and
 handlers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-topics-tyr-request_irq-v6-4-74103bdc7c52@collabora.com>
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
 rust/kernel/irq/request.rs | 239 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 241 insertions(+), 3 deletions(-)

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
index 4f4beaa3c7887660440b9ddc52414020a0d165ac..bd489b8d23868a3b315a4f212f94a31870c9f02e 100644
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
 
@@ -271,3 +272,237 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
     let handler = unsafe { &*(ptr as *const T) };
     T::handle(handler).into_inner()
 }
+
+/// The value that can be returned from `ThreadedHandler::handle_irq`.
+pub enum ThreadedIrqReturn {
+    /// The interrupt was not from this device or was not handled.
+    None,
+
+    /// The interrupt was handled by this device.
+    Handled,
+
+    /// The handler wants the handler thread to wake up.
+    WakeThread,
+}
+
+impl ThreadedIrqReturn {
+    fn into_inner(self) -> u32 {
+        match self {
+            ThreadedIrqReturn::None => bindings::irqreturn_IRQ_NONE,
+            ThreadedIrqReturn::Handled => bindings::irqreturn_IRQ_HANDLED,
+            ThreadedIrqReturn::WakeThread => bindings::irqreturn_IRQ_WAKE_THREAD,
+        }
+    }
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
+    ptr: *mut core::ffi::c_void,
+) -> core::ffi::c_uint {
+    // SAFETY: `ptr` is a pointer to T set in `ThreadedRegistration::new`
+    let handler = unsafe { &*(ptr as *const T) };
+    T::handle(handler).into_inner()
+}
+
+/// # Safety
+///
+/// This function should be only used as the callback in `request_threaded_irq`.
+unsafe extern "C" fn thread_fn_callback<T: ThreadedHandler>(
+    _irq: i32,
+    ptr: *mut core::ffi::c_void,
+) -> core::ffi::c_uint {
+    // SAFETY: `ptr` is a pointer to T set in `ThreadedRegistration::new`
+    let handler = unsafe { &*(ptr as *const T) };
+    T::handle_threaded(handler).into_inner()
+}

-- 
2.50.0


