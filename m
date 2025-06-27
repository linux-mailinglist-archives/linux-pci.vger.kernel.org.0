Return-Path: <linux-pci+bounces-30944-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E48AEBD1D
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 18:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73C471C48A32
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 16:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38962EAD1C;
	Fri, 27 Jun 2025 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="c287lIHo"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB042EAB89;
	Fri, 27 Jun 2025 16:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041337; cv=pass; b=EMKuQ3+PJ3A7cOnDvK8qpx5fJU6fNh5W//8KZGkDnT2caxAWHuLy9CLVLY5oWBNrlR12FE5S5dbAoxt6jwEElU0mCJVZGNAV2YORf5k7JN4V2fjUSlg1jiYdgTZ5nwKnzwi/EklAZK/ePJgO+aKl+TaxDTKB50nBIJu6TZtze0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041337; c=relaxed/simple;
	bh=XT90ZCY0cK5tLKrcs0GiMqpMHSQGHn1rqMeStYSPh6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k/Hnm6bT9CvIsHJemzYrrQyPsX2wxdH1Ub7Pyjbz0Oa/sF4/VUI29nZdPEOHtucaQlR1j0f4KsvGpFQ4FEdwvaBWcG9x+Zg+veIG+rH+cJp/HFE7owad/j0wzn9fcjAhV5WxwlnAoPa0xzvVdhujB4dUcq7D78MapXEWQ8mu5Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=c287lIHo; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751041310; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Z9Wv5zMPDNo6zREsYBq4Sf2bercy2eU7yB5E6WKq74Eff+87ISfCMMltpOdkhe5Gcbxc0hxzo/aa+oEXU9SqIvUeWwsjKnFjUGXd1cWoCHQ3dYFt/g6Zs1euILdI9W93vXUIzgcbPwdwf1J3+8pmJH72o71+ZNRAD8ZAd41UQN8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751041310; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SHEK1SG4xOfkLhryYT/WkgHuKX/Wf2xzFHRxYOq/ics=; 
	b=XI12ERhW0FFKLLk1plY0PZF2n0KPMcAmneJnczCTzfv/4ToG9c+b27LImMDBQ8Zt5ajqR4bdztfwFKq5R7mtVkt8Ppm1N5KUhWuY6JPcmcfoPMOr5ib7tvOaAWGyqZNopXJOFRi1lXjtVPT8EM+jr1mLCPxVAOE7zRVSu6v3TM8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751041309;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=SHEK1SG4xOfkLhryYT/WkgHuKX/Wf2xzFHRxYOq/ics=;
	b=c287lIHogLCeQojPJ7JN+BJyIUCSyz2hlwwTEYH6w72FdfqpYaBD3p55t+8vvYZR
	fOypzL/pYOhbklf9UXtV9/OfFDHNccuAi+3a5HlKjyb+cwLhB3eCEaCb+v4bS/0aJDW
	HJ0SflMT1zlipWj3mx/xHpOzr5eFWPi2aZsA+WEM=
Received: by mx.zohomail.com with SMTPS id 1751041306382261.8961078567744;
	Fri, 27 Jun 2025 09:21:46 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Fri, 27 Jun 2025 13:21:06 -0300
Subject: [PATCH v5 4/6] rust: irq: add support for threaded IRQs and
 handlers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-topics-tyr-request_irq-v5-4-0545ee4dadf6@collabora.com>
References: <20250627-topics-tyr-request_irq-v5-0-0545ee4dadf6@collabora.com>
In-Reply-To: <20250627-topics-tyr-request_irq-v5-0-0545ee4dadf6@collabora.com>
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
 rust/kernel/irq/request.rs | 233 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 235 insertions(+), 3 deletions(-)

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
index 980803b54fcc482b7a42dfa30cde23ed57a0bbec..7a6e3e7ac2045d6a33f81472c02ee2c81372dec8 100644
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
 
@@ -265,3 +266,231 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
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
+    /// The actual handler function. As usual, sleeps are not allowed in IRQ
+    /// context.
+    fn handle(&self) -> ThreadedIrqReturn;
+
+    /// The threaded handler function. This function is called from the irq
+    /// handler thread, which is automatically created by the system.
+    fn handle_on_thread(&self) -> IrqReturn;
+}
+
+impl<T: ?Sized + ThreadedHandler + Send> ThreadedHandler for Arc<T> {
+    fn handle(&self) -> ThreadedIrqReturn {
+        T::handle(self)
+    }
+
+    fn handle_on_thread(&self) -> IrqReturn {
+        T::handle_on_thread(self)
+    }
+}
+
+impl<T: ?Sized + ThreadedHandler, A: Allocator> ThreadedHandler for Box<T, A> {
+    fn handle(&self) -> ThreadedIrqReturn {
+        T::handle(self)
+    }
+
+    fn handle_on_thread(&self) -> IrqReturn {
+        T::handle_on_thread(self)
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
+///     fn handle_on_thread(&self) -> IrqReturn {
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
+    T::handle_on_thread(handler).into_inner()
+}

-- 
2.50.0


