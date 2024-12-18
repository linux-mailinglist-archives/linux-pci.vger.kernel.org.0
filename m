Return-Path: <linux-pci+bounces-18692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6F89F65DA
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 13:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949FD1895B2E
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 12:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875811A23A2;
	Wed, 18 Dec 2024 12:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dugarreau.fr header.i=benoit@dugarreau.fr header.b="eJ047SDD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB70D19CC36;
	Wed, 18 Dec 2024 12:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734524514; cv=none; b=QoM1oKp1TsiYhbHWURrqtU7IelhTMLzGmG4sLLObm040cJKmkGCtqV+ybB/fxFhtIhhx8JOY/WWC2I4S+OvS5hOZz9YzsftLOkwHVUs6lArhOoiIMHIFccy8pusbIzW72zaFUUkrzGsrDPRBYtcaecUKB836BFqRbmAzUIdonSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734524514; c=relaxed/simple;
	bh=PA/fvIge62GLHKx9p+80LVuJOtzH+HlV4Ric5so3zJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ca1NYUq68mYsU+X0cKhJiplw94I2ClUvlNNIb1M00WCBmlVwlfKsncjkU1bLcZIZ6VBXcFd2XNTwdm7H0OJARiFvgbakNCoc+idqUTX4gal8Lp7pX+Qc1b4FP6QDspZiMDrIpgq/WvDMweilOFTSEU6i5k1Dno2kngQfC7m5qnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dugarreau.fr; spf=pass smtp.mailfrom=dugarreau.fr; dkim=pass (2048-bit key) header.d=dugarreau.fr header.i=benoit@dugarreau.fr header.b=eJ047SDD; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dugarreau.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dugarreau.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dugarreau.fr;
	s=s1-ionos; t=1734524459; x=1735129259; i=benoit@dugarreau.fr;
	bh=EXoVE6MwGt0nXKw4epjmr5zryRKVD2PTiusWBSifSkQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eJ047SDDizopYhJosXlsgZT63tFrP1S0D1Gqg1JkCNi5MetLZ+x3um620UEIE74P
	 D/YH0bmcFzu3GSxnw9Lsfz94lNVoqSggoll0Z3CrCiN/Qn5k5gfdBatCM7QRm1HUn
	 FzzxtcMi1vVaL62D29kiXmBmxhX2AQYqLmed0dc2uWNZUc3hKx2NB3Zx2l9nzMfYu
	 1t7A0momoe8pRKDyqO+2tzUxFp04aYVmW2oF2pC2dt7VwaAHSRdqp2wMbjAjcfPNa
	 6cDPGiHuRaPPue8vm+evHALeaBOglWKjW9scV4hue44XzxOjQi1H+pHFLuahXhPKX
	 Ok2ElXpNPA3cqYICxw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from debian.hades.lan ([185.116.133.150]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis)
 id 1M2wCi-1tRApi2Jv2-00BeyJ; Wed, 18 Dec 2024 13:20:59 +0100
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
	paulmck@kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	rcu@vger.kernel.org,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: Re: [PATCH v6 06/16] rust: add `Revocable` type
Date: Wed, 18 Dec 2024 13:20:20 +0100
Message-Id: <20241218122020.282671-1-benoit@dugarreau.fr>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212163357.35934-7-dakr@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qXKzUBqSM2Dodc7zz5/MzfjdiliVd0CChk/58/YsiZsZlOMgy0I
 hiwLzH0jprTD141OHrB3ieg3dK9bueZHTF9xl0FRF9rabfe278hJDm24aqKm3q0kGkLPiqg
 TOE8w8HcombREogw2qZpYstJlUW89kOMyr3avoHTZMg++BpU8gHeS3RwT2PRRG6eDwq7899
 bdTkjGUSrVV9LRFO5kUdw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4OiQJ7GF6mQ=;gLc3nkIL3pdwD523qKiuiN3HgQ4
 kW+cKDlm6Lb299fWsBWLOiuW33CY0Z/9uDpjiMTWuOmaOqhrcAoQuDNdHuAjVqlqkYnOLMae1
 pDUWeSMBdvDzAoR0hQINxhwG9hBGFNoNeIUjm2tXIAuF2azhIGZB3p9fJx9pi9Lz5OOqPDin6
 sdwPdYS76gXdSn/4fykmzoxl8XXEduMy5vd1slDU66jqHwYjYE7r/emqMt24ZC8FS7dbix5ko
 AZnKQXmOkitxFByCMX1zPbqjMBTv86bLeTz4AfTz2juEgeF89q94QH5pkaxIAoW5XqpiftLKX
 0VIsJ9kPr40JBmUipxDf4Ocdu9xDYWMn6RM9ODbJX3aS0brojDCkuYqzmljgmyxuYQFTNFaje
 yG4Xbwai6G6lb2V6BqPAoYuluIGTKUfnpO/x733wi7+d0LOGDl5pQuiHs1FO4iwuvlTS3gl5u
 veI3V+6bQLufbQfTV+VJimvUqzoATDZlsD7FxEHRl19yx3gJnXwGQJhFOhefvtyF4DXXmpN2D
 vBx/4Wl4s0lYyNY85TM41ekzzSUvvdhc/jCOn727IYAVm5FVhF7UBABbCPOgLT7WQzm0Hy2Y2
 usNQQ2pM/0TcPvlWJQG+VDvC076iotMD2nFcytiAtTDxmnljDjoM8yE2qSywEuFJCmhcJ+OXc
 +BJN/s629DDRTN2L9FhJNQnQswTTYVe/ss0x15wzlyxX66EJuEVFnRrOrVrpSt2/t7UQ8bbu7
 wY94R0exwL+JqARo35g2FK2/AiKKV1CImTXnhPRImUdfr94rbREE5nX9XGeZ+5c0L9m17tw7g
 ZRF/pdu2cK69jVSIRqc+H2T0hATxs4UtyDcU+NxuB/FHyn8IgxQj9NMgeMqTtNi1hPPtcovQD
 9mJSjUJp86ryCU/yp3HmFyMFPX7NOnY14tu2ly7pNtTsSRrOd8/dHIU/s5R4wVy3KukRyMMwF
 0DRm8cAeVVow7sTIxZuHxZOrNCnbryCzmzMP4GyOLTEmkNZhFljSNjbJOqRJ3V87+bOJs4J/u
 CsOa8H8SdVrg/mtwNmq2aYBd1Kkeiy8hi5mV+j/

On Thu, 12 Dec 2024 17:33:37 +0100 Danilo Krummrich <dakr@kernel.org> wrot=
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
> index 66149ac5c0c9..5702ce32ec8e 100644
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
> +        {

The comment I made in a previous series was somehow lost, so I put it back=
 here:
You can use `self.is_available.swap(false, Ordering::Relaxed)` instead of =
a CAS,
it is IMO clearer and optimizes better on some architectures.

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
> 2.47.1
>
>

Beno=C3=AEt du Garreau

