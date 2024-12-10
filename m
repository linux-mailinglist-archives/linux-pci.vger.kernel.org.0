Return-Path: <linux-pci+bounces-18066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AF59EBE2C
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 23:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE4F286439
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 22:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CB2204692;
	Tue, 10 Dec 2024 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbjmd2q0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED47211265;
	Tue, 10 Dec 2024 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733871038; cv=none; b=ar2JTMwsKnkKqiIfOHHj8JshXyF8TjTOYJphP8SzR2DYSLbNPyK1GX0H+8VFaIuDeRBS74Va+cK/8McMwTSyqzjU7VWaCXyITqy2tQRwCuLHiam4oUXn3zhPZCb2Iq4T0P2eLXu2qqRZgRorxzagNHwhBiAKXr8XnY0M24Ewpmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733871038; c=relaxed/simple;
	bh=lKVyb7plfCS5PGmKV2fCdRmDJYcL/SsbyIHHDjEZYbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GeeBzcB6ZfgnZnON9xmQ3QN66AIN2WlJzROTI/ePQnmsdt7op3bzhedEJ+La20SEymIy05W+JoATMxF/l17hdmcgPoW9fR86gRiFQmIpSU9EgE+Ck57UOqqQ5265Xi9OlAfUfgGbs9SBvYFfUjYQBDjyo4iJzWIjPZ/5PqBHVcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbjmd2q0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96ED3C4CEE2;
	Tue, 10 Dec 2024 22:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733871037;
	bh=lKVyb7plfCS5PGmKV2fCdRmDJYcL/SsbyIHHDjEZYbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rbjmd2q0Au198wLjgF4lpaoDP7gl+qh4cknRsHFOiGvjkva8CcBVNodvWCwJuxGDZ
	 BvzFpeKXxG8P+r2SHKGRf3VExulSiQ9ycTwzCgj0+18N8dPL6u4psebyIM5V8BgV3n
	 fCg5XVeOPvHalOsMA/U/QqB1QbjkjynilRj0gVcs/2qjodfRBpF+Ntj+QisEZHcDe/
	 qPsOytdva4AY65Mr2tMl06sQmj7kzl8djCLDqBSlHIYgzT4Y2G746Al7Pchu0Ek8Cr
	 +YLOMmttLBFjYEu90ICV+wbtI8rgNuPQU9FYkKD0pIzN27P5j6MxZDNSIXFWNP5aUH
	 wyB3MC0qsdp+w==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	tmgross@umich.edu,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	airlied@gmail.com,
	fujita.tomonori@gmail.com,
	lina@asahilina.net,
	pstanner@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	robh@kernel.org,
	daniel.almeida@collabora.com,
	saravanak@google.com,
	dirk.behme@de.bosch.com,
	j@jannau.net,
	fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v5 06/16] rust: add `Revocable` type
Date: Tue, 10 Dec 2024 23:46:33 +0100
Message-ID: <20241210224947.23804-7-dakr@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241210224947.23804-1-dakr@kernel.org>
References: <20241210224947.23804-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Revocable allows access to objects to be safely revoked at run time.

This is useful, for example, for resources allocated during device probe;
when the device is removed, the driver should stop accessing the device
resources even if another state is kept in memory due to existing
references (i.e., device context data is ref-counted and has a non-zero
refcount after removal of the device).

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/lib.rs       |   1 +
 rust/kernel/revocable.rs | 223 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 224 insertions(+)
 create mode 100644 rust/kernel/revocable.rs

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index b5da7c520eb8..200c5f99a805 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -60,6 +60,7 @@
 pub mod prelude;
 pub mod print;
 pub mod rbtree;
+pub mod revocable;
 pub mod security;
 pub mod seq_file;
 pub mod sizes;
diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
new file mode 100644
index 000000000000..e464d59eb6b5
--- /dev/null
+++ b/rust/kernel/revocable.rs
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Revocable objects.
+//!
+//! The [`Revocable`] type wraps other types and allows access to them to be revoked. The existence
+//! of a [`RevocableGuard`] ensures that objects remain valid.
+
+use crate::{bindings, prelude::*, sync::rcu, types::Opaque};
+use core::{
+    marker::PhantomData,
+    ops::Deref,
+    ptr::drop_in_place,
+    sync::atomic::{AtomicBool, Ordering},
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
+/// let v = KBox::pin_init(Revocable::new(Example { a: 10, b: 20 }), GFP_KERNEL).unwrap();
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
+/// let v = KBox::pin_init(Revocable::new(Example { a: 10, b: 20 }), GFP_KERNEL).unwrap();
+/// assert_eq!(add_two(&v), Some(30));
+/// v.revoke();
+/// assert_eq!(add_two(&v), None);
+/// ```
+#[pin_data(PinnedDrop)]
+pub struct Revocable<T> {
+    is_available: AtomicBool,
+    #[pin]
+    data: Opaque<T>,
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
+            data <- Opaque::pin_init(data),
+        })
+    }
+
+    /// Tries to access the revocable wrapped object.
+    ///
+    /// Returns `None` if the object has been revoked and is therefore no longer accessible.
+    ///
+    /// Returns a guard that gives access to the object otherwise; the object is guaranteed to
+    /// remain accessible while the guard is alive. In such cases, callers are not allowed to sleep
+    /// because another CPU may be waiting to complete the revocation of this object.
+    pub fn try_access(&self) -> Option<RevocableGuard<'_, T>> {
+        let guard = rcu::read_lock();
+        if self.is_available.load(Ordering::Relaxed) {
+            // Since `self.is_available` is true, data is initialised and has to remain valid
+            // because the RCU read side lock prevents it from being dropped.
+            Some(RevocableGuard::new(self.data.get(), guard))
+        } else {
+            None
+        }
+    }
+
+    /// Tries to access the revocable wrapped object.
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
+            Some(unsafe { &*self.data.get() })
+        } else {
+            None
+        }
+    }
+
+    /// # Safety
+    ///
+    /// Callers must ensure that there are no more concurrent users of the revocable object.
+    unsafe fn revoke_internal<const SYNC: bool>(&self) {
+        if self
+            .is_available
+            .compare_exchange(true, false, Ordering::Relaxed, Ordering::Relaxed)
+            .is_ok()
+        {
+            if SYNC {
+                // SAFETY: Just an FFI call, there are no further requirements.
+                unsafe { bindings::synchronize_rcu() };
+            }
+
+            // SAFETY: We know `self.data` is valid because only one CPU can succeed the
+            // `compare_exchange` above that takes `is_available` from `true` to `false`.
+            unsafe { drop_in_place(self.data.get()) };
+        }
+    }
+
+    /// Revokes access to and drops the wrapped object.
+    ///
+    /// Access to the object is revoked immediately to new callers of [`Revocable::try_access`],
+    /// expecting that there are no concurrent users of the object.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that there are no more concurrent users of the revocable object.
+    pub unsafe fn revoke_nosync(&self) {
+        // SAFETY: By the safety requirement of this function, the caller ensures that nobody is
+        // accessing the data anymore and hence we don't have to wait for the grace period to
+        // finish.
+        unsafe { self.revoke_internal::<false>() }
+    }
+
+    /// Revokes access to and drops the wrapped object.
+    ///
+    /// Access to the object is revoked immediately to new callers of [`Revocable::try_access`].
+    ///
+    /// If there are concurrent users of the object (i.e., ones that called
+    /// [`Revocable::try_access`] beforehand and still haven't dropped the returned guard), this
+    /// function waits for the concurrent access to complete before dropping the wrapped object.
+    pub fn revoke(&self) {
+        // SAFETY: By passing `true` we ask `revoke_internal` to wait for the grace period to
+        // finish.
+        unsafe { self.revoke_internal::<true>() }
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
+            unsafe { drop_in_place(p.data.get()) };
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
-- 
2.47.0


