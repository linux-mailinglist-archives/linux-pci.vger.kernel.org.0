Return-Path: <linux-pci+bounces-33763-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468DEB2118D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 18:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971BF686B5D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34992E3B0E;
	Mon, 11 Aug 2025 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NwlKUIO8"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E92C2E4248;
	Mon, 11 Aug 2025 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928288; cv=none; b=ceotKId4ToCA9ugI6N8tvzIs4MuUo+0KqP0xaNzKAOIrHYjhQgvoB49xpYVQc0OEG6s2+8PgHmAtcWmcOrKJ2fgg9HRQ2dsLYfj8eZFB8p1LM0B1FuPIWe6SspEUHLJArpKrf4mog5eEHPelp3FLsng/wQ9OVZnUIldUNmV8w4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928288; c=relaxed/simple;
	bh=P0FxVoeKMOCv0FiYXIPHPq65i6gU7ma+BQ0+5+XiL0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rzp1HfOdelb+pb4ik1PsYibpRQv1d51Wx9yCoGzkkmbO3Xn/Oo6F+Z9/fEOTzcDjjcdZX/RVgfotbKtvcOSBui784ODJcgc5wkgq0NbR5i6ka7+1NB/qJzH5dRGu0WB6PBIB5eoLS6KSHTRPEq0oyO8SQ9HknUUafjfQIGrwFmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NwlKUIO8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754928275;
	bh=P0FxVoeKMOCv0FiYXIPHPq65i6gU7ma+BQ0+5+XiL0o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NwlKUIO8svgXuW5be5mbCDP4YkxxRYVwCRbD4XTaXC5MF8znyqMayhQuiX6OY2L9/
	 BBMj2t4yGXRwaxjnH/dnO3ZbE56mHLbT5r03UFD6WB+5B1m46Zs5cg54MFC+KTDgly
	 4qWlqW0RmALYHbJy+uZsfMIFbwLeeqe5X3mbKD7+Y7QV9wpEzGTQTUYcZoX3Apmvfm
	 wXK1dS4iFfCALNQ1mW8UrjF4sdPFMXcoYXETV+DkShmsVlT2I5XCgsf35jsgGAeX6p
	 LAB8spbAo8U/HqjTQTaMOY7tkwz3tUzwMGFP8TmNtg6Au7mncq20ui1W6Hur7tGcWY
	 oMpUUTKUqrXGA==
Received: from [192.168.0.23] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9BDFE17E0286;
	Mon, 11 Aug 2025 18:04:31 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Mon, 11 Aug 2025 13:03:45 -0300
Subject: [PATCH v9 7/7] rust: irq: add &Device<Bound> argument to irq
 callbacks
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-topics-tyr-request_irq2-v9-7-0485dcd9bcbf@collabora.com>
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
 linux-pci@vger.kernel.org
X-Mailer: b4 0.14.2

From: Alice Ryhl <aliceryhl@google.com>

When working with a bus device, many operations are only possible while
the device is still bound. The &Device<Bound> type represents a proof in
the type system that you are in a scope where the device is guaranteed
to still be bound. Since we deregister irq callbacks when unbinding a
device, if an irq callback is running, that implies that the device has
not yet been unbound.

To allow drivers to take advantage of that, add an additional argument
to irq callbacks.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/irq/request.rs | 95 +++++++++++++++++++++++++++-------------------
 1 file changed, 57 insertions(+), 38 deletions(-)

diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
index 4033df7d0dce1dbc9cc9b0b0f32fb9f8aa285d6b..b150563fdef809899c7ca39221c4928238e31110 100644
--- a/rust/kernel/irq/request.rs
+++ b/rust/kernel/irq/request.rs
@@ -36,18 +36,18 @@ pub trait Handler: Sync {
     /// All work that does not necessarily need to be executed from
     /// interrupt context, should be deferred to a threaded handler.
     /// See also [`ThreadedRegistration`].
-    fn handle(&self) -> IrqReturn;
+    fn handle(&self, device: &Device<Bound>) -> IrqReturn;
 }
 
 impl<T: ?Sized + Handler + Send> Handler for Arc<T> {
-    fn handle(&self) -> IrqReturn {
-        T::handle(self)
+    fn handle(&self, device: &Device<Bound>) -> IrqReturn {
+        T::handle(self, device)
     }
 }
 
 impl<T: ?Sized + Handler, A: Allocator> Handler for Box<T, A> {
-    fn handle(&self) -> IrqReturn {
-        T::handle(self)
+    fn handle(&self, device: &Device<Bound>) -> IrqReturn {
+        T::handle(self, device)
     }
 }
 
@@ -140,7 +140,7 @@ pub fn irq(&self) -> u32 {
 ///
 /// ```
 /// use kernel::c_str;
-/// use kernel::device::Bound;
+/// use kernel::device::{Bound, Device};
 /// use kernel::irq::{self, Flags, IrqRequest, IrqReturn, Registration};
 /// use kernel::prelude::*;
 /// use kernel::sync::{Arc, Completion};
@@ -154,7 +154,7 @@ pub fn irq(&self) -> u32 {
 ///
 /// impl irq::Handler for Data {
 ///     // Executed in IRQ context.
-///     fn handle(&self) -> IrqReturn {
+///     fn handle(&self, _dev: &Device<Bound>) -> IrqReturn {
 ///         self.completion.complete_all();
 ///         IrqReturn::Handled
 ///     }
@@ -180,7 +180,7 @@ pub fn irq(&self) -> u32 {
 ///
 /// # Invariants
 ///
-/// * We own an irq handler using `&self.handler` as its private data.
+/// * We own an irq handler whose cookie is a pointer to `Self`.
 #[pin_data]
 pub struct Registration<T: Handler + 'static> {
     #[pin]
@@ -208,21 +208,24 @@ pub fn new<'a>(
             inner <- Devres::new(
                 request.dev,
                 try_pin_init!(RegistrationInner {
-                    // SAFETY: `this` is a valid pointer to the `Registration` instance
-                    cookie: unsafe { &raw mut (*this.as_ptr()).handler }.cast(),
+                    // INVARIANT: `this` is a valid pointer to the `Registration` instance
+                    cookie: this.as_ptr().cast::<c_void>(),
                     irq: {
                         // SAFETY:
                         // - The callbacks are valid for use with request_irq.
                         // - If this succeeds, the slot is guaranteed to be valid until the
                         //   destructor of Self runs, which will deregister the callbacks
                         //   before the memory location becomes invalid.
+                        // - When request_irq is called, everything that handle_irq_callback will
+                        //   touch has already been initialized, so it's safe for the callback to
+                        //   be called immediately.
                         to_result(unsafe {
                             bindings::request_irq(
                                 request.irq,
                                 Some(handle_irq_callback::<T>),
                                 flags.into_inner(),
                                 name.as_char_ptr(),
-                                (&raw mut (*this.as_ptr()).handler).cast(),
+                                this.as_ptr().cast::<c_void>(),
                             )
                         })?;
                         request.irq
@@ -259,9 +262,13 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
 ///
 /// This function should be only used as the callback in `request_irq`.
 unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, ptr: *mut c_void) -> c_uint {
-    // SAFETY: `ptr` is a pointer to T set in `Registration::new`
-    let handler = unsafe { &*(ptr as *const T) };
-    T::handle(handler) as c_uint
+    // SAFETY: `ptr` is a pointer to `Registration<T>` set in `Registration::new`
+    let registration = unsafe { &*(ptr as *const Registration<T>) };
+    // SAFETY: The irq callback is removed before the device is unbound, so the fact that the irq
+    // callback is running implies that the device has not yet been unbound.
+    let device = unsafe { registration.inner.device().as_bound() };
+
+    T::handle(&registration.handler, device) as c_uint
 }
 
 /// The value that can be returned from [`ThreadedHandler::handle`].
@@ -287,7 +294,8 @@ pub trait ThreadedHandler: Sync {
     /// handler, i.e. [`ThreadedHandler::handle_threaded`].
     ///
     /// The default implementation returns [`ThreadedIrqReturn::WakeThread`].
-    fn handle(&self) -> ThreadedIrqReturn {
+    #[expect(unused_variables)]
+    fn handle(&self, device: &Device<Bound>) -> ThreadedIrqReturn {
         ThreadedIrqReturn::WakeThread
     }
 
@@ -295,26 +303,26 @@ fn handle(&self) -> ThreadedIrqReturn {
     ///
     /// This is executed in process context. The kernel creates a dedicated
     /// `kthread` for this purpose.
-    fn handle_threaded(&self) -> IrqReturn;
+    fn handle_threaded(&self, device: &Device<Bound>) -> IrqReturn;
 }
 
 impl<T: ?Sized + ThreadedHandler + Send> ThreadedHandler for Arc<T> {
-    fn handle(&self) -> ThreadedIrqReturn {
-        T::handle(self)
+    fn handle(&self, device: &Device<Bound>) -> ThreadedIrqReturn {
+        T::handle(self, device)
     }
 
-    fn handle_threaded(&self) -> IrqReturn {
-        T::handle_threaded(self)
+    fn handle_threaded(&self, device: &Device<Bound>) -> IrqReturn {
+        T::handle_threaded(self, device)
     }
 }
 
 impl<T: ?Sized + ThreadedHandler, A: Allocator> ThreadedHandler for Box<T, A> {
-    fn handle(&self) -> ThreadedIrqReturn {
-        T::handle(self)
+    fn handle(&self, device: &Device<Bound>) -> ThreadedIrqReturn {
+        T::handle(self, device)
     }
 
-    fn handle_threaded(&self) -> IrqReturn {
-        T::handle_threaded(self)
+    fn handle_threaded(&self, device: &Device<Bound>) -> IrqReturn {
+        T::handle_threaded(self, device)
     }
 }
 
@@ -333,7 +341,7 @@ fn handle_threaded(&self) -> IrqReturn {
 ///
 /// ```
 /// use kernel::c_str;
-/// use kernel::device::Bound;
+/// use kernel::device::{Bound, Device};
 /// use kernel::irq::{
 ///   self, Flags, IrqRequest, IrqReturn, ThreadedHandler, ThreadedIrqReturn,
 ///   ThreadedRegistration,
@@ -357,7 +365,7 @@ fn handle_threaded(&self) -> IrqReturn {
 ///     // This will run (in a separate kthread) if and only if
 ///     // [`ThreadedHandler::handle`] returns [`WakeThread`], which it does by
 ///     // default.
-///     fn handle_threaded(&self) -> IrqReturn {
+///     fn handle_threaded(&self, _dev: &Device<Bound>) -> IrqReturn {
 ///         let mut data = self.value.lock();
 ///         *data += 1;
 ///         IrqReturn::Handled
@@ -390,7 +398,7 @@ fn handle_threaded(&self) -> IrqReturn {
 ///
 /// # Invariants
 ///
-/// * We own an irq handler using `&T` as its private data.
+/// * We own an irq handler whose cookie is a pointer to `Self`.
 #[pin_data]
 pub struct ThreadedRegistration<T: ThreadedHandler + 'static> {
     #[pin]
@@ -418,14 +426,17 @@ pub fn new<'a>(
             inner <- Devres::new(
                 request.dev,
                 try_pin_init!(RegistrationInner {
-                    // SAFETY: `this` is a valid pointer to the `ThreadedRegistration` instance.
-                    cookie: unsafe { &raw mut (*this.as_ptr()).handler }.cast(),
+                    // INVARIANT: `this` is a valid pointer to the `ThreadedRegistration` instance.
+                    cookie: this.as_ptr().cast::<c_void>(),
                     irq: {
                         // SAFETY:
                         // - The callbacks are valid for use with request_threaded_irq.
                         // - If this succeeds, the slot is guaranteed to be valid until the
-                        // destructor of Self runs, which will deregister the callbacks
-                        // before the memory location becomes invalid.
+                        //   destructor of Self runs, which will deregister the callbacks
+                        //   before the memory location becomes invalid.
+                        // - When request_threaded_irq is called, everything that the two callbacks
+                        //   will touch has already been initialized, so it's safe for the
+                        //   callbacks to be called immediately.
                         to_result(unsafe {
                             bindings::request_threaded_irq(
                                 request.irq,
@@ -433,7 +444,7 @@ pub fn new<'a>(
                                 Some(thread_fn_callback::<T>),
                                 flags.into_inner(),
                                 name.as_char_ptr(),
-                                (&raw mut (*this.as_ptr()).handler).cast(),
+                                this.as_ptr().cast::<c_void>(),
                             )
                         })?;
                         request.irq
@@ -473,16 +484,24 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
     _irq: i32,
     ptr: *mut c_void,
 ) -> c_uint {
-    // SAFETY: `ptr` is a pointer to T set in `ThreadedRegistration::new`
-    let handler = unsafe { &*(ptr as *const T) };
-    T::handle(handler) as c_uint
+    // SAFETY: `ptr` is a pointer to `ThreadedRegistration<T>` set in `ThreadedRegistration::new`
+    let registration = unsafe { &*(ptr as *const ThreadedRegistration<T>) };
+    // SAFETY: The irq callback is removed before the device is unbound, so the fact that the irq
+    // callback is running implies that the device has not yet been unbound.
+    let device = unsafe { registration.inner.device().as_bound() };
+
+    T::handle(&registration.handler, device) as c_uint
 }
 
 /// # Safety
 ///
 /// This function should be only used as the callback in `request_threaded_irq`.
 unsafe extern "C" fn thread_fn_callback<T: ThreadedHandler>(_irq: i32, ptr: *mut c_void) -> c_uint {
-    // SAFETY: `ptr` is a pointer to T set in `ThreadedRegistration::new`
-    let handler = unsafe { &*(ptr as *const T) };
-    T::handle_threaded(handler) as c_uint
+    // SAFETY: `ptr` is a pointer to `ThreadedRegistration<T>` set in `ThreadedRegistration::new`
+    let registration = unsafe { &*(ptr as *const ThreadedRegistration<T>) };
+    // SAFETY: The irq callback is removed before the device is unbound, so the fact that the irq
+    // callback is running implies that the device has not yet been unbound.
+    let device = unsafe { registration.inner.device().as_bound() };
+
+    T::handle_threaded(&registration.handler, device) as c_uint
 }

-- 
2.50.1


