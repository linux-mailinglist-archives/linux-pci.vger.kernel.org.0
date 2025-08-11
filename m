Return-Path: <linux-pci+bounces-33727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D61CB208D3
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 14:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238C43AA655
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 12:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DE62BE03D;
	Mon, 11 Aug 2025 12:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4FJyc+h3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410C43C38
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915642; cv=none; b=WoJUZu0yDaU8kkTGlT0JD/ZG2E6UB00YVGos7b4ChNSz0IWy4+TawCZ9TsUk6TVaV7RMbqq/rT1qMt4Nl67KkreLQoIFoX+SYpou3UpIZ9EvUL9AAcPDWUW2FFFaGXipAC/xZbj9AV0UeFgA/0dAPPsG7MgthLqRiEDT7yhXzSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915642; c=relaxed/simple;
	bh=LA2sJU/vYsLUweasr0huPRBxzSYqgCWcqXzUJeextJc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=r3ChVxWYFNIb04ao/hMCmsqG9LcdOYcT1sdGyYo8FUjGb5VNnEwx9mdG0hk2LxEc7pROR+ofKe3wq8O0dDGxlrtWWoH/KfTGzOctpujE9EBhizIpVXn+Yr2HW1mznjYc3Cyvtd9qmxCY/qjypaHzYVjPbfi2rwN0h/Su5ToH1QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4FJyc+h3; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-459de8f00cfso17909805e9.2
        for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 05:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754915639; x=1755520439; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YZvjerL4wW8XwzhEFHvETehXGYRte2K2Qlr0P8nqiFM=;
        b=4FJyc+h3b5oOBG1vq/ls7j9p4Tmzj3haFaijvdL+4+TIu2wqPXDUVGHsUzOeqsAZ11
         HkHo3rNKq7fQrRfQ6gz1D4xe57F8pS7k0IHAghq6MNDYM20mUdU+LB2lkKHC34NlEnoX
         IatlcgT1F85A9GfiGqlwDoZIp4RyQkDQ4NeG03fxdWFQtgKBl0vIGHqrvUY38X2fDGq1
         R+TxMarOOy5loEqvh+LjDET4HKDZ6337pqTZX4Z7gMSry+SYnPRGfPoz7M9GN95/HEOx
         Ju7glZSkSdNMdVJ3tck3G6FDQNgXHgDOMZHsFCul7VemDYYRN9kELzGwmQaD470RK+/a
         Ljrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754915639; x=1755520439;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YZvjerL4wW8XwzhEFHvETehXGYRte2K2Qlr0P8nqiFM=;
        b=BNr93UQeFFSBqeTqGFnWGyqSAZva5z7okdyfjX3gXgmDG9hDuO8Lzn8CLI8ACLOgD9
         FfOSnMEKPw8Ezcf3U4NYwJ0p+p46kUTnJWvkic0IjxK6z62mmKAMaLn1riyTr1z6Jqpc
         k8pI+i3J1fajxxe/MZmtJWxt2WdIkXuRC3HKcUPRNnhaOG2+b9/saiFjJfZNprhbWih5
         jgn28ugXBMbLimJDn57BxB/W0tXlHzrg1PFDNziZBWg4Ijd2uJW2MxCeecvpLx1b4X97
         AtIq9EP1NSoyQ8wuc3b+P555yxSytYPUFD+it12cEvRu1nD1E5NrUr/9jwYM1huDyfud
         9PKw==
X-Forwarded-Encrypted: i=1; AJvYcCXR4gfBdJkuIYZ19f9WW4kbcSmbXAx4YDjk7SSfEVPJfxorEal4vh/kER5FOX5zRCq9XldhN2XFRDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY4Lv7EXLEPS4REiOq6QPhlf6yAgvt+pRFpzOvmerduDLCjqz6
	X+XpVmSdSpsaKYsAdidV712cblk7sNb0Y/+EJDc2Xx6VDEheHHyNS66ngDpEjVSb+ACN4S/I27x
	eIphmVA/aLga4fhr6oQ==
X-Google-Smtp-Source: AGHT+IECjH7ZxJgUgCbKEQia1xksFNnwEbZnbG3a0LNrmnvx31ihF54FFzDkbVYCzEsCpZpt9AEhsXfm3/Gscng=
X-Received: from wmsr17.prod.google.com ([2002:a05:600c:8b11:b0:458:715c:51a1])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4511:b0:456:43c:dcdc with SMTP id 5b1f17b1804b1-459f4f5474bmr98747335e9.33.1754915638678;
 Mon, 11 Aug 2025 05:33:58 -0700 (PDT)
Date: Mon, 11 Aug 2025 12:33:51 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAC/jmWgC/32Py47CMAxFf6XKeoxIpqVpV/wHQqM8nGJp2kASo
 kGIfx9TNqxYXss+5/ouMibCLMbmLhJWyhQXDuqrEe5klgmBPGehtqrb9koCpQvYeF08eF53CG4
 I3gbvtfOD4LNzwkB/K/Jw5HyiXGK6rYYqn9MPsCpBQhusMqGV2uy+91OM0y9uXJzF8fHCJ7xcu
 Wh5OYQ1mVvEeaYyNnW3kT0kJ8X7B/zQqpQKSjyTy1BuCZ4czOWHWygw2CMOVne6a8eqWfb4B11 E8m8dAQAA
X-Change-Id: 20250721-irq-bound-device-c9fdbfdd8cd9
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=11382; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=LA2sJU/vYsLUweasr0huPRBxzSYqgCWcqXzUJeextJc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBomeM1+T38PVs0JpVVlt/3imJNIorqlnF/5r+eC
 wQ+tL9FBGyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaJnjNQAKCRAEWL7uWMY5
 RsKkD/0VIBK8zT8TZDQQOHzPP//REva7kqgrPeD2n5l4B5RZUz3jz8IJLG0qsbTGocJ1iFJz6DS
 dqlTOvJmGtgT+gkjIjWWTF8DNQGycGso2yTBdxcmGNMfgrkIjmVC7h+xAbVZjagYBHr+sFIsG/J
 4lK3J2rw4o5TNi5tirQHX6gLg1jEp4CXjcFRrqIZzbcvg6DH1jaxEx7wOXLKLETlhw5F9G1B5T+
 0u+s3My7G2vpC+DE3uRaCakrwrfKepHwwuA8O9meCfucd7M6/QqKkKJ0FwjPgtByzTWQzZ+rS5H
 albGmMdE8CeJN3HH/aoFGPKtyaf8Lt7ZrgLL8SPyNR1S+I7poON1wlhYvfxLg5k0mtqQ4CMfG+d
 E4zan9g0Yq82yg0VoOUY26CXMmNBHteThASPTUQHp4CkPW/dwOKb/+qxqJY1KS02EpNfITqf7D/
 dJGf3qoFsMNI2gcGXhIKJtdIHCKcT2Ny2gf9vNzDicY/Z/cTKx19xtqVi3pxbeach8SRpR4a+u8
 T8lmuaPg2hB7tGtTF3pa2wKfKdE4xxH5W0SKhlIna3D2njLQOtTAdlQ1cThlQ8Aq8SUEuE6hFHU
 XNYPbWAkehALEiwV+3zwOKEbRIZ02/nNrPHKh/lYMhRl868+z0W48XW54RSQNKzcip3mo1TYfti V82AVDSa5xnNG/Q==
X-Mailer: b4 0.14.2
Message-ID: <20250811-irq-bound-device-v2-1-d73ebb4a50a2@google.com>
Subject: [PATCH v2] rust: irq: add &Device<Bound> argument to irq callbacks
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	"=?utf-8?q?Krzysztof_Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, Benno Lossin <lossin@kernel.org>, 
	Dirk Behme <dirk.behme@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-pci@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

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
This patch is a follow-up to Daniel's irq series [1] that adds a
&Device<Bound> argument to all irq callbacks. This allows you to use
operations that are only safe on a bound device inside an irq callback.

[1]: https://lore.kernel.org/all/20250810-topics-tyr-request_irq2-v8-0-8163f4c4c3a6@collabora.com/
---
Changes in v2:
- Rebase on v8 of [1] (and hence v6.17-rc1).
- Link to v1: https://lore.kernel.org/r/20250721-irq-bound-device-v1-1-4fb2af418a63@google.com
---
 rust/kernel/irq/request.rs | 85 ++++++++++++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 36 deletions(-)

diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
index 29597573e91106d0990ec096a8e7f93ef2f89f2b..ae5d967fb9d6a748b4274464b615e6dd965bca10 100644
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
 /// # use kernel::c_str;
-/// # use kernel::device::Bound;
+/// # use kernel::device::{Bound, Device};
 /// # use kernel::irq::{self, Flags, IrqRequest, IrqReturn, Registration};
 /// # use kernel::prelude::*;
 /// # use kernel::sync::{Arc, Completion};
@@ -153,7 +153,7 @@ pub fn irq(&self) -> u32 {
 ///
 /// impl irq::Handler for Handler {
 ///     // Executed in IRQ context.
-///     fn handle(&self) -> IrqReturn {
+///     fn handle(&self, _dev: &Device<Bound>) -> IrqReturn {
 ///         self.completion.complete_all();
 ///         IrqReturn::Handled
 ///     }
@@ -179,7 +179,7 @@ pub fn irq(&self) -> u32 {
 ///
 /// # Invariants
 ///
-/// * We own an irq handler using `&self.handler` as its private data.
+/// * We own an irq handler whose cookie is a pointer to `Self`.
 #[pin_data]
 pub struct Registration<T: Handler + 'static> {
     #[pin]
@@ -207,8 +207,8 @@ pub fn new<'a>(
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
@@ -221,7 +221,7 @@ pub fn new<'a>(
                                 Some(handle_irq_callback::<T>),
                                 flags.into_inner(),
                                 name.as_char_ptr(),
-                                (&raw mut (*this.as_ptr()).handler).cast(),
+                                this.as_ptr().cast::<c_void>(),
                             )
                         })?;
                         request.irq
@@ -258,9 +258,13 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
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
@@ -286,7 +290,8 @@ pub trait ThreadedHandler: Sync {
     /// handler, i.e. [`ThreadedHandler::handle_threaded`].
     ///
     /// The default implementation returns [`ThreadedIrqReturn::WakeThread`].
-    fn handle(&self) -> ThreadedIrqReturn {
+    #[expect(unused_variables)]
+    fn handle(&self, device: &Device<Bound>) -> ThreadedIrqReturn {
         ThreadedIrqReturn::WakeThread
     }
 
@@ -294,26 +299,26 @@ fn handle(&self) -> ThreadedIrqReturn {
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
 
@@ -332,7 +337,7 @@ fn handle_threaded(&self) -> IrqReturn {
 ///
 /// ```
 /// # use kernel::c_str;
-/// # use kernel::device::Bound;
+/// # use kernel::device::{Bound, Device};
 /// # use kernel::irq::{
 /// #   self, Flags, IrqRequest, IrqReturn, ThreadedHandler, ThreadedIrqReturn,
 /// #   ThreadedRegistration,
@@ -355,7 +360,7 @@ fn handle_threaded(&self) -> IrqReturn {
 ///     // This will run (in a separate kthread) if and only if
 ///     // [`ThreadedHandler::handle`] returns [`WakeThread`], which it does by
 ///     // default.
-///     fn handle_threaded(&self) -> IrqReturn {
+///     fn handle_threaded(&self, _dev: &Device<Bound>) -> IrqReturn {
 ///         let mut data = self.value.lock();
 ///         *data += 1;
 ///         IrqReturn::Handled
@@ -388,7 +393,7 @@ fn handle_threaded(&self) -> IrqReturn {
 ///
 /// # Invariants
 ///
-/// * We own an irq handler using `&T` as its private data.
+/// * We own an irq handler whose cookie is a pointer to `Self`.
 #[pin_data]
 pub struct ThreadedRegistration<T: ThreadedHandler + 'static> {
     #[pin]
@@ -416,8 +421,8 @@ pub fn new<'a>(
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
@@ -431,7 +436,7 @@ pub fn new<'a>(
                                 Some(thread_fn_callback::<T>),
                                 flags.into_inner(),
                                 name.as_char_ptr(),
-                                (&raw mut (*this.as_ptr()).handler).cast(),
+                                this.as_ptr().cast::<c_void>(),
                             )
                         })?;
                         request.irq
@@ -471,16 +476,24 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
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

---
base-commit: 062b3e4a1f880f104a8d4b90b767788786aa7b78
change-id: 20250721-irq-bound-device-c9fdbfdd8cd9
prerequisite-change-id: 20250712-topics-tyr-request_irq2-ae7ee9b85854:v8
prerequisite-patch-id: 0ed57dd6c685034df8a741c0290e1647880ad9b9
prerequisite-patch-id: 939809f0395089541acb9421cdb798ea625bd31b
prerequisite-patch-id: 5106394e817b371de5035a8289f6820f8aea3895
prerequisite-patch-id: 402fb2b44076d5a5d2a7210a8496e665d05e7c2a
prerequisite-patch-id: c4d08dda330b2ae8b5c8bb7a9d6bdef379119a6d
prerequisite-patch-id: 0a639274db9c6e7002828a6652a9f5a7d1dfd67f

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


