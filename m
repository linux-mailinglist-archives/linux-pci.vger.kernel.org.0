Return-Path: <linux-pci+bounces-33680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C71B1FD4F
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 02:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C17176930
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 00:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829B21D90A5;
	Mon, 11 Aug 2025 00:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QeiTCi7M"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEF31D63C6;
	Mon, 11 Aug 2025 00:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754872388; cv=none; b=FqWxYzchfMgxlut5N2K0GXJlDs0Ks5bi22PL4crqWEBbH90SOFaGf4lPs6BKSXjNll3Ox54kMfL+BAnoda0eDIOrb44FTdfRWbSCZbMbn0ROgSm0rPz5iNpN5zqclNOehkeAFaFXFXaKVNTPoGpB7+6mNXuOyICBAXSblFWWEEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754872388; c=relaxed/simple;
	bh=DhZBpeijqVSbgQRWIVdUXa56H+OwyXdJgDk31t/Pb7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zh99rQQAkVCzYWrwL2FY2fUAIA21HpVdCZqxaxXoAF6shqb1piRhbVgPJgUqpjno3u/kffHPSRCmURjhfYoOsSE0wIvKRfEdkuXmECovUGFOFG4QX5NdxK98gcl+0ZfIR3NrjNXRbZMvVWGJuOWFhMQRJ8cuEe3YY3gN2tragqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QeiTCi7M; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754872384;
	bh=DhZBpeijqVSbgQRWIVdUXa56H+OwyXdJgDk31t/Pb7Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QeiTCi7MdfKD8pFTooBE3MlDA2YVizh765x10ei72VdXcnMqH5XYMO1xuiCkm9I3w
	 xjnj0E5s6bGdmntkfcK2CuYCr30ceQnnZLr6ynZsLvmW+PzyDSBWb8tghiJ1RnSxfX
	 miTvACQD+6eeIX66XJ3E5T+04WAqrmc/HG0yFUZujozQjXcRfI6p92sDuyIBoAtV7q
	 uLswGcAzBqbOkxVWB66GSYCifH5TX3jxYOUaLu3ZK0DNmv6+VE7eb/qVAosUmDwIkx
	 3UDjU5KD0FKc3AM5zSD5c83UJYaU/nNCcLjiDXh4Rx+IkfbN/1vLB+BYl/kwRWjIUO
	 PdF/9q6ckLR7g==
Received: from [192.168.0.23] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BDD6217E0299;
	Mon, 11 Aug 2025 02:32:59 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Sun, 10 Aug 2025 21:32:17 -0300
Subject: [PATCH v8 4/6] rust: irq: add support for threaded IRQs and
 handlers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-topics-tyr-request_irq2-v8-4-8163f4c4c3a6@collabora.com>
References: <20250810-topics-tyr-request_irq2-v8-0-8163f4c4c3a6@collabora.com>
In-Reply-To: <20250810-topics-tyr-request_irq2-v8-0-8163f4c4c3a6@collabora.com>
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
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/irq.rs         |   5 +-
 rust/kernel/irq/request.rs | 227 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 229 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
index f7d89a46ad1894dda5a0a0f53683ff97f2359a4e..20216fe1765d07bc3651ade9b93ff60ca94d8d86 100644
--- a/rust/kernel/irq.rs
+++ b/rust/kernel/irq.rs
@@ -20,4 +20,7 @@
 pub use flags::Flags;
 
 #[doc(inline)]
-pub use request::{Handler, IrqRequest, IrqReturn, Registration};
+pub use request::{
+    Handler, IrqRequest, IrqReturn, Registration, ThreadedHandler, ThreadedIrqReturn,
+    ThreadedRegistration,
+};
diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
index 9ec9cc42e4c7380c081e129f90a040ed62157cb8..29597573e91106d0990ec096a8e7f93ef2f89f2b 100644
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
 
@@ -261,3 +262,225 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
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
+/// # use kernel::c_str;
+/// # use kernel::device::Bound;
+/// # use kernel::irq::{
+/// #   self, Flags, IrqRequest, IrqReturn, ThreadedHandler, ThreadedIrqReturn,
+/// #   ThreadedRegistration,
+/// # };
+/// # use kernel::prelude::*;
+/// # use kernel::sync::{Arc, Mutex};
+/// // Declare a struct that will be passed in when the interrupt fires. The u32
+/// // merely serves as an example of some internal data.
+/// //
+/// // [`irq::ThreadedHandler::handle`] takes `&self`. This example
+/// // illustrates how interior mutability can be used when sharing the data
+/// // between process context and IRQ context.
+/// struct Data {
+///     value: Mutex<u32>,
+/// }
+///
+/// type Handler = Data;
+///
+/// impl ThreadedHandler for Handler {
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
+///     handler: impl PinInit<Handler, Error>,
+///     request: IrqRequest<'_>,
+/// ) -> Result<Arc<ThreadedRegistration<Handler>>> {
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


