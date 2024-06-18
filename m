Return-Path: <linux-pci+bounces-8944-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B97DB90E011
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 01:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F9B1F23C8C
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 23:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C1118EFE7;
	Tue, 18 Jun 2024 23:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ieZXq3e+"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CA218EFD0
	for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 23:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754071; cv=none; b=awCFvY2vS7H9DPuoGYNwYfQNvm0bCh14FTu4e1CEjo2HVpFMwSWRa5yf6P/ntJj7GvAlmAnIOcL8MvyT66CRTPGW4Nk83URNt6b4+0YM8S6s2w0bbDOJTHVVZJCTNmL2pD2bgxTTDdvm2TQj5gQt6C86uc/e8eVPRlDh4OtDvdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754071; c=relaxed/simple;
	bh=UUFxFHITd44dYQQCrdSR7AKzqHAzy/8/2oc53NIFk98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4ox4NNnal2QFLwr8/02ZB6XQNs8eRaMLj0Zs2Fd2HLf8R7kcJXx7AlWRduipS6DO/Rw+F88rk5s9J3l4F4atQQatDHBqeHAIjmUBpuBCqZJTH2DEO+cjh/UNMZS1Zjt4iTB/ZLuiDKYF6/dGff+cZkE67Yqr3PoYBzOSZKPZ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ieZXq3e+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718754068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bi44cMQJYS99EJNabY9/CKPO8kbpcfOs6bSOujDcKYk=;
	b=ieZXq3e+XQHYg2TBJWJC3L9l3/bmv3Ytx0lhTdMr4Vhfb2VVvIj1NcNKPECay3KUlW0UWk
	94S2h/+vbzvarYu4lFtywifaAdLBurC4mHg464GBVFRctftg+ahRolrgkEDxKLeJVHlzuq
	NajGkcSYauDFpE64y0rOqpAMoMHyeSw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-we408EiSM6-deLZzkSg4jQ-1; Tue, 18 Jun 2024 19:41:05 -0400
X-MC-Unique: we408EiSM6-deLZzkSg4jQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ec3cb4354bso4202761fa.3
        for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 16:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718754062; x=1719358862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bi44cMQJYS99EJNabY9/CKPO8kbpcfOs6bSOujDcKYk=;
        b=eeG4M7wcfitHGN/5gywY/7U5/Q3yU9Sv+jDfm5RMWu1Ac8zpDNsfwMXeR/4B9DrOpK
         wVyTY0oEGq1VBTk0TW8N40rXUPY5eezisKeRoSFueRUr6VtkDKtVrh36nRTPhsAon8Ru
         W9lSmn+JHjKhWde1TK14K9fJZpR9IcNz2ZuzC+8wuy0kLfmLSCQNn6Klt5wgV7K9H3kC
         zDZBEFQQIbGwNNJCTprPvQ5UR4lk1y5rw5N/NH7fx27fyCUN66TYOvROjgFws7mLXaBO
         AfyZ55iT/nY9ziw8pb9H+UEiBVxDYzZW5xkeF/u3A+mmLjIFsNJf6NTbItjrCTqEL1IU
         w0kg==
X-Forwarded-Encrypted: i=1; AJvYcCV7nJSF0JG/Y427wRgj1WW0VLPj7KaGQhIKtGYEMwYYlqAVP6RQGSIokaHz0YGZeadqK7takEKvAOYoGx33zrhiTT9Fq02mQv1q
X-Gm-Message-State: AOJu0YwTRhvM+bwR+V3d9ZQNublhaPrvQZNVT2DYZEa+9FNvnldkgsy4
	mWoDAH3pouTMP7VfbFMVl06zmXsmKWhzjPSh6DJ9V8VY4l3LiAGfdnMWDrba1VvaOxodabG8PIL
	kq49321uY3fZ+GNyQKQtpp34hQTtzYrAmD15qXHIYcsurpdbgAd4DN75sUg==
X-Received: by 2002:a2e:860e:0:b0:2ec:1a6:7b01 with SMTP id 38308e7fff4ca-2ec3cfe89ddmr6249761fa.33.1718754062207;
        Tue, 18 Jun 2024 16:41:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFgW1oPW6Telack7ZlNngY6AO2Ju8qX6ud+6J6wA8ngjmpZTBDF4ZgU97FkysKrX/11O2PFA==
X-Received: by 2002:a2e:860e:0:b0:2ec:1a6:7b01 with SMTP id 38308e7fff4ca-2ec3cfe89ddmr6249631fa.33.1718754061829;
        Tue, 18 Jun 2024 16:41:01 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36077536f78sm15232625f8f.7.2024.06.18.16.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 16:41:01 -0700 (PDT)
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
	lyude@redhat.com,
	robh@kernel.org,
	daniel.almeida@collabora.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH v2 05/10] rust: add `Revocable` type
Date: Wed, 19 Jun 2024 01:39:51 +0200
Message-ID: <20240618234025.15036-6-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240618234025.15036-1-dakr@redhat.com>
References: <20240618234025.15036-1-dakr@redhat.com>
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
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/lib.rs       |   1 +
 rust/kernel/revocable.rs | 209 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 210 insertions(+)
 create mode 100644 rust/kernel/revocable.rs

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 98e1a1425d17..601c3d3c9d54 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -43,6 +43,7 @@
 pub mod net;
 pub mod prelude;
 pub mod print;
+pub mod revocable;
 mod static_assert;
 #[doc(hidden)]
 pub mod std_vendor;
diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
new file mode 100644
index 000000000000..3d13e7b2f2e8
--- /dev/null
+++ b/rust/kernel/revocable.rs
@@ -0,0 +1,209 @@
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
+/// let v = Box::pin_init(Revocable::new(Example { a: 10, b: 20 }), GFP_KERNEL).unwrap();
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
+/// let v = Box::pin_init(Revocable::new(Example { a: 10, b: 20 }), GFP_KERNEL).unwrap();
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
-- 
2.45.1


