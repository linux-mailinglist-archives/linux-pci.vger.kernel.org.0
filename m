Return-Path: <linux-pci+bounces-15527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3289B4AE2
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 14:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4603284F6E
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 13:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57DF20607A;
	Tue, 29 Oct 2024 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T+uupmNB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11732205ACF
	for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2024 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730208433; cv=none; b=ar6qjd+SVLEeqhWUbJfta+frcBSAjchTbZibvcMsA/1NMNSJRdMnk3Dkls3Fsx1ICWQ/WgKsig76CSRgeNLP/WAAoG0kVJs8hLWB5LqCwhhD2e4v7LCnW9KrMtawPgdoqnfkl84ObfpxhaY/AdzlYu6FdjHr/JkrfHZrmsLfCQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730208433; c=relaxed/simple;
	bh=0l0pGwPPXUKryR0mqg/2ZJbi/yLW7k9MKNg+xvqxwtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bc2aVSyaVsjiduL9gAiJRvEPZz+u8+f+aBdYKpuNVu4MkOpZMWIfywJKEC25droN+tXzRl3gFeEW3HfIYOEOh4Yz1fO1qntD2bd1zsDMoNw5CZqb0Tf8rtz2OchSn9k57Ay5v6yE9YVK1JXA+OkLCg5h+o2Im2sChudc9SkoMnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T+uupmNB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c9978a221so58787095ad.1
        for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2024 06:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730208429; x=1730813229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPmbbkDdlgj5tS54qzNXga3fylyvP9KnhhI/PLfNTwk=;
        b=T+uupmNBwuy7DtS9taEVtLVI0AaS6djVyFZpHnp8393T7J6qiOekGT+JsXSam1rWd8
         H1tYiM77b9Dil/vAvZ78BGje04zfDaLWypOK0PjOUAnIub58sse3F7oSd3UnLD2D2zQp
         QIeOewYELo9NDcBGqcEYKfnz5FJKYleG3HJBT/0lv9l/4t+/0+a4+7BCwgtV50AdF+qg
         HZ2RenjBotNCzPAQTqNEtgGhsyjWZP2TapfEYYRlKLFbkJBUacz3r0B8DM03XjJQQUjm
         421MRAJEZPLo9remtyPcA0mroR28W6Qgtk2pTLIC4IltDEONgTTb8KVM651nNC73bS6S
         dC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730208429; x=1730813229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPmbbkDdlgj5tS54qzNXga3fylyvP9KnhhI/PLfNTwk=;
        b=Q+G9IdJKp5OH7Ix/7UBgt1+dRzZBQ1sf7JdkozekrlAIKpTX9WiKKR/6jZ5GgmviW5
         V1y8ukasC3i0yDFAsoz81Rm/St6jkw//QMoq7yiScx7+mjwQl1rwIz4APeazrc8zBBKm
         Rq++kD4mDM7gNISwG+eahxN77YNfWBUaeFEwjyffFYD5+t7ih7+BdAzqsCE/+0TJf94m
         vTcXcJrcyk+AbDU5XBmaxrAYoreDFhVvlvzLdKvM9YnyErBEwbobBXSoYI8food3K6g4
         R86f3PRG7BihYArSDnRjdKWVgV/o6Omim6ZyjigCSCR7mBKGyTQ+Ni3wzmnxPKwEigYo
         CCYg==
X-Forwarded-Encrypted: i=1; AJvYcCXzYAmXVMEjvqUiSqj3/NbJ8KUDhdgA9OWcOeTsOKlzu+/bSkIMBha7DhZbvLhFpd/BtlEoz7YYlNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7suHskk329YvqFYdT5H0JGkTg82qS9J8j1xSJtvqFTd8Pt9Jb
	svq1x89fsKJOuUvcXM9kwdMQkhNZOkdpzXTnEZ4Ahcm2t4DA5R7Ms4SiXtwsue8nt23GmFCvAja
	RD4judhgjgVtHCNXutA2z67LnKiUmUPZQL3rB
X-Google-Smtp-Source: AGHT+IEUNZ/udRp7n1cUowspy1x3Bn3BLvEgiqcEq2EHGavw+WCKwCDiifwnii7tkTSakAD08lG9y4jmuYIdK6y3Srw=
X-Received: by 2002:a17:903:2b08:b0:20c:ceb4:aa7f with SMTP id
 d9443c01a7336-210c68a1acdmr163437405ad.11.1730208428942; Tue, 29 Oct 2024
 06:27:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022213221.2383-1-dakr@kernel.org> <20241022213221.2383-8-dakr@kernel.org>
In-Reply-To: <20241022213221.2383-8-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 29 Oct 2024 14:26:55 +0100
Message-ID: <CAH5fLgjcy=DQrCYt-k40D4_NcwgdrykUW9d74srGn5hxxo2Xmw@mail.gmail.com>
Subject: Re: [PATCH v3 07/16] rust: add `Revocable` type
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com, 
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 11:33=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
>
> Revocable allows access to objects to be safely revoked at run time.
>
> This is useful, for example, for resources allocated during device probe;
> when the device is removed, the driver should stop accessing the device
> resources even if another state is kept in memory due to existing
> references (i.e., device context data is ref-counted and has a non-zero
> refcount after removal of the device).
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/lib.rs       |   1 +
>  rust/kernel/revocable.rs | 211 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 212 insertions(+)
>  create mode 100644 rust/kernel/revocable.rs
>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 89f6bd2efcc0..b603b67dcd71 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -54,6 +54,7 @@
>  pub mod prelude;
>  pub mod print;
>  pub mod rbtree;
> +pub mod revocable;
>  pub mod sizes;
>  mod static_assert;
>  #[doc(hidden)]
> diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
> new file mode 100644
> index 000000000000..83455558d795
> --- /dev/null
> +++ b/rust/kernel/revocable.rs
> @@ -0,0 +1,211 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Revocable objects.
> +//!
> +//! The [`Revocable`] type wraps other types and allows access to them t=
o be revoked. The existence
> +//! of a [`RevocableGuard`] ensures that objects remain valid.
> +
> +use crate::{
> +    bindings,
> +    init::{self},
> +    prelude::*,
> +    sync::rcu,
> +};
> +use core::{
> +    cell::UnsafeCell,
> +    marker::PhantomData,
> +    mem::MaybeUninit,
> +    ops::Deref,
> +    ptr::drop_in_place,
> +    sync::atomic::{AtomicBool, Ordering},
> +};
> +
> +/// An object that can become inaccessible at runtime.
> +///
> +/// Once access is revoked and all concurrent users complete (i.e., all =
existing instances of
> +/// [`RevocableGuard`] are dropped), the wrapped object is also dropped.
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
> +/// let v =3D KBox::pin_init(Revocable::new(Example { a: 10, b: 20 }), G=
FP_KERNEL).unwrap();
> +/// assert_eq!(add_two(&v), Some(30));
> +/// v.revoke();
> +/// assert_eq!(add_two(&v), None);
> +/// ```
> +///
> +/// Sample example as above, but explicitly using the rcu read side lock=
.
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
> +/// let v =3D KBox::pin_init(Revocable::new(Example { a: 10, b: 20 }), G=
FP_KERNEL).unwrap();
> +/// assert_eq!(add_two(&v), Some(30));
> +/// v.revoke();
> +/// assert_eq!(add_two(&v), None);
> +/// ```
> +#[pin_data(PinnedDrop)]
> +pub struct Revocable<T> {
> +    is_available: AtomicBool,
> +    #[pin]
> +    data: MaybeUninit<UnsafeCell<T>>,
> +}
> +
> +// SAFETY: `Revocable` is `Send` if the wrapped object is also `Send`. T=
his is because while the
> +// functionality exposed by `Revocable` can be accessed from any thread/=
CPU, it is possible that
> +// this isn't supported by the wrapped object.
> +unsafe impl<T: Send> Send for Revocable<T> {}
> +
> +// SAFETY: `Revocable` is `Sync` if the wrapped object is both `Send` an=
d `Sync`. We require `Send`
> +// from the wrapped object as well because  of `Revocable::revoke`, whic=
h can trigger the `Drop`
> +// implementation of the wrapped object from an arbitrary thread.
> +unsafe impl<T: Sync + Send> Sync for Revocable<T> {}
> +
> +impl<T> Revocable<T> {
> +    /// Creates a new revocable instance of the given data.
> +    pub fn new(data: impl PinInit<T>) -> impl PinInit<Self> {
> +        pin_init!(Self {
> +            is_available: AtomicBool::new(true),
> +            // SAFETY: The closure only returns `Ok(())` if `slot` is fu=
lly initialized; on error
> +            // `slot` is not partially initialized and does not need to =
be dropped.
> +            data <- unsafe {
> +                init::pin_init_from_closure(move |slot: *mut MaybeUninit=
<UnsafeCell<T>>| {
> +                    init::PinInit::<T, core::convert::Infallible>::__pin=
ned_init(data,
> +                                                                        =
         slot as *mut T)?;
> +                    Ok::<(), core::convert::Infallible>(())
> +                })

If you change `data` to be `Opaque`, then this can just be

data <- Opaque::ffi_init(data)

(or maybe you need try_ffi_init)

> +
> +    /// Tries to access the \[revocable\] wrapped object.
> +    ///
> +    /// Returns `None` if the object has been revoked and is therefore n=
o longer accessible.
> +    ///
> +    /// Returns a guard that gives access to the object otherwise; the o=
bject is guaranteed to
> +    /// remain accessible while the guard is alive. In such cases, calle=
rs are not allowed to sleep
> +    /// because another CPU may be waiting to complete the revocation of=
 this object.
> +    pub fn try_access(&self) -> Option<RevocableGuard<'_, T>> {
> +        let guard =3D rcu::read_lock();
> +        if self.is_available.load(Ordering::Relaxed) {
> +            // SAFETY: Since `self.is_available` is true, data is initia=
lised and has to remain
> +            // valid because the RCU read side lock prevents it from bei=
ng dropped.
> +            Some(unsafe { RevocableGuard::new(self.data.assume_init_ref(=
).get(), guard) })
> +        } else {
> +            None
> +        }
> +    }
> +
> +    /// Tries to access the \[revocable\] wrapped object.

These backslashes seem wrong.

> +    /// Returns `None` if the object has been revoked and is therefore n=
o longer accessible.
> +    ///
> +    /// Returns a shared reference to the object otherwise; the object i=
s guaranteed to
> +    /// remain accessible while the rcu read side guard is alive. In suc=
h cases, callers are not
> +    /// allowed to sleep because another CPU may be waiting to complete =
the revocation of this
> +    /// object.
> +    pub fn try_access_with_guard<'a>(&'a self, _guard: &'a rcu::Guard) -=
> Option<&'a T> {
> +        if self.is_available.load(Ordering::Relaxed) {
> +            // SAFETY: Since `self.is_available` is true, data is initia=
lised and has to remain
> +            // valid because the RCU read side lock prevents it from bei=
ng dropped.
> +            Some(unsafe { &*self.data.assume_init_ref().get() })
> +        } else {
> +            None
> +        }
> +    }
> +
> +    /// Revokes access to and drops the wrapped object.
> +    ///
> +    /// Access to the object is revoked immediately to new callers of [`=
Revocable::try_access`]. If
> +    /// there are concurrent users of the object (i.e., ones that called=
 [`Revocable::try_access`]
> +    /// beforehand and still haven't dropped the returned guard), this f=
unction waits for the
> +    /// concurrent access to complete before dropping the wrapped object=
.
> +    pub fn revoke(&self) {
> +        if self
> +            .is_available
> +            .compare_exchange(true, false, Ordering::Relaxed, Ordering::=
Relaxed)
> +            .is_ok()
> +        {
> +            // SAFETY: Just an FFI call, there are no further requiremen=
ts.
> +            unsafe { bindings::synchronize_rcu() };
> +
> +            // SAFETY: We know `self.data` is valid because only one CPU=
 can succeed the
> +            // `compare_exchange` above that takes `is_available` from `=
true` to `false`.
> +            unsafe { drop_in_place(self.data.assume_init_ref().get()) };
> +        }
> +    }
> +}
> +
> +#[pinned_drop]
> +impl<T> PinnedDrop for Revocable<T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        // Drop only if the data hasn't been revoked yet (in which case =
it has already been
> +        // dropped).
> +        // SAFETY: We are not moving out of `p`, only dropping in place
> +        let p =3D unsafe { self.get_unchecked_mut() };
> +        if *p.is_available.get_mut() {
> +            // SAFETY: We know `self.data` is valid because no other CPU=
 has changed
> +            // `is_available` to `false` yet, and no other CPU can do it=
 anymore because this CPU
> +            // holds the only reference (mutable) to `self` now.
> +            unsafe { drop_in_place(p.data.assume_init_ref().get()) };
> +        }
> +    }
> +}
> +
> +/// A guard that allows access to a revocable object and keeps it alive.
> +///
> +/// CPUs may not sleep while holding on to [`RevocableGuard`] because it=
's in atomic context
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

Is this needed? Can't all users just use `try_access_with_guard`?

Alice

