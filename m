Return-Path: <linux-pci+bounces-18693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EB99F6615
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 13:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A1EE7A3105
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 12:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399D11B0438;
	Wed, 18 Dec 2024 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsecNBgL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043971ACEBB;
	Wed, 18 Dec 2024 12:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734525531; cv=none; b=qx/QZAH/ECL0EZr/a/SpZ/HzOL/gWz1kNZEtGrwIqALQtKsy9Gdr/BxptNnws/zKU7JK6vgnUgfISeJBLyxBeYaz7BQgom+cJFvVHVoC+QZ+/XynhZ+KMrjleY5gGVtVHYgo3gAr7efiTtDpUJ4H79eM73xB6wc6nrjUfLF8MbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734525531; c=relaxed/simple;
	bh=2OTsU3J7r7LPomFBxDI1YLlstwgCJhxCK3/OJyvPlqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEdYikpaKhd0OAAQnktUmdYTuxtrvkBJjFBRyQyff4ecBBQMBljd0Bh9+pGZP0lyKxje2DNqjHdddQyRmbs449hNwzhCoiPJUH+Wd/MDvKsFDk9q7yDRIwVfwQTh9qoNmiNeidZyTAz/qU9NHjmQeF2TchTMQIxKRBl7mm1eyD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsecNBgL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDD8C4CECE;
	Wed, 18 Dec 2024 12:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734525530;
	bh=2OTsU3J7r7LPomFBxDI1YLlstwgCJhxCK3/OJyvPlqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LsecNBgLDQ5LlWd5JhkivZx18dnOSf+IX1sKq+MD3kL7mXr6kuTGxDlwdVUito5eo
	 7CnSomWbWw/c0Vd5AvMh//eNicJPycWSC4/oL0ZQYP0vxsL+QmdJDXxCQcJkmO7QZZ
	 9fT1o6iAaIx1ryuXJJfhz0aN2HzxS2Cp1m5fnxsxMiJWHwqVMOyeZWoi+bLSS4s8Q8
	 DIlfUOEcNNddaC4alrbWxLMMIdIvEDVnYxV9py7LhtGHMKQIkA7UrYfxANkR0NQs0o
	 mDi84lBa797/pV7apnqbvfbQWLwAB/KxgtboC1rcs7AFzFOcYntzJ/khxF+6TJx/Bn
	 7NyRrP5uX4/ag==
Date: Wed, 18 Dec 2024 13:38:41 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: =?iso-8859-1?Q?Beno=EEt?= du Garreau <benoit@dugarreau.fr>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com,
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	robh@kernel.org, daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com, paulmck@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	rcu@vger.kernel.org, Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: Re: [PATCH v6 06/16] rust: add `Revocable` type
Message-ID: <Z2LCUWdEERRodZpx@pollux>
References: <20241212163357.35934-7-dakr@kernel.org>
 <20241218122020.282671-1-benoit@dugarreau.fr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241218122020.282671-1-benoit@dugarreau.fr>

On Wed, Dec 18, 2024 at 01:20:20PM +0100, Benoît du Garreau wrote:
> On Thu, 12 Dec 2024 17:33:37 +0100 Danilo Krummrich <dakr@kernel.org> wrote:
> 
> > From: Wedson Almeida Filho <wedsonaf@gmail.com>
> >
> > Revocable allows access to objects to be safely revoked at run time.
> >
> > This is useful, for example, for resources allocated during device probe;
> > when the device is removed, the driver should stop accessing the device
> > resources even if another state is kept in memory due to existing
> > references (i.e., device context data is ref-counted and has a non-zero
> > refcount after removal of the device).
> >
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Co-developed-by: Danilo Krummrich <dakr@kernel.org>
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/lib.rs       |   1 +
> >  rust/kernel/revocable.rs | 223 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 224 insertions(+)
> >  create mode 100644 rust/kernel/revocable.rs
> >
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index 66149ac5c0c9..5702ce32ec8e 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -60,6 +60,7 @@
> >  pub mod prelude;
> >  pub mod print;
> >  pub mod rbtree;
> > +pub mod revocable;
> >  pub mod security;
> >  pub mod seq_file;
> >  pub mod sizes;
> > diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
> > new file mode 100644
> > index 000000000000..e464d59eb6b5
> > --- /dev/null
> > +++ b/rust/kernel/revocable.rs
> > @@ -0,0 +1,223 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Revocable objects.
> > +//!
> > +//! The [`Revocable`] type wraps other types and allows access to them to be revoked. The existence
> > +//! of a [`RevocableGuard`] ensures that objects remain valid.
> > +
> > +use crate::{bindings, prelude::*, sync::rcu, types::Opaque};
> > +use core::{
> > +    marker::PhantomData,
> > +    ops::Deref,
> > +    ptr::drop_in_place,
> > +    sync::atomic::{AtomicBool, Ordering},
> > +};
> > +
> > +/// An object that can become inaccessible at runtime.
> > +///
> > +/// Once access is revoked and all concurrent users complete (i.e., all existing instances of
> > +/// [`RevocableGuard`] are dropped), the wrapped object is also dropped.
> > +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// # use kernel::revocable::Revocable;
> > +///
> > +/// struct Example {
> > +///     a: u32,
> > +///     b: u32,
> > +/// }
> > +///
> > +/// fn add_two(v: &Revocable<Example>) -> Option<u32> {
> > +///     let guard = v.try_access()?;
> > +///     Some(guard.a + guard.b)
> > +/// }
> > +///
> > +/// let v = KBox::pin_init(Revocable::new(Example { a: 10, b: 20 }), GFP_KERNEL).unwrap();
> > +/// assert_eq!(add_two(&v), Some(30));
> > +/// v.revoke();
> > +/// assert_eq!(add_two(&v), None);
> > +/// ```
> > +///
> > +/// Sample example as above, but explicitly using the rcu read side lock.
> > +///
> > +/// ```
> > +/// # use kernel::revocable::Revocable;
> > +/// use kernel::sync::rcu;
> > +///
> > +/// struct Example {
> > +///     a: u32,
> > +///     b: u32,
> > +/// }
> > +///
> > +/// fn add_two(v: &Revocable<Example>) -> Option<u32> {
> > +///     let guard = rcu::read_lock();
> > +///     let e = v.try_access_with_guard(&guard)?;
> > +///     Some(e.a + e.b)
> > +/// }
> > +///
> > +/// let v = KBox::pin_init(Revocable::new(Example { a: 10, b: 20 }), GFP_KERNEL).unwrap();
> > +/// assert_eq!(add_two(&v), Some(30));
> > +/// v.revoke();
> > +/// assert_eq!(add_two(&v), None);
> > +/// ```
> > +#[pin_data(PinnedDrop)]
> > +pub struct Revocable<T> {
> > +    is_available: AtomicBool,
> > +    #[pin]
> > +    data: Opaque<T>,
> > +}
> > +
> > +// SAFETY: `Revocable` is `Send` if the wrapped object is also `Send`. This is because while the
> > +// functionality exposed by `Revocable` can be accessed from any thread/CPU, it is possible that
> > +// this isn't supported by the wrapped object.
> > +unsafe impl<T: Send> Send for Revocable<T> {}
> > +
> > +// SAFETY: `Revocable` is `Sync` if the wrapped object is both `Send` and `Sync`. We require `Send`
> > +// from the wrapped object as well because  of `Revocable::revoke`, which can trigger the `Drop`
> > +// implementation of the wrapped object from an arbitrary thread.
> > +unsafe impl<T: Sync + Send> Sync for Revocable<T> {}
> > +
> > +impl<T> Revocable<T> {
> > +    /// Creates a new revocable instance of the given data.
> > +    pub fn new(data: impl PinInit<T>) -> impl PinInit<Self> {
> > +        pin_init!(Self {
> > +            is_available: AtomicBool::new(true),
> > +            data <- Opaque::pin_init(data),
> > +        })
> > +    }
> > +
> > +    /// Tries to access the revocable wrapped object.
> > +    ///
> > +    /// Returns `None` if the object has been revoked and is therefore no longer accessible.
> > +    ///
> > +    /// Returns a guard that gives access to the object otherwise; the object is guaranteed to
> > +    /// remain accessible while the guard is alive. In such cases, callers are not allowed to sleep
> > +    /// because another CPU may be waiting to complete the revocation of this object.
> > +    pub fn try_access(&self) -> Option<RevocableGuard<'_, T>> {
> > +        let guard = rcu::read_lock();
> > +        if self.is_available.load(Ordering::Relaxed) {
> > +            // Since `self.is_available` is true, data is initialised and has to remain valid
> > +            // because the RCU read side lock prevents it from being dropped.
> > +            Some(RevocableGuard::new(self.data.get(), guard))
> > +        } else {
> > +            None
> > +        }
> > +    }
> > +
> > +    /// Tries to access the revocable wrapped object.
> > +    ///
> > +    /// Returns `None` if the object has been revoked and is therefore no longer accessible.
> > +    ///
> > +    /// Returns a shared reference to the object otherwise; the object is guaranteed to
> > +    /// remain accessible while the rcu read side guard is alive. In such cases, callers are not
> > +    /// allowed to sleep because another CPU may be waiting to complete the revocation of this
> > +    /// object.
> > +    pub fn try_access_with_guard<'a>(&'a self, _guard: &'a rcu::Guard) -> Option<&'a T> {
> > +        if self.is_available.load(Ordering::Relaxed) {
> > +            // SAFETY: Since `self.is_available` is true, data is initialised and has to remain
> > +            // valid because the RCU read side lock prevents it from being dropped.
> > +            Some(unsafe { &*self.data.get() })
> > +        } else {
> > +            None
> > +        }
> > +    }
> > +
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that there are no more concurrent users of the revocable object.
> > +    unsafe fn revoke_internal<const SYNC: bool>(&self) {
> > +        if self
> > +            .is_available
> > +            .compare_exchange(true, false, Ordering::Relaxed, Ordering::Relaxed)
> > +            .is_ok()
> > +        {
> 
> The comment I made in a previous series was somehow lost, so I put it back here:
> You can use `self.is_available.swap(false, Ordering::Relaxed)` instead of a CAS,
> it is IMO clearer and optimizes better on some architectures.

Thanks for bringing this up again!

> 
> > +            if SYNC {
> > +                // SAFETY: Just an FFI call, there are no further requirements.
> > +                unsafe { bindings::synchronize_rcu() };
> > +            }
> > +
> > +            // SAFETY: We know `self.data` is valid because only one CPU can succeed the
> > +            // `compare_exchange` above that takes `is_available` from `true` to `false`.
> > +            unsafe { drop_in_place(self.data.get()) };
> > +        }
> > +    }
> > +
> > +    /// Revokes access to and drops the wrapped object.
> > +    ///
> > +    /// Access to the object is revoked immediately to new callers of [`Revocable::try_access`],
> > +    /// expecting that there are no concurrent users of the object.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that there are no more concurrent users of the revocable object.
> > +    pub unsafe fn revoke_nosync(&self) {
> > +        // SAFETY: By the safety requirement of this function, the caller ensures that nobody is
> > +        // accessing the data anymore and hence we don't have to wait for the grace period to
> > +        // finish.
> > +        unsafe { self.revoke_internal::<false>() }
> > +    }
> > +
> > +    /// Revokes access to and drops the wrapped object.
> > +    ///
> > +    /// Access to the object is revoked immediately to new callers of [`Revocable::try_access`].
> > +    ///
> > +    /// If there are concurrent users of the object (i.e., ones that called
> > +    /// [`Revocable::try_access`] beforehand and still haven't dropped the returned guard), this
> > +    /// function waits for the concurrent access to complete before dropping the wrapped object.
> > +    pub fn revoke(&self) {
> > +        // SAFETY: By passing `true` we ask `revoke_internal` to wait for the grace period to
> > +        // finish.
> > +        unsafe { self.revoke_internal::<true>() }
> > +    }
> > +}
> > +
> > +#[pinned_drop]
> > +impl<T> PinnedDrop for Revocable<T> {
> > +    fn drop(self: Pin<&mut Self>) {
> > +        // Drop only if the data hasn't been revoked yet (in which case it has already been
> > +        // dropped).
> > +        // SAFETY: We are not moving out of `p`, only dropping in place
> > +        let p = unsafe { self.get_unchecked_mut() };
> > +        if *p.is_available.get_mut() {
> > +            // SAFETY: We know `self.data` is valid because no other CPU has changed
> > +            // `is_available` to `false` yet, and no other CPU can do it anymore because this CPU
> > +            // holds the only reference (mutable) to `self` now.
> > +            unsafe { drop_in_place(p.data.get()) };
> > +        }
> > +    }
> > +}
> > +
> > +/// A guard that allows access to a revocable object and keeps it alive.
> > +///
> > +/// CPUs may not sleep while holding on to [`RevocableGuard`] because it's in atomic context
> > +/// holding the RCU read-side lock.
> > +///
> > +/// # Invariants
> > +///
> > +/// The RCU read-side lock is held while the guard is alive.
> > +pub struct RevocableGuard<'a, T> {
> > +    data_ref: *const T,
> > +    _rcu_guard: rcu::Guard,
> > +    _p: PhantomData<&'a ()>,
> > +}
> > +
> > +impl<T> RevocableGuard<'_, T> {
> > +    fn new(data_ref: *const T, rcu_guard: rcu::Guard) -> Self {
> > +        Self {
> > +            data_ref,
> > +            _rcu_guard: rcu_guard,
> > +            _p: PhantomData,
> > +        }
> > +    }
> > +}
> > +
> > +impl<T> Deref for RevocableGuard<'_, T> {
> > +    type Target = T;
> > +
> > +    fn deref(&self) -> &Self::Target {
> > +        // SAFETY: By the type invariants, we hold the rcu read-side lock, so the object is
> > +        // guaranteed to remain valid.
> > +        unsafe { &*self.data_ref }
> > +    }
> > +}
> > --
> > 2.47.1
> >
> >
> 
> Benoît du Garreau

