Return-Path: <linux-pci+bounces-7676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DC48CA156
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 19:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479401C2183D
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 17:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999C513848B;
	Mon, 20 May 2024 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acU0rm1k"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C3C138484
	for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716226038; cv=none; b=W2rN3sxOf83653xlYRiICw4GCgq80YhW/wAiJnB5SjVKKEZbj778d3gRrh3AB9VHHlsN+uZsFfEvdwdAW/CiODqGiFf4J51JoxdofirtyIwZaeu3QveV9vL+T7TnQ2/1oVzM9wDiJSjwN0JyTK4vFM8idKglJbdZNLLTW3bAlhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716226038; c=relaxed/simple;
	bh=0F0rfov5AgIy+BJUKXtpd/KEtgXk5R3qsYOeTsHEmZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1TJlQCToRicg0letTeMZTY1M6lSWZJDk/XHOaicYb5SqdpxIHIPlrffQyeBBOpWKomWyQ1gl4jN0/p68jOx7Cc/h4aYgtuOIMMZaeg4pF7jXznDpuG2znqNdUfX4b9T7bH/W+bT+QSPzDpo68kQmM0nQSY/X4crR0Jtx7hEPkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=acU0rm1k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716226035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Wnrlx8Ze5f4eVrQIFsuBZ5dBRmGRAk/pP24qmNaV1o=;
	b=acU0rm1k1DzGrYyRCThba68QD36JmcSBRe4zVzPvEwR8KxKpZYJLCiXnKf1o7tN7XKcnpk
	wHnp00cIsv/e1V0m2iG6LF1DSR3H3mNPEpUNuPXuWOXQmMh77BlDVxDH4oxDqn5ZwbG2DC
	T0S45+fevODdlqECn05+3HlLaIWIx5M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-8Hwyjs1AMcO5Qn1GU5Wa5w-1; Mon, 20 May 2024 13:27:14 -0400
X-MC-Unique: 8Hwyjs1AMcO5Qn1GU5Wa5w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41ff6049fdbso54830785e9.0
        for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 10:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716226033; x=1716830833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Wnrlx8Ze5f4eVrQIFsuBZ5dBRmGRAk/pP24qmNaV1o=;
        b=bcNADiBkWCPg33TqNcRFL+LDhu5a3xXg6jQSoV+RTSF7Oi8Ft9UtFlimo2/ncY1iu6
         yam4pSkzhy8X7qVKJjdtzXsLz98RI+e7N31vDVBKcDrsohqbHOaqrB/GVsuJthkQYvcL
         LZC/tZ6sMRDI8lT5jehd8ox6ZarT7n5R0TFfuU3DQYZcDGA3+B45QT9GjjhD9K32e3cG
         jlHOeKIphGXA9q0PMd1wxPgrJ1rnK3yffYC3FfVAwWccKKJvrNnGllWC4VQUKXfGGcqK
         ztiENO/eYz7tiEa1yfTfC0mrkq4MCmQ6EgWktyhQ51Gtk2YalevAkMTjsir1r3lDEPOn
         9QKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW049xlm+iQw4+0hbaT+2EL45MXufVCnEdzcllJU3Ybn3cGzO9JZfNBt5/KfqOoGeNW3NCH6RBMXbVBFOY66pFseHjRTMOASA3/
X-Gm-Message-State: AOJu0YxsdgG34+QUzk6qnSRpNgEkXKV8Y37NBpP4y0LYZnn5c9zBJHiG
	i3eyEBlcZc3AgPc9oIKizAp1HDGDu60xQw4Gy7hfZQ0S2EzhG0sJv+KH5pfUyfgK6m4otxI5cPb
	BnjDE6TG/gi6ETQOCTyK9KT8cnljYe/8HNhfgHhuIBi+GLedDmNhjpXY86w==
X-Received: by 2002:a05:600c:1c84:b0:420:29dd:84df with SMTP id 5b1f17b1804b1-42029dd8775mr125127055e9.6.1716226032664;
        Mon, 20 May 2024 10:27:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlR0P93NDSEN+c3uilX1UD/l/rtLF9q10KC2o8WHFlFlK9VFo1eKLTW22d/kSe0Iv2GKa+KQ==
X-Received: by 2002:a05:600c:1c84:b0:420:29dd:84df with SMTP id 5b1f17b1804b1-42029dd8775mr125126795e9.6.1716226032228;
        Mon, 20 May 2024 10:27:12 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce25casm426922425e9.20.2024.05.20.10.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 10:27:11 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	airlied@gmail.com,
	fujita.tomonori@gmail.com,
	lina@asahilina.net,
	pstanner@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [RFC PATCH 05/11] rust: add revocable objects
Date: Mon, 20 May 2024 19:25:42 +0200
Message-ID: <20240520172554.182094-6-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240520172554.182094-1-dakr@redhat.com>
References: <20240520172554.182094-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <wedsonaf@gmail.com>

This implements the Revocable and AsyncRevocable types.

Revocable allows access to objects to be safely revoked at run time.

This is useful, for example, for resources allocated during device probe;
when the device is removed, the driver should stop accessing the device
resources even if other state is kept in memory due to existing
references (i.e., device context data is ref-counted and has a non-zero
refcount after removal of the device).

AsyncRevocable allows access to objects to be revoked without having to
wait for existing users to complete. This will be used to drop futures
in tasks when executors are being torn down.

Co-developed-by: Andreas Hindborg <a.hindborg@samsung.com>
Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/lib.rs       |   1 +
 rust/kernel/revocable.rs | 441 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 442 insertions(+)
 create mode 100644 rust/kernel/revocable.rs

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 698121c925f3..d7d415429517 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -40,6 +40,7 @@
 pub mod net;
 pub mod prelude;
 pub mod print;
+pub mod revocable;
 mod static_assert;
 #[doc(hidden)]
 pub mod std_vendor;
diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
new file mode 100644
index 000000000000..71408039a117
--- /dev/null
+++ b/rust/kernel/revocable.rs
@@ -0,0 +1,441 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Revocable objects.
+//!
+//! The [`Revocable`] type wraps other types and allows access to them to be revoked. The existence
+//! of a [`RevocableGuard`] ensures that objects remain valid.
+
+use crate::{
+    bindings,
+    init::{self},
+    prelude::*,
+    sync::rcu,
+};
+use core::{
+    cell::UnsafeCell,
+    marker::PhantomData,
+    mem::MaybeUninit,
+    ops::Deref,
+    ptr::drop_in_place,
+    sync::atomic::{fence, AtomicBool, AtomicU32, Ordering},
+};
+
+/// An object that can become inaccessible at runtime.
+///
+/// Once access is revoked and all concurrent users complete (i.e., all existing instances of
+/// [`RevocableGuard`] are dropped), the wrapped object is also dropped.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::revocable::Revocable;
+///
+/// struct Example {
+///     a: u32,
+///     b: u32,
+/// }
+///
+/// fn add_two(v: &Revocable<Example>) -> Option<u32> {
+///     let guard = v.try_access()?;
+///     Some(guard.a + guard.b)
+/// }
+///
+/// let v = Revocable::new(Example { a: 10, b: 20 });
+/// assert_eq!(add_two(&v), Some(30));
+/// v.revoke();
+/// assert_eq!(add_two(&v), None);
+/// ```
+///
+/// Sample example as above, but explicitly using the rcu read side lock.
+///
+/// ```
+/// # use kernel::revocable::Revocable;
+/// use kernel::sync::rcu;
+///
+/// struct Example {
+///     a: u32,
+///     b: u32,
+/// }
+///
+/// fn add_two(v: &Revocable<Example>) -> Option<u32> {
+///     let guard = rcu::read_lock();
+///     let e = v.try_access_with_guard(&guard)?;
+///     Some(e.a + e.b)
+/// }
+///
+/// let v = Revocable::new(Example { a: 10, b: 20 });
+/// assert_eq!(add_two(&v), Some(30));
+/// v.revoke();
+/// assert_eq!(add_two(&v), None);
+/// ```
+#[pin_data(PinnedDrop)]
+pub struct Revocable<T> {
+    is_available: AtomicBool,
+    #[pin]
+    data: MaybeUninit<UnsafeCell<T>>,
+}
+
+// SAFETY: `Revocable` is `Send` if the wrapped object is also `Send`. This is because while the
+// functionality exposed by `Revocable` can be accessed from any thread/CPU, it is possible that
+// this isn't supported by the wrapped object.
+unsafe impl<T: Send> Send for Revocable<T> {}
+
+// SAFETY: `Revocable` is `Sync` if the wrapped object is both `Send` and `Sync`. We require `Send`
+// from the wrapped object as well because  of `Revocable::revoke`, which can trigger the `Drop`
+// implementation of the wrapped object from an arbitrary thread.
+unsafe impl<T: Sync + Send> Sync for Revocable<T> {}
+
+impl<T> Revocable<T> {
+    /// Creates a new revocable instance of the given data.
+    pub fn new(data: impl PinInit<T>) -> impl PinInit<Self> {
+        pin_init!(Self {
+            is_available: AtomicBool::new(true),
+            data <- unsafe {
+                init::pin_init_from_closure(move |slot: *mut MaybeUninit<UnsafeCell<T>>| {
+                    init::PinInit::<T, core::convert::Infallible>::__pinned_init(data,
+                                                                                 slot as *mut T)?;
+                    Ok::<(), core::convert::Infallible>(())
+                })
+            },
+        })
+    }
+
+    /// Tries to access the \[revocable\] wrapped object.
+    ///
+    /// Returns `None` if the object has been revoked and is therefore no longer accessible.
+    ///
+    /// Returns a guard that gives access to the object otherwise; the object is guaranteed to
+    /// remain accessible while the guard is alive. In such cases, callers are not allowed to sleep
+    /// because another CPU may be waiting to complete the revocation of this object.
+    pub fn try_access(&self) -> Option<RevocableGuard<'_, T>> {
+        let guard = rcu::read_lock();
+        if self.is_available.load(Ordering::Relaxed) {
+            // SAFETY: Since `self.is_available` is true, data is initialised and has to remain
+            // valid because the RCU read side lock prevents it from being dropped.
+            Some(unsafe { RevocableGuard::new(self.data.assume_init_ref().get(), guard) })
+        } else {
+            None
+        }
+    }
+
+    /// Tries to access the \[revocable\] wrapped object.
+    ///
+    /// Returns `None` if the object has been revoked and is therefore no longer accessible.
+    ///
+    /// Returns a shared reference to the object otherwise; the object is guaranteed to
+    /// remain accessible while the rcu read side guard is alive. In such cases, callers are not
+    /// allowed to sleep because another CPU may be waiting to complete the revocation of this
+    /// object.
+    pub fn try_access_with_guard<'a>(&'a self, _guard: &'a rcu::Guard) -> Option<&'a T> {
+        if self.is_available.load(Ordering::Relaxed) {
+            // SAFETY: Since `self.is_available` is true, data is initialised and has to remain
+            // valid because the RCU read side lock prevents it from being dropped.
+            Some(unsafe { &*self.data.assume_init_ref().get() })
+        } else {
+            None
+        }
+    }
+
+    /// Revokes access to and drops the wrapped object.
+    ///
+    /// Access to the object is revoked immediately to new callers of [`Revocable::try_access`]. If
+    /// there are concurrent users of the object (i.e., ones that called [`Revocable::try_access`]
+    /// beforehand and still haven't dropped the returned guard), this function waits for the
+    /// concurrent access to complete before dropping the wrapped object.
+    pub fn revoke(&self) {
+        if self
+            .is_available
+            .compare_exchange(true, false, Ordering::Relaxed, Ordering::Relaxed)
+            .is_ok()
+        {
+            // SAFETY: Just an FFI call, there are no further requirements.
+            unsafe { bindings::synchronize_rcu() };
+
+            // SAFETY: We know `self.data` is valid because only one CPU can succeed the
+            // `compare_exchange` above that takes `is_available` from `true` to `false`.
+            unsafe { drop_in_place(self.data.assume_init_ref().get()) };
+        }
+    }
+}
+
+#[pinned_drop]
+impl<T> PinnedDrop for Revocable<T> {
+    fn drop(self: Pin<&mut Self>) {
+        // Drop only if the data hasn't been revoked yet (in which case it has already been
+        // dropped).
+        // SAFETY: We are not moving out of `p`, only dropping in place
+        let p = unsafe { self.get_unchecked_mut() };
+        if *p.is_available.get_mut() {
+            // SAFETY: We know `self.data` is valid because no other CPU has changed
+            // `is_available` to `false` yet, and no other CPU can do it anymore because this CPU
+            // holds the only reference (mutable) to `self` now.
+            unsafe { drop_in_place(p.data.assume_init_ref().get()) };
+        }
+    }
+}
+
+/// A guard that allows access to a revocable object and keeps it alive.
+///
+/// CPUs may not sleep while holding on to [`RevocableGuard`] because it's in atomic context
+/// holding the RCU read-side lock.
+///
+/// # Invariants
+///
+/// The RCU read-side lock is held while the guard is alive.
+pub struct RevocableGuard<'a, T> {
+    data_ref: *const T,
+    _rcu_guard: rcu::Guard,
+    _p: PhantomData<&'a ()>,
+}
+
+impl<T> RevocableGuard<'_, T> {
+    fn new(data_ref: *const T, rcu_guard: rcu::Guard) -> Self {
+        Self {
+            data_ref,
+            _rcu_guard: rcu_guard,
+            _p: PhantomData,
+        }
+    }
+}
+
+impl<T> Deref for RevocableGuard<'_, T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: By the type invariants, we hold the rcu read-side lock, so the object is
+        // guaranteed to remain valid.
+        unsafe { &*self.data_ref }
+    }
+}
+
+/// An object that can become inaccessible at runtime.
+///
+/// Once access is revoked and all concurrent users complete (i.e., all existing instances of
+/// [`AsyncRevocableGuard`] are dropped), the wrapped object is also dropped.
+///
+/// Unlike [`Revocable`], [`AsyncRevocable`] does not wait for concurrent users of the wrapped
+/// object to finish before [`AsyncRevocable::revoke`] completes -- thus the async qualifier. This
+/// has the advantage of not requiring RCU locks or waits of any kind.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::revocable::AsyncRevocable;
+///
+/// struct Example {
+///     a: u32,
+///     b: u32,
+/// }
+///
+/// fn add_two(v: &AsyncRevocable<Example>) -> Option<u32> {
+///     let guard = v.try_access()?;
+///     Some(guard.a + guard.b)
+/// }
+///
+/// let v = AsyncRevocable::new(Example { a: 10, b: 20 });
+/// assert_eq!(add_two(&v), Some(30));
+/// v.revoke();
+/// assert_eq!(add_two(&v), None);
+/// ```
+///
+/// Example where revocation happens while there is a user:
+///
+/// ```
+/// # use kernel::revocable::AsyncRevocable;
+/// use core::sync::atomic::{AtomicBool, Ordering};
+///
+/// struct Example {
+///     a: u32,
+///     b: u32,
+/// }
+///
+/// static DROPPED: AtomicBool = AtomicBool::new(false);
+///
+/// impl Drop for Example {
+///     fn drop(&mut self) {
+///         DROPPED.store(true, Ordering::Relaxed);
+///     }
+/// }
+///
+/// fn add_two(v: &AsyncRevocable<Example>) -> Option<u32> {
+///     let guard = v.try_access()?;
+///     Some(guard.a + guard.b)
+/// }
+///
+/// let v = AsyncRevocable::new(Example { a: 10, b: 20 });
+/// assert_eq!(add_two(&v), Some(30));
+///
+/// let guard = v.try_access().unwrap();
+/// assert!(!v.is_revoked());
+/// assert!(!DROPPED.load(Ordering::Relaxed));
+/// v.revoke();
+/// assert!(!DROPPED.load(Ordering::Relaxed));
+/// assert!(v.is_revoked());
+/// assert!(v.try_access().is_none());
+/// assert_eq!(guard.a + guard.b, 30);
+/// drop(guard);
+/// assert!(DROPPED.load(Ordering::Relaxed));
+/// ```
+pub struct AsyncRevocable<T> {
+    usage_count: AtomicU32,
+    data: MaybeUninit<UnsafeCell<T>>,
+}
+
+// SAFETY: `AsyncRevocable` is `Send` if the wrapped object is also `Send`. This is because while
+// the functionality exposed by `AsyncRevocable` can be accessed from any thread/CPU, it is
+// possible that this isn't supported by the wrapped object.
+unsafe impl<T: Send> Send for AsyncRevocable<T> {}
+
+// SAFETY: `AsyncRevocable` is `Sync` if the wrapped object is both `Send` and `Sync`. We require
+// `Send` from the wrapped object as well because  of `AsyncRevocable::revoke`, which can trigger
+// the `Drop` implementation of the wrapped object from an arbitrary thread.
+unsafe impl<T: Sync + Send> Sync for AsyncRevocable<T> {}
+
+const REVOKED: u32 = 0x80000000;
+const COUNT_MASK: u32 = !REVOKED;
+const SATURATED_COUNT: u32 = REVOKED - 1;
+
+impl<T> AsyncRevocable<T> {
+    /// Creates a new asynchronously revocable instance of the given data.
+    pub fn new(data: T) -> Self {
+        Self {
+            usage_count: AtomicU32::new(0),
+            data: MaybeUninit::new(UnsafeCell::new(data)),
+        }
+    }
+
+    /// Tries to access the \[revocable\] wrapped object.
+    ///
+    /// Returns `None` if the object has been revoked and is therefore no longer accessible.
+    ///
+    /// Returns a guard that gives access to the object otherwise; the object is guaranteed to
+    /// remain accessible while the guard is alive.
+    pub fn try_access(&self) -> Option<AsyncRevocableGuard<'_, T>> {
+        loop {
+            let count = self.usage_count.load(Ordering::Relaxed);
+
+            // Fail attempt to access if the object is already revoked.
+            if count & REVOKED != 0 {
+                return None;
+            }
+
+            // No need to increment if the count is saturated.
+            if count == SATURATED_COUNT
+                || self
+                    .usage_count
+                    .compare_exchange(count, count + 1, Ordering::Relaxed, Ordering::Relaxed)
+                    .is_ok()
+            {
+                return Some(AsyncRevocableGuard { revocable: self });
+            }
+        }
+    }
+
+    /// Revokes access to the protected object.
+    ///
+    /// Returns `true` if access has been revoked, or `false` when the object has already been
+    /// revoked by a previous call to [`AsyncRevocable::revoke`].
+    ///
+    /// This call is non-blocking, that is, no new users of the revocable object will be allowed,
+    /// but potential current users are able to continue to use it and the thread won't wait for
+    /// them to finish. In such cases, the object will be dropped when the last user completes.
+    pub fn revoke(&self) -> bool {
+        // Set the `REVOKED` bit.
+        //
+        // The acquire barrier matches up with the release when decrementing the usage count.
+        let prev = self.usage_count.fetch_or(REVOKED, Ordering::Acquire);
+        if prev & REVOKED != 0 {
+            // Another thread already revoked this object.
+            return false;
+        }
+
+        if prev == 0 {
+            // SAFETY: This thread just revoked the object and the usage count is zero, so the
+            // object is valid and there will be no future users.
+            unsafe { drop_in_place(UnsafeCell::raw_get(self.data.as_ptr())) };
+        }
+
+        true
+    }
+
+    /// Returns whether access to the object has been revoked.
+    pub fn is_revoked(&self) -> bool {
+        self.usage_count.load(Ordering::Relaxed) & REVOKED != 0
+    }
+}
+
+impl<T> Drop for AsyncRevocable<T> {
+    fn drop(&mut self) {
+        let count = *self.usage_count.get_mut();
+        if count != REVOKED {
+            // The object hasn't been dropped yet, so we do it now.
+
+            // This matches with the release when decrementing the usage count.
+            fence(Ordering::Acquire);
+
+            // SAFETY: Since `count` is does not indicate a count of 0 and the REVOKED bit set, the
+            // object is still valid.
+            unsafe { drop_in_place(UnsafeCell::raw_get(self.data.as_ptr())) };
+        }
+    }
+}
+
+/// A guard that allows access to a revocable object and keeps it alive.
+///
+/// # Invariants
+///
+/// The owner owns an increment on the usage count (which may have saturated it), which keeps the
+/// revocable object alive.
+pub struct AsyncRevocableGuard<'a, T> {
+    revocable: &'a AsyncRevocable<T>,
+}
+
+impl<T> Deref for AsyncRevocableGuard<'_, T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: The type invariants guarantee that the caller owns an increment.
+        unsafe { &*self.revocable.data.assume_init_ref().get() }
+    }
+}
+
+impl<T> Drop for AsyncRevocableGuard<'_, T> {
+    fn drop(&mut self) {
+        loop {
+            let count = self.revocable.usage_count.load(Ordering::Relaxed);
+            let actual_count = count & COUNT_MASK;
+            if actual_count == SATURATED_COUNT {
+                // The count is saturated, so we won't decrement (nor do we drop the object).
+                return;
+            }
+
+            if actual_count == 0 {
+                // Trying to underflow the count.
+                panic!("actual_count is zero");
+            }
+
+            // On success, we use release ordering, which matches with the acquire in one of the
+            // places where we drop the object, namely: below, in `AsyncRevocable::revoke`, or in
+            // `AsyncRevocable::drop`.
+            if self
+                .revocable
+                .usage_count
+                .compare_exchange(count, count - 1, Ordering::Release, Ordering::Relaxed)
+                .is_ok()
+            {
+                if count == 1 | REVOKED {
+                    // `count`  is now zero and it is revoked, so free it now.
+
+                    // This matches with the release above (which may have happened in other
+                    // threads concurrently).
+                    fence(Ordering::Acquire);
+
+                    // SAFETY: Since `count` was 1, the object is still alive.
+                    unsafe { drop_in_place(UnsafeCell::raw_get(self.revocable.data.as_ptr())) };
+                }
+
+                return;
+            }
+        }
+    }
+}
-- 
2.45.1


