Return-Path: <linux-pci+bounces-30324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 362E5AE320D
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 22:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515773ADF67
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 20:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA96B1F4C97;
	Sun, 22 Jun 2025 20:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcujbnmE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6191EDA3F;
	Sun, 22 Jun 2025 20:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750625107; cv=none; b=RuFCKwr6coNvi8d7fv7mZkGMD0VkKnaY894W8vU40Obx4STQOBwOhwXB000J2n54SRU9z4KspECHv0hbsRbGDqVUV7PzEJqtBamHrHoJTXdHXesKbLTIjN9eZQTz2Y6v7O6VoEtBJf2x9k+VOFjubFKZrpvhYNo9rclpg1CGBPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750625107; c=relaxed/simple;
	bh=ReU+ICFxV1DbFe9c9FqjmqnDj9yHlrBDBsoKH+nem8c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WOYCBp7JGaLZJpsAHqDnpAi7UaueoZy+HsIwsvk28WsRfPkp9zV+5X66TjoA9lD404x1ZQto0EIuGgdQT/LvN6Nh80OfE2razbCytOkl5OzyKHUgV6LIw2EU+ZDIVu8onNmYbXlKNn+G2vnNhBagV2xvsumUbUJX3q+cnNlKlkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcujbnmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCB1C4CEE3;
	Sun, 22 Jun 2025 20:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750625107;
	bh=ReU+ICFxV1DbFe9c9FqjmqnDj9yHlrBDBsoKH+nem8c=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=UcujbnmEBJI7mFL8pyTps6zpf1/yEBSrWJUAnbJzT1LvyjPpthJ1X/yBd5fbiv2rx
	 NN2ssfVEWrJOqvMB7e/sQfAkfWoNwiDludqmLdHyxsKBPnnif2sn79Q8dVmwgyqEKu
	 qUTL5kDz4q3FjEp72ZdIOCDLhlirZPzrHfT5NJDmVu7CuxE3sU4a3Nr9xzh4dHRdTT
	 gMvMVCGlOZepCwPWKnefqygGVvYeCHo/wDtSP23n9WrPtEgjAxC3cS4IZd6yAuWtUV
	 W5Hd2C0NOUYpIGOMPVO/APIaVM2QVxm6cXqp3KiQg93tOffaDlExwG8pCsNv7hFofK
	 Z5yBPVyf4tB4Q==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Jun 2025 22:45:02 +0200
Message-Id: <DATCT1EG0Z70.3ON7LFZEEZ93M@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] rust: devres: get rid of Devres' inner Arc
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <kwilczynski@kernel.org>, <bhelgaas@google.com>
X-Mailer: aerc 0.20.1
References: <20250622164050.20358-1-dakr@kernel.org>
 <20250622164050.20358-4-dakr@kernel.org>
In-Reply-To: <20250622164050.20358-4-dakr@kernel.org>

On Sun Jun 22, 2025 at 6:40 PM CEST, Danilo Krummrich wrote:
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index 250073749279..15a0a94e992b 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -13,20 +13,31 @@
>      ffi::c_void,
>      prelude::*,
>      revocable::{Revocable, RevocableGuard},
> -    sync::{rcu, Arc, Completion},
> -    types::{ARef, ForeignOwnable},
> +    sync::{rcu, Completion},
> +    types::{ARef, ForeignOwnable, Opaque},
>  };
> =20
> +use pin_init::Wrapper;
> +
> +/// [`Devres`] inner data accessed from [`Devres::callback`].
>  #[pin_data]
> -struct DevresInner<T> {
> -    dev: ARef<Device>,
> -    callback: unsafe extern "C" fn(*mut c_void),
> +struct Inner<T> {
>      #[pin]
>      data: Revocable<T>,
> +    /// Tracks whether [`Devres::callback`] has been completed.
> +    #[pin]
> +    devm: Completion,
> +    /// Tracks whether revoking [`Self::data`] has been completed.
>      #[pin]
>      revoke: Completion,
>  }
> =20
> +impl<T> Inner<T> {
> +    fn as_ptr(&self) -> *const Self {
> +        self
> +    }
> +}

Instead of creating this function, you can use `ptr::from_ref`.

> +
>  /// This abstraction is meant to be used by subsystems to containerize [=
`Device`] bound resources to
>  /// manage their lifetime.
>  ///
> @@ -88,100 +99,106 @@ struct DevresInner<T> {
>  /// # fn no_run(dev: &Device<Bound>) -> Result<(), Error> {
>  /// // SAFETY: Invalid usage for example purposes.
>  /// let iomem =3D unsafe { IoMem::<{ core::mem::size_of::<u32>() }>::new=
(0xBAAAAAAD)? };
> -/// let devres =3D Devres::new(dev, iomem, GFP_KERNEL)?;
> +/// let devres =3D KBox::pin_init(Devres::new(dev, iomem), GFP_KERNEL)?;
>  ///
>  /// let res =3D devres.try_access().ok_or(ENXIO)?;
>  /// res.write8(0x42, 0x0);
>  /// # Ok(())
>  /// # }
>  /// ```
> -pub struct Devres<T>(Arc<DevresInner<T>>);
> +#[pin_data(PinnedDrop)]
> +pub struct Devres<T> {
> +    dev: ARef<Device>,
> +    /// Pointer to [`Self::devres_callback`].
> +    ///
> +    /// Has to be stored, since Rust does not guarantee to always return=
 the same address for a
> +    /// function. However, the C API uses the address as a key.
> +    callback: unsafe extern "C" fn(*mut c_void),
> +    /// Contains all the fields shared with [`Self::callback`].
> +    // TODO: Replace with `UnsafePinned`, once available.
> +    #[pin]
> +    inner: Opaque<Inner<T>>,
> +}
> =20
> -impl<T> DevresInner<T> {
> -    fn new(dev: &Device<Bound>, data: T, flags: Flags) -> Result<Arc<Dev=
resInner<T>>> {
> -        let inner =3D Arc::pin_init(
> -            try_pin_init!( DevresInner {
> -                dev: dev.into(),
> -                callback: Self::devres_callback,
> +impl<T> Devres<T> {
> +    /// Creates a new [`Devres`] instance of the given `data`.
> +    ///
> +    /// The `data` encapsulated within the returned `Devres` instance' `=
data` will be
> +    /// (revoked)[`Revocable`] once the device is detached.
> +    pub fn new<'a, E>(
> +        dev: &'a Device<Bound>,
> +        data: impl PinInit<T, E> + 'a,
> +    ) -> impl PinInit<Self, Error> + 'a
> +    where
> +        T: 'a,
> +        Error: From<E>,
> +    {
> +        let callback =3D Self::devres_callback;
> +
> +        try_pin_init!(&this in Self {
> +            inner <- Opaque::pin_init(try_pin_init!(Inner {
>                  data <- Revocable::new(data),
> +                devm <- Completion::new(),
>                  revoke <- Completion::new(),
> -            }),
> -            flags,
> -        )?;
> -
> -        // Convert `Arc<DevresInner>` into a raw pointer and make devres=
 own this reference until
> -        // `Self::devres_callback` is called.
> -        let data =3D inner.clone().into_raw();
> +            })),
> +            callback,
> +            dev: {
> +                // SAFETY: It is valid to dereference `this` to find the=
 address of `inner`.

    // SAFETY: `this` is a valid pointer to uninitialized memory.

> +                let inner =3D unsafe { core::ptr::addr_of_mut!((*this.as=
_ptr()).inner) };

We can use `raw` instead of `addr_of_mut!`:

    let inner =3D unsafe { &raw mut (*this.as_ptr()).inner };

> =20
> -        // SAFETY: `devm_add_action` guarantees to call `Self::devres_ca=
llback` once `dev` is
> -        // detached.
> -        let ret =3D
> -            unsafe { bindings::devm_add_action(dev.as_raw(), Some(inner.=
callback), data as _) };
> -
> -        if ret !=3D 0 {
> -            // SAFETY: We just created another reference to `inner` in o=
rder to pass it to
> -            // `bindings::devm_add_action`. If `bindings::devm_add_actio=
n` fails, we have to drop
> -            // this reference accordingly.
> -            let _ =3D unsafe { Arc::from_raw(data) };
> -            return Err(Error::from_errno(ret));
> -        }
> +                // SAFETY:
> +                // - `dev.as_raw()` is a pointer to a valid bound device=
.
> +                // - `inner` is guaranteed to be a valid for the duratio=
n of the lifetime of `Self`.
> +                // - `devm_add_action()` is guaranteed not to call `call=
back` until `this` has been
> +                //    properly initialized, because we require `dev` (i.=
e. the *bound* device) to
> +                //    live at least as long as the returned `impl PinIni=
t<Self, Error>`.

Just wanted to highlight that this is a very cool application of the
borrow checker :)

> +                to_result(unsafe {
> +                    bindings::devm_add_action(dev.as_raw(), Some(callbac=
k), inner.cast())
> +                })?;
> =20
> -        Ok(inner)
> +                dev.into()
> +            },
> +        })
>      }
> =20
> -    fn as_ptr(&self) -> *const Self {
> -        self as _
> +    fn inner(&self) -> &Inner<T> {
> +        // SAFETY: `inner` is valid and properly initialized.

We should have an invariant here that `inner` is always accessed
read-only and that it is initialized.

---
Cheers,
Benno

> +        unsafe { &*self.inner.get() }
>      }
> =20
> -    fn remove_action(this: &Arc<Self>) -> bool {
> -        // SAFETY:
> -        // - `self.inner.dev` is a valid `Device`,
> -        // - the `action` and `data` pointers are the exact same ones as=
 given to devm_add_action()
> -        //   previously,
> -        // - `self` is always valid, even if the action has been release=
d already.
> -        let success =3D unsafe {
> -            bindings::devm_remove_action_nowarn(
> -                this.dev.as_raw(),
> -                Some(this.callback),
> -                this.as_ptr() as _,
> -            )
> -        } =3D=3D 0;
> -
> -        if success {
> -            // SAFETY: We leaked an `Arc` reference to devm_add_action()=
 in `DevresInner::new`; if
> -            // devm_remove_action_nowarn() was successful we can (and ha=
ve to) claim back ownership
> -            // of this reference.
> -            let _ =3D unsafe { Arc::from_raw(this.as_ptr()) };
> -        }
> -
> -        success
> +    fn data(&self) -> &Revocable<T> {
> +        &self.inner().data
>      }

