Return-Path: <linux-pci+bounces-29177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AF8AD156A
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 00:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A7D3AAFF9
	for <lists+linux-pci@lfdr.de>; Sun,  8 Jun 2025 22:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A951211497;
	Sun,  8 Jun 2025 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="fB+a2vr7"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D2A1C8603;
	Sun,  8 Jun 2025 22:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749423466; cv=pass; b=kTlvC8AZHRRHXBKg7r1BW/pmYfbBM3u6nhOePgWFCoo85YShkZWXgqy+5d2W11Z/7o49699Pd7Gc0gR6cLALEKsWSh+Ke9F7ujQRN1Xywbif4bbgjs8rDerbkMe7zHaC+zY5n4iM+V5dT8zeXQoXjBm5N8scGMuxQnxP4Lb2aYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749423466; c=relaxed/simple;
	bh=974hiEPP2BDS5jb9/Gd3lcXrz6YHDXeE5AwTCqpn64o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BocJ5taWTLwZc4qyM3XIqARc358IOJPRaHhql+Leob2yzNVdKoHQ+Z6iS7EsouYDCzJPQmwUJTelEo8Mj2qVuFayZnzKDV5ZGm2nfRn/RQMec3Dm5GBpFIi1rZFMhsFCgQBRfiFB24nBENqQGCO+Lc3uEEpQYraRBRXCJBCQlGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=fB+a2vr7; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1749423445; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LgxCaiMS6kTtjonYSSOuPBsteaO+aD+ydXNsi+LDhYStcNY8rncyaUsnBhDn6Bookr/7W2koFW83p6yuqfqgHczxlpsBn+GfNbgrzRXCAJ6qy5XEGGML8TG6j8IHf0KKl5TJPlKCdEKW9LUU4mHK9kwE0/rJl/n/TSJOezmrtsc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749423445; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=q5qEi9/0i5U+wOMavBzkwtrrKI/12C1gAUGLsQ7kghs=; 
	b=EiTA0ZjJ5SJPV6msJRb0g5oe+9vzyYrzYbv6d6Pb5rCAKZPHGE+ftrbq7KF8PxcLHoizeXoL/qU9BhAJ4sbxFhDKXWqptgobeOiL5GRO23uOEOBknvs8KLJWCIZKMSLQsmekdK2uTjZTyuhUAYcuLtWo8bnnBS3Wqc6o5XpytJE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749423445;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=q5qEi9/0i5U+wOMavBzkwtrrKI/12C1gAUGLsQ7kghs=;
	b=fB+a2vr79S79J2sNbdKZ3oOQmhXFeN+I/DlgWXkM3K2B6Ft81aPMjKm60BVU/Orj
	Wx8Dp4mFjXIZrdVdclfdDGWd/h9ipunwy+HDBbJxjTDv1HtKvjxD7+D0EQOa8B0PGgD
	9vloohC7W9e0BA8swHFEA7f58Ef6zwUsDT76LOg0=
Received: by mx.zohomail.com with SMTPS id 1749423443352549.1367213535681;
	Sun, 8 Jun 2025 15:57:23 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Sun, 08 Jun 2025 19:51:09 -0300
Subject: [PATCH v4 4/6] rust: irq: add support for threaded IRQs and
 handlers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250608-topics-tyr-request_irq-v4-4-81cb81fb8073@collabora.com>
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

This patch adds support for threaded IRQs and handlers through
irq::ThreadedRegistration and the irq::ThreadedHandler trait.

Threaded interrupts are more permissive in the sense that further
processing is possible in a kthread. This means that said execution takes
place outside of interrupt context, which is rather restrictive in many
ways.

Registering an IRQ is defined as pub(crate) so that future patches can
define proper (safe) accessors for the IRQs exposed by a device. Said
accessors are bus-specific.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/irq.rs         |   4 +-
 rust/kernel/irq/request.rs | 256 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 259 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
index 650c9409a86ba25dfc2453cd10350f299de2450d..3a762069df210e0c7a833529b29864b0c90e2483 100644
--- a/rust/kernel/irq.rs
+++ b/rust/kernel/irq.rs
@@ -16,4 +16,6 @@
 /// IRQ allocation and handling.
 pub mod request;
 
-pub use request::{Handler, IrqReturn, Registration};
+pub use request::{
+    Handler, IrqReturn, Registration, ThreadedHandler, ThreadedIrqReturn, ThreadedRegistration,
+};
diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
index e0bf8ca192e7b27c6dbfe611c3a6cc8df8153c35..37bbffe6c982ce0a9424f9dfcbd5e9b98766160b 100644
--- a/rust/kernel/irq/request.rs
+++ b/rust/kernel/irq/request.rs
@@ -257,3 +257,259 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
     let data = unsafe { &*(ptr as *const Registration<T>) };
     T::handle_irq(&data.handler).into_inner()
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
+    fn handle_irq(&self) -> ThreadedIrqReturn;
+
+    /// The threaded handler function. This function is called from the irq
+    /// handler thread, which is automatically created by the system.
+    fn thread_fn(&self) -> IrqReturn;
+}
+
+impl<T: ?Sized + ThreadedHandler + Send> ThreadedHandler for Arc<T> {
+    fn handle_irq(&self) -> ThreadedIrqReturn {
+        T::handle_irq(self)
+    }
+
+    fn thread_fn(&self) -> IrqReturn {
+        T::thread_fn(self)
+    }
+}
+
+impl<T: ?Sized + ThreadedHandler, A: Allocator> ThreadedHandler for Box<T, A> {
+    fn handle_irq(&self) -> ThreadedIrqReturn {
+        T::handle_irq(self)
+    }
+
+    fn thread_fn(&self) -> IrqReturn {
+        T::thread_fn(self)
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
+/// use kernel::irq::IrqReturn;
+/// use kernel::platform;
+/// use kernel::sync::Arc;
+/// use kernel::sync::SpinLock;
+/// use kernel::alloc::flags::GFP_KERNEL;
+/// use kernel::c_str;
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
+/// impl kernel::irq::request::ThreadedHandler for Handler {
+///     // This is executing in IRQ context in some CPU. Other CPUs can still
+///     // try to access to data.
+///     fn handle_irq(&self) -> ThreadedIrqReturn {
+///         self.0.fetch_add(1, Ordering::Relaxed);
+///
+///         // By returning `WakeThread`, we indicate to the system that the
+///         // thread function should be called. Otherwise, return
+///         // ThreadedIrqReturn::Handled.
+///         ThreadedIrqReturn::WakeThread
+///     }
+///
+///     // This will run (in a separate kthread) if and only if `handle_irq`
+///     // returns `WakeThread`.
+///     fn thread_fn(&self) -> IrqReturn {
+///         self.0.fetch_add(1, Ordering::Relaxed);
+///
+///         IrqReturn::Handled
+///     }
+/// }
+///
+/// // This is running in process context.
+/// fn register_threaded_irq(handler: Handler, dev: &platform::Device<Bound>) -> Result<Arc<ThreadedRegistration<Handler>>> {
+///     let registration = dev.threaded_irq_by_index(0, flags::SHARED, c_str!("my-device"), handler)?;
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
+///
+/// # Ok::<(), Error>(())
+///```
+///
+/// # Invariants
+///
+/// * We own an irq handler using `&self` as its private data.
+///
+#[pin_data]
+pub struct ThreadedRegistration<T: ThreadedHandler + 'static> {
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
+            // - The callbacks are valid for use with request_threaded_irq.
+            // - If this succeeds, the slot is guaranteed to be valid until the
+            // destructor of Self runs, which will deregister the callbacks
+            // before the memory location becomes invalid.
+            let res = to_result(unsafe {
+                bindings::request_threaded_irq(
+                    irq,
+                    Some(handle_threaded_irq_callback::<T>),
+                    Some(thread_fn_callback::<T>),
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
+        // - if this returns Ok(()), then every field of `slot` is fully
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
+/// This function should be only used as the callback in `request_threaded_irq`.
+unsafe extern "C" fn handle_threaded_irq_callback<T: ThreadedHandler>(
+    _irq: i32,
+    ptr: *mut core::ffi::c_void,
+) -> core::ffi::c_uint {
+    // SAFETY: `ptr` is a pointer to ThreadedRegistration<T> set in `ThreadedRegistration::new`
+    let data = unsafe { &*(ptr as *const ThreadedRegistration<T>) };
+    T::handle_irq(&data.handler).into_inner()
+}
+
+/// # Safety
+///
+/// This function should be only used as the callback in `request_threaded_irq`.
+unsafe extern "C" fn thread_fn_callback<T: ThreadedHandler>(
+    _irq: i32,
+    ptr: *mut core::ffi::c_void,
+) -> core::ffi::c_uint {
+    // SAFETY: `ptr` is a pointer to ThreadedRegistration<T> set in `ThreadedRegistration::new`
+    let data = unsafe { &*(ptr as *const ThreadedRegistration<T>) };
+    T::thread_fn(&data.handler).into_inner()
+}

-- 
2.49.0


