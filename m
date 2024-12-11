Return-Path: <linux-pci+bounces-18118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC549ECB6B
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 12:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E636F166444
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 11:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86972211A04;
	Wed, 11 Dec 2024 11:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dugarreau.fr header.i=benoit@dugarreau.fr header.b="XQQSx3BJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED0F211289;
	Wed, 11 Dec 2024 11:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733916977; cv=none; b=pWhEjwZynNgWqR9vHCIHCdp0WBlDB+ax3yXK6Okx9gPsdVfv0UWnJ4XVkvEdSdAcwTwsFGq0U4dabwX7EOcwrSFA+trShw/1Vdt2hJSnuB54vByStfi0yIGPBkFm+cdQDbmT+rCTf/84vHc+cSHn7YCLRIfs2XYj/An0+ZckziM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733916977; c=relaxed/simple;
	bh=m1o0RIinvCt1Ohk7MYDWIc5IJMvqG+Rh2fyi4c0uxYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UG3z29+TxUTkszk4qYvfVlyBasARSo0xol+MXUZmpv37/1WBG/jq+aGNN4oiSZBzVxjyHe3M9UAh9yXg7LaUKVgB1QEoHDbdBlfdcUz0Uc3TsEVjwTJSpf/4AoxgjcPwyexP78KIhTE9WPkWbVue/TJvS5DSaB1kJuEGY+cWSJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dugarreau.fr; spf=pass smtp.mailfrom=dugarreau.fr; dkim=pass (2048-bit key) header.d=dugarreau.fr header.i=benoit@dugarreau.fr header.b=XQQSx3BJ; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dugarreau.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dugarreau.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dugarreau.fr;
	s=s1-ionos; t=1733916956; x=1734521756; i=benoit@dugarreau.fr;
	bh=d4WY3x3jOSNKzGRcRrphWZx84KyLumAbcYn773jcWKU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XQQSx3BJ94h8THATPiSsLyxwaFKMk8aXmcHX5HDXLNPlvah4rIVe1FbxxJAS7Xd2
	 tVFV93n+XJ7SMQlcIAafFFdBfXTo3vUqdTL0me5croVM2Pjf5ph9JT0QzWLxqWCAt
	 eOZO9eD737e1vQ3NFtIzRnovfe2krcMv/frRkNYGnWPxtqPoB4oIyd1yMhKZxR7JQ
	 4Zi6FUYgBZGSxjIdgKySf2U4XDXWD8NZxtAZsaqFa2IuimVT6NYcmQuIKCy0QtTLE
	 HDXYec4BOgoGrKz4uOuPzMVn0Tj/0KnOP5Gkb7JoQG2ZggswKKx4FajWsZBB4Y2yh
	 i8nQImf/Duk1aw2QLw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from debian.hades.lan ([185.116.133.150]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis)
 id 1N6bwO-1tgoYD31Go-00tUaj; Wed, 11 Dec 2024 11:48:16 +0100
From: =?UTF-8?q?Beno=C3=AEt=20du=20Garreau?= <benoit@dugarreau.fr>
To: Danilo Krummrich <dakr@kernel.org>
Cc: =?UTF-8?q?Beno=C3=AEt=20du=20Garreau?= <benoit@dugarreau.fr>,
	gregkh@linuxfoundation.org,
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
	chrisi.schrefl@gmail.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: Re: [PATCH v5 06/16] rust: add `Revocable` type
Date: Wed, 11 Dec 2024 11:47:42 +0100
Message-Id: <20241211104742.533392-1-benoit@dugarreau.fr>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210224947.23804-7-dakr@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:64odCHMSGqPoMrgIdNJfU8I+j8SjW8ZnizmMkbsuGTHKIysu6Me
 sayZvKsYD0iEZGQ+FEEBSPPeRxRp++eh5KrxTpOwBHJwjD+WxeOwlWsBnlmR77SAu8VtCBK
 73FA6gsD1fZEkvF4mcvvhVzGD/MGDQMS+gbbmrjBZu1IzTjkeYNnFN1VefySAMtT9f9QRDv
 WOeVOWqzjgGGsaXSQ6otA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hyXkb2Jc66w=;30MJaNxDf7coB0FE94XPn7asitJ
 QxwIMkFw9QTLnGLJXLlerz2t6r/O+aivYSDIcrExNObAvxe4tALvyklNgOPabXZGaqRm5Z0tD
 ywIPPWMBE+t7Fah4ARQVhp9QGQiWzbwW5dsCJLz7QkgjsEcT5IuIafBPZP/LIBcWMiD7LeTFu
 wbeXH3kg5XfmjxRzT96ZAZE2/YhepGsr66IOPHRZz+gEXx+kiPlZsYTO0C3qxRW3Uw6F0kQFR
 5H57ACIZ83g7ChkJHgATivhWg3a2t+gJ45ILpt2Bl7MRx87oD6m5OMGn9TLsd0UYDK+EmiSQl
 Tc+mU630YOyYEdrh9R58KHpNmJ1X3HZZB68ZrWs559f5KpX/dWl4nivd4WJ+bx0aWfvf+twt2
 01EOPlCJFptagp0hJP/70gfvCtZvet8xGmq4U8GL+a4WDY4JQte0j0/WPxxteZiqD0VhjEIHw
 bSLHw8JC2eHm1SbyDl2M8nMbVZlrmIi/gTDUf2Hxo5YdFqN+0Q8PuQQj3HHxqGu6FxK201xNN
 66o+yl1TgRD6/gonb85h54BQUlYgALzC6z7PfrzkIaZU1wWwIrZxpz/SwwvWHv7oqTdTuaQ1S
 e80fdX2OKAPxlhs3Ul3B/7Z2uqA6bvPC1D2xEIB9EhiDSQInRj8ZAsKKxLYGy0OsSe3pg++xr
 jH8UaBjOD4gvPNXfntc0NdrDANXSeczvlWxKoYiL61XYTsKXnab7XNfiuD0LI47x+a5ynIFaR
 ywcM9XzWu/Uq+R8iohIlyjhh1RP1LLVAhE7vXAwLnMPnRjTP+1O2hXme57d2HrWsfnJZTnjSQ
 sAdj3JCbWGLauTGHD67OHYTOoj10nSuS/pg3N28QJZA7+xuYlUtaEOi8xNH4bHftV0SR5n2PF
 THevZYToRdYytFrSWuwmgclcEGdG8TE5mZIOuk1ZUk+Vsa0ZLlTVoR/tJFi0cvHt4ItDZfVZk
 /Hwazr6uFMyxG2d1/bNUvae9PfvIo/GC55XZzhdhgvfI9H7KLBzCJ1zHZfe2Blb+EVBsG7Nnp
 x+SIQfiO9DUQ1B68c+jYznZZelCabxfUL6xhYKP

On Tue, 10 Dec 2024 23:46:33 +0100 Danilo Krummrich <dakr@kernel.org> wrot=
e:

> From: Wedson Almeida Filho <wedsonaf@gmail.com>
>
> Revocable allows access to objects to be safely revoked at run time.
>
> This is useful, for example, for resources allocated during device probe=
;
> when the device is removed, the driver should stop accessing the device
> resources even if another state is kept in memory due to existing
> references (i.e., device context data is ref-counted and has a non-zero
> refcount after removal of the device).
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/lib.rs       |   1 +
>  rust/kernel/revocable.rs | 223 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 224 insertions(+)
>  create mode 100644 rust/kernel/revocable.rs
>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index b5da7c520eb8..200c5f99a805 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -60,6 +60,7 @@
>  pub mod prelude;
>  pub mod print;
>  pub mod rbtree;
> +pub mod revocable;
>  pub mod security;
>  pub mod seq_file;
>  pub mod sizes;
> diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
> new file mode 100644
> index 000000000000..e464d59eb6b5
> --- /dev/null
> +++ b/rust/kernel/revocable.rs
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Revocable objects.
> +//!
> +//! The [`Revocable`] type wraps other types and allows access to them =
to be revoked. The existence
> +//! of a [`RevocableGuard`] ensures that objects remain valid.
> +
> +use crate::{bindings, prelude::*, sync::rcu, types::Opaque};
> +use core::{
> +    marker::PhantomData,
> +    ops::Deref,
> +    ptr::drop_in_place,
> +    sync::atomic::{AtomicBool, Ordering},
> +};
> +
> +/// An object that can become inaccessible at runtime.
> +///
> +/// Once access is revoked and all concurrent users complete (i.e., all=
 existing instances of
> +/// [`RevocableGuard`] are dropped), the wrapped object is also dropped=
.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// # use kernel::revocable::Revocable;
> +///
> +/// struct Example {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// fn add_two(v: &Revocable<Example>) -> Option<u32> {
> +///     let guard =3D v.try_access()?;
> +///     Some(guard.a + guard.b)
> +/// }
> +///
> +/// let v =3D KBox::pin_init(Revocable::new(Example { a: 10, b: 20 }), =
GFP_KERNEL).unwrap();
> +/// assert_eq!(add_two(&v), Some(30));
> +/// v.revoke();
> +/// assert_eq!(add_two(&v), None);
> +/// ```
> +///
> +/// Sample example as above, but explicitly using the rcu read side loc=
k.
> +///
> +/// ```
> +/// # use kernel::revocable::Revocable;
> +/// use kernel::sync::rcu;
> +///
> +/// struct Example {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// fn add_two(v: &Revocable<Example>) -> Option<u32> {
> +///     let guard =3D rcu::read_lock();
> +///     let e =3D v.try_access_with_guard(&guard)?;
> +///     Some(e.a + e.b)
> +/// }
> +///
> +/// let v =3D KBox::pin_init(Revocable::new(Example { a: 10, b: 20 }), =
GFP_KERNEL).unwrap();
> +/// assert_eq!(add_two(&v), Some(30));
> +/// v.revoke();
> +/// assert_eq!(add_two(&v), None);
> +/// ```
> +#[pin_data(PinnedDrop)]
> +pub struct Revocable<T> {
> +    is_available: AtomicBool,
> +    #[pin]
> +    data: Opaque<T>,
> +}
> +
> +// SAFETY: `Revocable` is `Send` if the wrapped object is also `Send`. =
This is because while the
> +// functionality exposed by `Revocable` can be accessed from any thread=
/CPU, it is possible that
> +// this isn't supported by the wrapped object.
> +unsafe impl<T: Send> Send for Revocable<T> {}
> +
> +// SAFETY: `Revocable` is `Sync` if the wrapped object is both `Send` a=
nd `Sync`. We require `Send`
> +// from the wrapped object as well because  of `Revocable::revoke`, whi=
ch can trigger the `Drop`
> +// implementation of the wrapped object from an arbitrary thread.
> +unsafe impl<T: Sync + Send> Sync for Revocable<T> {}
> +
> +impl<T> Revocable<T> {
> +    /// Creates a new revocable instance of the given data.
> +    pub fn new(data: impl PinInit<T>) -> impl PinInit<Self> {
> +        pin_init!(Self {
> +            is_available: AtomicBool::new(true),
> +            data <- Opaque::pin_init(data),
> +        })
> +    }
> +
> +    /// Tries to access the revocable wrapped object.
> +    ///
> +    /// Returns `None` if the object has been revoked and is therefore =
no longer accessible.
> +    ///
> +    /// Returns a guard that gives access to the object otherwise; the =
object is guaranteed to
> +    /// remain accessible while the guard is alive. In such cases, call=
ers are not allowed to sleep
> +    /// because another CPU may be waiting to complete the revocation o=
f this object.
> +    pub fn try_access(&self) -> Option<RevocableGuard<'_, T>> {
> +        let guard =3D rcu::read_lock();
> +        if self.is_available.load(Ordering::Relaxed) {
> +            // Since `self.is_available` is true, data is initialised a=
nd has to remain valid
> +            // because the RCU read side lock prevents it from being dr=
opped.
> +            Some(RevocableGuard::new(self.data.get(), guard))
> +        } else {
> +            None
> +        }
> +    }
> +
> +    /// Tries to access the revocable wrapped object.
> +    ///
> +    /// Returns `None` if the object has been revoked and is therefore =
no longer accessible.
> +    ///
> +    /// Returns a shared reference to the object otherwise; the object =
is guaranteed to
> +    /// remain accessible while the rcu read side guard is alive. In su=
ch cases, callers are not
> +    /// allowed to sleep because another CPU may be waiting to complete=
 the revocation of this
> +    /// object.
> +    pub fn try_access_with_guard<'a>(&'a self, _guard: &'a rcu::Guard) =
-> Option<&'a T> {
> +        if self.is_available.load(Ordering::Relaxed) {
> +            // SAFETY: Since `self.is_available` is true, data is initi=
alised and has to remain
> +            // valid because the RCU read side lock prevents it from be=
ing dropped.
> +            Some(unsafe { &*self.data.get() })
> +        } else {
> +            None
> +        }
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that there are no more concurrent users of =
the revocable object.
> +    unsafe fn revoke_internal<const SYNC: bool>(&self) {
> +        if self
> +            .is_available
> +            .compare_exchange(true, false, Ordering::Relaxed, Ordering:=
:Relaxed)
> +            .is_ok()

This can be simplified to `if self.is_available.swap(false, Ordering::Rela=
xed) {`

> +        {
> +            if SYNC {
> +                // SAFETY: Just an FFI call, there are no further requi=
rements.
> +                unsafe { bindings::synchronize_rcu() };
> +            }
> +
> +            // SAFETY: We know `self.data` is valid because only one CP=
U can succeed the
> +            // `compare_exchange` above that takes `is_available` from =
`true` to `false`.
> +            unsafe { drop_in_place(self.data.get()) };
> +        }
> +    }
> +
> +    /// Revokes access to and drops the wrapped object.
> +    ///
> +    /// Access to the object is revoked immediately to new callers of [=
`Revocable::try_access`],
> +    /// expecting that there are no concurrent users of the object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that there are no more concurrent users of =
the revocable object.
> +    pub unsafe fn revoke_nosync(&self) {
> +        // SAFETY: By the safety requirement of this function, the call=
er ensures that nobody is
> +        // accessing the data anymore and hence we don't have to wait f=
or the grace period to
> +        // finish.
> +        unsafe { self.revoke_internal::<false>() }
> +    }
> +
> +    /// Revokes access to and drops the wrapped object.
> +    ///
> +    /// Access to the object is revoked immediately to new callers of [=
`Revocable::try_access`].
> +    ///
> +    /// If there are concurrent users of the object (i.e., ones that ca=
lled
> +    /// [`Revocable::try_access`] beforehand and still haven't dropped =
the returned guard), this
> +    /// function waits for the concurrent access to complete before dro=
pping the wrapped object.
> +    pub fn revoke(&self) {
> +        // SAFETY: By passing `true` we ask `revoke_internal` to wait f=
or the grace period to
> +        // finish.
> +        unsafe { self.revoke_internal::<true>() }
> +    }
> +}
> +
> +#[pinned_drop]
> +impl<T> PinnedDrop for Revocable<T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        // Drop only if the data hasn't been revoked yet (in which case=
 it has already been
> +        // dropped).
> +        // SAFETY: We are not moving out of `p`, only dropping in place
> +        let p =3D unsafe { self.get_unchecked_mut() };
> +        if *p.is_available.get_mut() {
> +            // SAFETY: We know `self.data` is valid because no other CP=
U has changed
> +            // `is_available` to `false` yet, and no other CPU can do i=
t anymore because this CPU
> +            // holds the only reference (mutable) to `self` now.
> +            unsafe { drop_in_place(p.data.get()) };
> +        }
> +    }
> +}
> +
> +/// A guard that allows access to a revocable object and keeps it alive=
.
> +///
> +/// CPUs may not sleep while holding on to [`RevocableGuard`] because i=
t's in atomic context
> +/// holding the RCU read-side lock.
> +///
> +/// # Invariants
> +///
> +/// The RCU read-side lock is held while the guard is alive.
> +pub struct RevocableGuard<'a, T> {
> +    data_ref: *const T,
> +    _rcu_guard: rcu::Guard,
> +    _p: PhantomData<&'a ()>,
> +}

Shouldn't this type hold a `&'a T` directly instead of a raw pointer ?

> +
> +impl<T> RevocableGuard<'_, T> {
> +    fn new(data_ref: *const T, rcu_guard: rcu::Guard) -> Self {
> +        Self {
> +            data_ref,
> +            _rcu_guard: rcu_guard,
> +            _p: PhantomData,
> +        }
> +    }
> +}
> +
> +impl<T> Deref for RevocableGuard<'_, T> {
> +    type Target =3D T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: By the type invariants, we hold the rcu read-side lo=
ck, so the object is
> +        // guaranteed to remain valid.
> +        unsafe { &*self.data_ref }
> +    }
> +}
> --
> 2.47.0

Beno=C3=AEt du Garreau

