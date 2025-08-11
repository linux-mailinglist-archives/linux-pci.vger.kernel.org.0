Return-Path: <linux-pci+bounces-33679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B6BB1FD4D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 02:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 243A83B9CBF
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 00:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB7313B58D;
	Mon, 11 Aug 2025 00:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hQwH7qlA"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027711C3C14;
	Mon, 11 Aug 2025 00:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754872383; cv=none; b=rngkP0nF4bVVq0N+/kzawIVxBpHbAhvkPPzhtrlAdMN1kFWwazkSkX4XWV9WBCXQwcfonzJGNzYv4Qn0Nt+EfUJbT2rcui8hSR1i4n05iQyLkib3b+ul0siSBuBYcw3nEjwJJOCqLRHs6n0VkwcbCs9nW1Y+MpWDGxIPtp4cxx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754872383; c=relaxed/simple;
	bh=iNK70IM5ihtL5+GBpv8+D+cQ8cvUtT38BXt6l4m90/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YoYUw07xz+qvTfs3HxVYZy/bWv4joqPDIXQvWVRjIkI9zkhJdg8xWfs5qv3XUagLXr892lTT79+49/UK9eZQEVeGNJbNMFTwWqkc/N9gf7I3qAECg2PG+nmq5DEkiLtJm3HYh7otY1C9XJB/CbMosknZnH8YdrEW4iV/Rf2cWYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hQwH7qlA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754872379;
	bh=iNK70IM5ihtL5+GBpv8+D+cQ8cvUtT38BXt6l4m90/E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hQwH7qlAFzKterwpBvPHjn9Eyy+yCOC7Q57JivAYARjYxlmmP1bSfO28OObXz9FVh
	 LYh9IDZHmmYOfwAUzJhWznx453lUgvSWhkfJgJer7BS53Uw7qHVC1gNklDP14HJ+W8
	 eyu39M0fV7xvipggVIEF8lDEnvQ7Xq8mT77xeT6d5e4XLb9ktos+lycwpo3ab7pziK
	 jbG5HPzO4UO8IrIEU5DWfp7TJ6ipt8lrXPOhxonJcvoKVXPyHDJYg8m+FPacGoXnaT
	 3GSy8QM4WHV8dLPQEwKi9cPiK0+L0oqxT331NA72uWLUNC9YjxYFGfWqkyk6oZ4v5m
	 Exo8xlcdjttyQ==
Received: from [192.168.0.23] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 57DBF17E1277;
	Mon, 11 Aug 2025 02:32:54 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Sun, 10 Aug 2025 21:32:16 -0300
Subject: [PATCH v8 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250810-topics-tyr-request_irq2-v8-3-8163f4c4c3a6@collabora.com>
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

This patch adds support for non-threaded IRQs and handlers through
irq::Registration and the irq::Handler trait.

Registering an irq is dependent upon having a IrqRequest that was
previously allocated by a given device. This will be introduced in
subsequent patches.

Tested-by: Joel Fernandes <joelagnelf@nvidia.com>
Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/irq.c              |   9 ++
 rust/kernel/irq.rs              |   6 +
 rust/kernel/irq/request.rs      | 263 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 280 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 84d60635e8a9baef1f1a1b2752dc0fa044f8542f..69a975da829f0c35760f71a1b32b8fcb12c8a8dc 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -52,6 +52,7 @@
 #include <linux/ethtool.h>
 #include <linux/file.h>
 #include <linux/firmware.h>
+#include <linux/interrupt.h>
 #include <linux/fs.h>
 #include <linux/ioport.h>
 #include <linux/jiffies.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 7cf7fe95e41dd51717050648d6160bebebdf4b26..44b2005d50140d34a44ae37d01c2ddbae6aeaa32 100644
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
index d6306415f561f94a05b1c059eaa937b0b585471d..f7d89a46ad1894dda5a0a0f53683ff97f2359a4e 100644
--- a/rust/kernel/irq.rs
+++ b/rust/kernel/irq.rs
@@ -13,5 +13,11 @@
 /// Flags to be used when registering IRQ handlers.
 pub mod flags;
 
+/// IRQ allocation and handling.
+pub mod request;
+
 #[doc(inline)]
 pub use flags::Flags;
+
+#[doc(inline)]
+pub use request::{Handler, IrqRequest, IrqReturn, Registration};
diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
new file mode 100644
index 0000000000000000000000000000000000000000..9ec9cc42e4c7380c081e129f90a040ed62157cb8
--- /dev/null
+++ b/rust/kernel/irq/request.rs
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright 2025 Collabora ltd.
+
+//! This module provides types like [`Registration`] which allow users to
+//! register handlers for a given IRQ line.
+
+use core::marker::PhantomPinned;
+
+use crate::alloc::Allocator;
+use crate::device::{Bound, Device};
+use crate::devres::Devres;
+use crate::error::to_result;
+use crate::irq::flags::Flags;
+use crate::prelude::*;
+use crate::str::CStr;
+use crate::sync::Arc;
+
+/// The value that can be returned from a [`Handler`] or a [`ThreadedHandler`].
+#[repr(u32)]
+pub enum IrqReturn {
+    /// The interrupt was not from this device or was not handled.
+    None = bindings::irqreturn_IRQ_NONE,
+
+    /// The interrupt was handled by this device.
+    Handled = bindings::irqreturn_IRQ_HANDLED,
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
+/// - `cookie` was passed to `request_{threaded}_irq` as the cookie. It is guaranteed to be unique
+///   by the type system, since each call to `new` will return a different instance of
+///   `Registration`.
+#[pin_data(PinnedDrop)]
+struct RegistrationInner {
+    irq: u32,
+    cookie: *mut c_void,
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
+        // INVARIANT: `irq` is a valid IRQ number for `dev`.
+        IrqRequest { dev, irq }
+    }
+
+    /// Returns the IRQ number of an [`IrqRequest`].
+    pub fn irq(&self) -> u32 {
+        self.irq
+    }
+}
+
+/// A registration of an IRQ handler for a given IRQ line.
+///
+/// # Examples
+///
+/// The following is an example of using `Registration`. It uses a
+/// [`Completion`] to coordinate between the IRQ
+/// handler and process context. [`Completion`] uses interior mutability, so the
+/// handler can signal with [`Completion::complete_all()`] and the process
+/// context can wait with [`Completion::wait_for_completion()`] even though
+/// there is no way to get a mutable reference to the any of the fields in
+/// `Data`.
+///
+/// [`Completion`]: kernel::sync::Completion
+/// [`Completion::complete_all()`]: kernel::sync::Completion::complete_all
+/// [`Completion::wait_for_completion()`]: kernel::sync::Completion::wait_for_completion
+///
+/// ```
+/// # use kernel::c_str;
+/// # use kernel::device::Bound;
+/// # use kernel::irq::{self, Flags, IrqRequest, IrqReturn, Registration};
+/// # use kernel::prelude::*;
+/// # use kernel::sync::{Arc, Completion};
+/// // Data shared between process and IRQ context.
+/// struct Data {
+///     completion: Completion,
+/// }
+///
+/// type Handler = Data;
+///
+/// impl irq::Handler for Handler {
+///     // Executed in IRQ context.
+///     fn handle(&self) -> IrqReturn {
+///         self.completion.complete_all();
+///         IrqReturn::Handled
+///     }
+/// }
+///
+/// // Registers an IRQ handler for the given IrqRequest.
+/// //
+/// // This runs in process context and assumes `request` was previously acquired from a device.
+/// fn register_irq(
+///     handler: impl PinInit<Handler, Error>,
+///     request: IrqRequest<'_>,
+/// ) -> Result<Arc<Registration<Handler>>> {
+///     let registration = Registration::new(request, Flags::SHARED, c_str!("my_device"), handler);
+///
+///     let registration = Arc::pin_init(registration, GFP_KERNEL)?;
+///
+///     registration.handler().completion.wait_for_completion();
+///
+///     Ok(registration)
+/// }
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// # Invariants
+///
+/// * We own an irq handler using `&self.handler` as its private data.
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
+        handler: impl PinInit<T, Error> + 'a,
+    ) -> impl PinInit<Self, Error> + 'a {
+        try_pin_init!(&this in Self {
+            handler <- handler,
+            inner <- Devres::new(
+                request.dev,
+                try_pin_init!(RegistrationInner {
+                    // SAFETY: `this` is a valid pointer to the `Registration` instance
+                    cookie: unsafe { &raw mut (*this.as_ptr()).handler }.cast(),
+                    irq: {
+                        // SAFETY:
+                        // - The callbacks are valid for use with request_irq.
+                        // - If this succeeds, the slot is guaranteed to be valid until the
+                        //   destructor of Self runs, which will deregister the callbacks
+                        //   before the memory location becomes invalid.
+                        to_result(unsafe {
+                            bindings::request_irq(
+                                request.irq,
+                                Some(handle_irq_callback::<T>),
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
+/// This function should be only used as the callback in `request_irq`.
+unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, ptr: *mut c_void) -> c_uint {
+    // SAFETY: `ptr` is a pointer to T set in `Registration::new`
+    let handler = unsafe { &*(ptr as *const T) };
+    T::handle(handler) as c_uint
+}

-- 
2.50.1


