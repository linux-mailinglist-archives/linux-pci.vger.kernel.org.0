Return-Path: <linux-pci+bounces-32651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 904BAB0C68E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 16:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AACC04E160A
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 14:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258231E5B6D;
	Mon, 21 Jul 2025 14:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dfu9QvXN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24072C327E
	for <linux-pci@vger.kernel.org>; Mon, 21 Jul 2025 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108714; cv=none; b=WenHylWcE6ia40OzmzdciCkkb0Nd+zaqG4oBPs098RrJgbEQoYqcGR7XoBsJduphpLoMUvoevDMffmJEbqnKskfmRMyuDCj/oFoOdWt5uyYh8DjI3eqENmKK5jU97RgYqw13U+kSw87fLOfp00McuTMzt3ybk0QFkxhMqtapPHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108714; c=relaxed/simple;
	bh=qwx/8t0SiGxZEXGOngjzEOY9x6xPgtu6FieQF/1nCNY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CDsxaTL3/gpsH6Vn1+uSaKeroWfC3xRUtuq9z3JYyRtqbs/ERPsllBrpKXH2KrxEXInFay6N3ZrV8od44ogg0hGiJhwGPm7aNRY9ppy4qmtMRX8oD9H3NHC8yQJojf+/ON67EvnApxttzi3eaQ9bmaeDLorWCMrW4jylYQGOsAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dfu9QvXN; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-451d3f03b74so27412875e9.3
        for <linux-pci@vger.kernel.org>; Mon, 21 Jul 2025 07:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753108710; x=1753713510; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o32A+HzJfn3cGDCFcenZuIygBn5W1oafPXhhJ8xCF+0=;
        b=Dfu9QvXNkkbfX7+srWDgxR1n+rYiiLaIRPuTvzUcTOMPB7DXwyD0x9jcCsYAS0jRpJ
         ypuw66NybYZ6FFayUYlvHlEf42cdlZ670CZx0dd5dWllazKsbufGzDDTcTwN/5k30d6Y
         9PJRs9gHuiffxv3UlwTiUih2IBjrkiDZLqvQX8E/7RH0wUiZWGqNR/MRRZnPkq0MdIFR
         yS6QwM/Yk7nWauGnHD2D4qsEAY0LHgOVt4zg2E8BF+LAwbG0E8Cv9uwztGEjupTVoRL/
         Eya5h3vWzXrtuqzticYRwyuXT6217O2/94mKYAy7RPYbdzGgyMM7Ig5pQKDazMcUGA6M
         Bj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753108710; x=1753713510;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o32A+HzJfn3cGDCFcenZuIygBn5W1oafPXhhJ8xCF+0=;
        b=jfxRQpFUNFlSNpm/GN0ndjcQuW3GnROzgNLukpBytc44LnN/g376lBBlQgc4vDW41b
         BhKX3pCnW0X8Mfde9UJBQZ4nKxIpQS5jCgNKYTs5C2xlG3mrsxZKb/gnuZq+1PXUyby0
         kYRvXSFLkPOBrYJ4RUaav1iWqiSHRiyW+G9ShmSjWn0smQxLorWpzX16Dzurincd1Xgv
         qxWykidnDCjcxH2B5WAMdoBDz9C5MgV2HogyDVpNGcvQdNnlOi/92bZ9cje73P3MbGAP
         hizYoxizQKCN75dUse9OmHsMbx/GO7MiPn4ARCFlupYdpEu8N3kobKDdjOFE0Gp2frd2
         HriA==
X-Forwarded-Encrypted: i=1; AJvYcCV6iKWoOwDxwINbeKHGjDppqm2fFwDyXD9Gl8Ri9Wjx8jUCA/jtkfmyNWlRq5XHKvs3jm3sZ822Yp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaN9SEJqgrwyp8Dnw5MKalNd8E6Dfkoba8dxUeqlBDwRpJd5Zm
	9etUdx541p3zZV75HPHgb+Cb6SnQhocP5NU4hF+f8FehqbDOnPPU/p+JQIZ4lVfn8TPZsf4HKo8
	Q0rKOrWBvrEFkTe91cw==
X-Google-Smtp-Source: AGHT+IEn8SPlIZD7niWR9OszYeaV6Er87VzZQzpEss5XluZu6rt8sGzq4hifrbV6QleyOddcsuE+CTsMkuTr0OY=
X-Received: from wmqb11.prod.google.com ([2002:a05:600c:4e0b:b0:456:fa0:e0ba])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b0b:b0:456:12ad:ec30 with SMTP id 5b1f17b1804b1-45635e6d91cmr151493115e9.13.1753108710518;
 Mon, 21 Jul 2025 07:38:30 -0700 (PDT)
Date: Mon, 21 Jul 2025 14:38:25 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOFQfmgC/x2MSQqAMAwAvyI5G7AFcfmKeLBNqrlUTVEE6d8tH
 gdm5oXEKpxgrF5QviXJHguYugK/LXFlFCoMtrFt01mDoie6/YqEVHTP6IdALhD1ngYo2aEc5Pm X05zzB93XwaZiAAAA
X-Change-Id: 20250721-irq-bound-device-c9fdbfdd8cd9
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=11381; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=qwx/8t0SiGxZEXGOngjzEOY9x6xPgtu6FieQF/1nCNY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBoflDllHoWFnis6C9MPFfRO1cl9GT2CrTzGHDe6
 yIwlSLSeCuJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaH5Q5QAKCRAEWL7uWMY5
 Ro2xD/43I3M2pAt+ziIElxThI0IO2gCWWQTAn3FeDTA3syUKcZBZdbE8XyCSRVm8KpVeMWdy37f
 VbPb9vq57MldHPFCyyLh1dFM52WUVvvzjzXPsS7k5nhypoiLpAW/ymxujotuVaksYjQy513Csh/
 D8QH5+9yNbesE9Rt+ekbpiTAq6a73i65kBR2XcdPE/QpZeXf1x4njxqr5uu2cb8Uaqx/ZAkd0YG
 WPhUrznuvK1OY6q49D5ZKyMckXLtpGQfuG0PkAp+ZPPXEBr0qqxRQEFiBwBDi1N7SckDzOqsJpi
 q7vjDaGNXGlRA00CVPaH2bXzuas3ETp+kLoD2oYrcBG6pIWEkgXLE7qqGEljpcnj1nnMaY6kbpn
 jz9aLKMZb9YK4V7NXP6nJ+UZG6bM7li+vbcNAm1MP7h2M0iZNvaX5JUhHIDxDiYInCuvi/9Pziv
 hl5AO8kqZBFKlos13wEgtolui1Wqef0K2R/Umu1Ov1tCVl/5tOigPhaEjJjICkniSpoMGcNVT+x
 iCao6Geh1RZlC+QJoCH86dLS4GvKGpBg0JJbKwR3FJbSXc0JDNanJbtZoVaNXxQhQ3YDjfmxa6+
 9RSKQSCd6ZHSa6rTCPPvs4rwjlVicwXYkvKL5zC/YI5ZnzSm0xPRP/ppPk5AnJtThPeGgTdhbSg FGDOJcOZ0YKI5oA==
X-Mailer: b4 0.14.2
Message-ID: <20250721-irq-bound-device-v1-1-4fb2af418a63@google.com>
Subject: [PATCH] rust: irq: add &Device<Bound> argument to irq callbacks
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

The patch is otherwise based on top of driver-core-next.

[1]: https://lore.kernel.org/r/20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com
---
 rust/kernel/irq/request.rs | 88 ++++++++++++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 39 deletions(-)

diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
index d070ddabd37e7806f76edefd5d2ad46524be620e..f99aff2dd479f5223c90f0d2694f57e6c864bdb5 100644
--- a/rust/kernel/irq/request.rs
+++ b/rust/kernel/irq/request.rs
@@ -37,18 +37,18 @@ pub trait Handler: Sync {
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
 
@@ -134,7 +134,7 @@ pub fn irq(&self) -> u32 {
 /// use core::sync::atomic::Ordering;
 ///
 /// use kernel::prelude::*;
-/// use kernel::device::Bound;
+/// use kernel::device::{Bound, Device};
 /// use kernel::irq::flags::Flags;
 /// use kernel::irq::Registration;
 /// use kernel::irq::IrqRequest;
@@ -156,7 +156,7 @@ pub fn irq(&self) -> u32 {
 /// impl kernel::irq::request::Handler for Handler {
 ///     // This is executing in IRQ context in some CPU. Other CPUs can still
 ///     // try to access to data.
-///     fn handle(&self) -> IrqReturn {
+///     fn handle(&self, _dev: &Device<Bound>) -> IrqReturn {
 ///         self.0.fetch_add(1, Ordering::Relaxed);
 ///
 ///         IrqReturn::Handled
@@ -182,8 +182,7 @@ pub fn irq(&self) -> u32 {
 ///
 /// # Invariants
 ///
-/// * We own an irq handler using `&self.handler` as its private data.
-///
+/// * We own an irq handler whose cookie is a pointer to `Self`.
 #[pin_data]
 pub struct Registration<T: Handler + 'static> {
     #[pin]
@@ -211,8 +210,8 @@ pub fn new<'a>(
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
@@ -225,7 +224,7 @@ pub fn new<'a>(
                                 Some(handle_irq_callback::<T>),
                                 flags.into_inner(),
                                 name.as_char_ptr(),
-                                (&raw mut (*this.as_ptr()).handler).cast(),
+                                this.as_ptr().cast::<c_void>(),
                             )
                         })?;
                         request.irq
@@ -262,9 +261,13 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
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
 
 /// The value that can be returned from `ThreadedHandler::handle_irq`.
@@ -288,32 +291,32 @@ pub trait ThreadedHandler: Sync {
     /// limitations do apply. All work that does not necessarily need to be
     /// executed from interrupt context, should be deferred to the threaded
     /// handler, i.e. [`ThreadedHandler::handle_threaded`].
-    fn handle(&self) -> ThreadedIrqReturn;
+    fn handle(&self, device: &Device<Bound>) -> ThreadedIrqReturn;
 
     /// The threaded IRQ handler.
     ///
     /// This is executed in process context. The kernel creates a dedicated
     /// kthread for this purpose.
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
 
@@ -334,7 +337,7 @@ fn handle_threaded(&self) -> IrqReturn {
 /// use core::sync::atomic::Ordering;
 ///
 /// use kernel::prelude::*;
-/// use kernel::device::Bound;
+/// use kernel::device::{Bound, Device};
 /// use kernel::irq::flags::Flags;
 /// use kernel::irq::ThreadedIrqReturn;
 /// use kernel::irq::ThreadedRegistration;
@@ -356,7 +359,7 @@ fn handle_threaded(&self) -> IrqReturn {
 /// impl kernel::irq::request::ThreadedHandler for Handler {
 ///     // This is executing in IRQ context in some CPU. Other CPUs can still
 ///     // try to access the data.
-///     fn handle(&self) -> ThreadedIrqReturn {
+///     fn handle(&self, _dev: &Device<Bound>) -> ThreadedIrqReturn {
 ///         self.0.fetch_add(1, Ordering::Relaxed);
 ///         // By returning `WakeThread`, we indicate to the system that the
 ///         // thread function should be called. Otherwise, return
@@ -366,7 +369,7 @@ fn handle_threaded(&self) -> IrqReturn {
 ///
 ///     // This will run (in a separate kthread) if and only if `handle`
 ///     // returns `WakeThread`.
-///     fn handle_threaded(&self) -> IrqReturn {
+///     fn handle_threaded(&self, _dev: &Device<Bound>) -> IrqReturn {
 ///         self.0.fetch_add(1, Ordering::Relaxed);
 ///         IrqReturn::Handled
 ///     }
@@ -391,8 +394,7 @@ fn handle_threaded(&self) -> IrqReturn {
 ///
 /// # Invariants
 ///
-/// * We own an irq handler using `&T` as its private data.
-///
+/// * We own an irq handler whose cookie is a pointer to `Self`.
 #[pin_data]
 pub struct ThreadedRegistration<T: ThreadedHandler + 'static> {
     #[pin]
@@ -420,8 +422,8 @@ pub fn new<'a>(
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
@@ -435,7 +437,7 @@ pub fn new<'a>(
                                 Some(thread_fn_callback::<T>),
                                 flags.into_inner() as usize,
                                 name.as_char_ptr(),
-                                (&raw mut (*this.as_ptr()).handler).cast(),
+                                this.as_ptr().cast::<c_void>(),
                             )
                         })?;
                         request.irq
@@ -475,16 +477,24 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
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
base-commit: d860d29e91be18de62b0f441edee7d00f6cb4972
change-id: 20250721-irq-bound-device-c9fdbfdd8cd9

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


