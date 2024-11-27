Return-Path: <linux-pci+bounces-17415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC3C9DA7BF
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 13:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCB83B2104E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 12:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8471FAC5A;
	Wed, 27 Nov 2024 12:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CeNwc5A1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F391FBE9C
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732710126; cv=none; b=oB9S+HJd0nwybqDS1UncD77slk3V44vZ+lzSaoBYtDBXWzHtkAlm0BTWLxbrBEYdu88D/N/vagSPfBeifNZ3QaxnPvy/QUYa9PlWZasvdni+3S27+gT1DeA3KzalQoVr6w+ry1Z4EaC/ZcQHpy6O+HZEQRuULP8KJH4eYDDeXpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732710126; c=relaxed/simple;
	bh=3e/5P/6ZHWK40zH/Dgceg6zafXwzBI/F2osZqJio/IQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOhUd96/k6bwovdxAIPrNwiBn4Yiq7rtotGSasOMYRV4kY+A/5jurdUoI0Z5IVEUwmJJOuvIHWgsOu+GJWlS3PyhDOqNkigSwWc010qOinaFKZjMtp6xef1K8Xmx4Phj66rHPuzXUkNmnpZgoGYHXRQlbUkpAkT2GNaJPdoi1So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CeNwc5A1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3824709ee03so4858971f8f.2
        for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 04:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732710123; x=1733314923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZG7A1UTDNMC4Ry/XuOcOHO26vqI6CqsjaZF79UCoUIc=;
        b=CeNwc5A1OalYpSdafHpstSfAbDPsLBHI9bRRcE1k2NSfLkCdnyGmxas1OiqGBatJgK
         FtkeM4TixfNe2+0peH9bomYg9IdmZuJIvE3hYM893kyK3dpLbY7noanfgzicegNTNh91
         Ci4ginvskPeo9ghKJrLZaggjzMu2BrQjL0FPkJrxejRTbWjOahxLxf5IpvQvcQyM1QEu
         IXwXfM05dZ8bJVT7N98NZxcIT3/oxfIDb7KYKC06j72eOMxrjKi+R6P/jRcihTTkkYX1
         rCKApU5BzBQHYqe0GQ8NgoCEkOAEevPxHtxZ69FDuetUwx54LXV12OhwGq6N2E12bqG3
         xnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732710123; x=1733314923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZG7A1UTDNMC4Ry/XuOcOHO26vqI6CqsjaZF79UCoUIc=;
        b=ZQMoqDp/MCQOiXkTBHtLmEjWT7WKAWK3Sqi/vxUslHVLdMvFNGLp7fBuqcMQVtVmip
         em8s4sTXMR88b68pvVw5U14GRlQCPCCfxND6VO9lVwxY+o58AAtswZWGc2jAT/8VJH+w
         GrDrdZ4OslP9Yx7FxoRPBlqFcl5g5b7Ys5dUrjOqPAncH3YrSzY6OVhZ+pRCsYybPuJn
         ZKSdxeMEtWeRTtsJa/BCVwqWr+4M4uA0+hE8wNAX7DwbCtxs6jgvQzP9FXM4SpdbFEEq
         gcPBb8h+G0y93qyMut5pRqOvszAuJ+a7qFUCDW1uAtFuoyB1240M+rRoX8XTr5J0P5Bd
         jGRA==
X-Forwarded-Encrypted: i=1; AJvYcCUHkFnWWNgh0j628Ot8aXpa2qt2mg69D9ZNpOJSY6MDrF6vjT0Z02mRJ0P9WxFykjJzAUO5u9/EdNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOjm2CbKuxx//JJFco88aXBya9Tth55si7nDKVVCz5Dla8pzcl
	PFInS3SBOJkWSyuf9hmbg9bVCPmril3RPhQ6facAQhESjC+28F+bzLKX5YJBk6uWT5Hga7f358o
	32Sk2A8udtaqBI+OcJvSld2vKxQWQe2abCg83
X-Gm-Gg: ASbGncv/hNgjKcm3HerQAJSV2IVvVnBsXjMqmChs505RUTgT7gZj5OQnIteWducDMtu
	WnvIbFpL0OcERNO4wrNYEbJl3ZmnFnHfgHT234xWDzwGMNJevdhTcCTqbk2l43A==
X-Google-Smtp-Source: AGHT+IF4+wdI5JKdr3K6j1/1J51foaLydV2KUfE3ySjw3J47y7YMvldrRsWmH+nugd6eg3J2lJ9qERnCsRyrN6lqbhI=
X-Received: by 2002:a5d:64c6:0:b0:382:5112:562f with SMTP id
 ffacd0b85a97d-385c6cca152mr2118376f8f.11.1732710122796; Wed, 27 Nov 2024
 04:22:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022213221.2383-1-dakr@kernel.org> <20241022213221.2383-11-dakr@kernel.org>
In-Reply-To: <20241022213221.2383-11-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 27 Nov 2024 13:21:50 +0100
Message-ID: <CAH5fLgjdKRCECmZbjC-+6SQffFtgimfxhDJ3grVw1_hbQec1-Q@mail.gmail.com>
Subject: Re: [PATCH v3 10/16] rust: add devres abstraction
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com, 
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 11:33=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> Add a Rust abstraction for the kernel's devres (device resource
> management) implementation.
>
> The Devres type acts as a container to manage the lifetime and
> accessibility of device bound resources. Therefore it registers a
> devres callback and revokes access to the resource on invocation.
>
> Users of the Devres abstraction can simply free the corresponding
> resources in their Drop implementation, which is invoked when either the
> Devres instance goes out of scope or the devres callback leads to the
> resource being revoked, which implies a call to drop_in_place().
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  MAINTAINERS            |   1 +
>  rust/helpers/device.c  |  10 +++
>  rust/helpers/helpers.c |   1 +
>  rust/kernel/devres.rs  | 180 +++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs     |   1 +
>  5 files changed, 193 insertions(+)
>  create mode 100644 rust/helpers/device.c
>  create mode 100644 rust/kernel/devres.rs
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0a8882252257..97914d0752fb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6983,6 +6983,7 @@ F:        include/linux/property.h
>  F:     lib/kobj*
>  F:     rust/kernel/device.rs
>  F:     rust/kernel/device_id.rs
> +F:     rust/kernel/devres.rs
>  F:     rust/kernel/driver.rs
>
>  DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
> diff --git a/rust/helpers/device.c b/rust/helpers/device.c
> new file mode 100644
> index 000000000000..b2135c6686b0
> --- /dev/null
> +++ b/rust/helpers/device.c
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/device.h>
> +
> +int rust_helper_devm_add_action(struct device *dev,
> +                               void (*action)(void *),
> +                               void *data)
> +{
> +       return devm_add_action(dev, action, data);
> +}
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index e2f6b2197061..3acb2b9e52ec 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -11,6 +11,7 @@
>  #include "bug.c"
>  #include "build_assert.c"
>  #include "build_bug.c"
> +#include "device.c"
>  #include "err.c"
>  #include "io.c"
>  #include "kunit.c"
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> new file mode 100644
> index 000000000000..b23559f55214
> --- /dev/null
> +++ b/rust/kernel/devres.rs
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Devres abstraction
> +//!
> +//! [`Devres`] represents an abstraction for the kernel devres (device r=
esource management)
> +//! implementation.
> +
> +use crate::{
> +    alloc::Flags,
> +    bindings,
> +    device::Device,
> +    error::{Error, Result},
> +    prelude::*,
> +    revocable::Revocable,
> +    sync::Arc,
> +};
> +
> +use core::ffi::c_void;
> +use core::ops::Deref;
> +
> +#[pin_data]
> +struct DevresInner<T> {
> +    #[pin]
> +    data: Revocable<T>,
> +}
> +
> +/// This abstraction is meant to be used by subsystems to containerize [=
`Device`] bound resources to
> +/// manage their lifetime.
> +///
> +/// [`Device`] bound resources should be freed when either the resource =
goes out of scope or the
> +/// [`Device`] is unbound respectively, depending on what happens first.
> +///
> +/// To achieve that [`Devres`] registers a devres callback on creation, =
which is called once the
> +/// [`Device`] is unbound, revoking access to the encapsulated resource =
(see also [`Revocable`]).
> +///
> +/// After the [`Devres`] has been unbound it is not possible to access t=
he encapsulated resource
> +/// anymore.
> +///
> +/// [`Devres`] users should make sure to simply free the corresponding b=
acking resource in `T`'s
> +/// [`Drop`] implementation.
> +///
> +/// # Example
> +///
> +/// ```no_run
> +/// # use kernel::{bindings, c_str, device::Device, devres::Devres, io::=
Io};
> +/// # use core::ops::Deref;
> +///
> +/// // See also [`pci::Bar`] for a real example.
> +/// struct IoMem<const SIZE: usize>(Io<SIZE>);
> +///
> +/// impl<const SIZE: usize> IoMem<SIZE> {
> +///     /// # Safety
> +///     ///
> +///     /// [`paddr`, `paddr` + `SIZE`) must be a valid MMIO region that=
 is mappable into the CPUs
> +///     /// virtual address space.
> +///     unsafe fn new(paddr: usize) -> Result<Self>{
> +///
> +///         // SAFETY: By the safety requirements of this function [`pad=
dr`, `paddr` + `SIZE`) is
> +///         // valid for `ioremap`.
> +///         let addr =3D unsafe { bindings::ioremap(paddr as _, SIZE.try=
_into().unwrap()) };
> +///         if addr.is_null() {
> +///             return Err(ENOMEM);
> +///         }
> +///
> +///         // SAFETY: `addr` is guaranteed to be the start of a valid I=
/O mapped memory region of
> +///         // size `SIZE`.
> +///         let io =3D unsafe { Io::new(addr as _, SIZE)? };
> +///
> +///         Ok(IoMem(io))
> +///     }
> +/// }
> +///
> +/// impl<const SIZE: usize> Drop for IoMem<SIZE> {
> +///     fn drop(&mut self) {
> +///         // SAFETY: Safe as by the invariant of `Io`.
> +///         unsafe { bindings::iounmap(self.0.base_addr() as _); };
> +///     }
> +/// }
> +///
> +/// impl<const SIZE: usize> Deref for IoMem<SIZE> {
> +///    type Target =3D Io<SIZE>;
> +///
> +///    fn deref(&self) -> &Self::Target {
> +///        &self.0
> +///    }
> +/// }
> +///
> +/// # fn no_run() -> Result<(), Error> {
> +/// # // SAFETY: Invalid usage; just for the example to get an `ARef<Dev=
ice>` instance.
> +/// # let dev =3D unsafe { Device::from_raw(core::ptr::null_mut()) };
> +///
> +/// // SAFETY: Invalid usage for example purposes.
> +/// let iomem =3D unsafe { IoMem::<{ core::mem::size_of::<u32>() }>::new=
(0xBAAAAAAD)? };
> +/// let devres =3D Devres::new(&dev, iomem, GFP_KERNEL)?;
> +///
> +/// let res =3D devres.try_access().ok_or(ENXIO)?;
> +/// res.writel(0x42, 0x0);
> +/// # Ok(())
> +/// # }
> +/// ```
> +pub struct Devres<T>(Arc<DevresInner<T>>);
> +
> +impl<T> DevresInner<T> {
> +    fn new(dev: &Device, data: T, flags: Flags) -> Result<Arc<DevresInne=
r<T>>> {
> +        let inner =3D Arc::pin_init(
> +            pin_init!( DevresInner {
> +                data <- Revocable::new(data),
> +            }),
> +            flags,
> +        )?;
> +
> +        // Convert `Arc<DevresInner>` into a raw pointer and make devres=
 own this reference until
> +        // `Self::devres_callback` is called.
> +        let data =3D inner.clone().into_raw();
> +
> +        // SAFETY: `devm_add_action` guarantees to call `Self::devres_ca=
llback` once `dev` is
> +        // detached.
> +        let ret =3D unsafe {
> +            bindings::devm_add_action(dev.as_raw(), Some(Self::devres_ca=
llback), data as _)
> +        };
> +
> +        if ret !=3D 0 {
> +            // SAFETY: We just created another reference to `inner` in o=
rder to pass it to
> +            // `bindings::devm_add_action`. If `bindings::devm_add_actio=
n` fails, we have to drop
> +            // this reference accordingly.
> +            let _ =3D unsafe { Arc::from_raw(data) };
> +            return Err(Error::from_errno(ret));
> +        }
> +
> +        Ok(inner)
> +    }
> +
> +    #[allow(clippy::missing_safety_doc)]
> +    unsafe extern "C" fn devres_callback(ptr: *mut c_void) {
> +        let ptr =3D ptr as *mut DevresInner<T>;
> +        // Devres owned this memory; now that we received the callback, =
drop the `Arc` and hence the
> +        // reference.
> +        // SAFETY: Safe, since we leaked an `Arc` reference to devm_add_=
action() in
> +        //         `DevresInner::new`.
> +        let inner =3D unsafe { Arc::from_raw(ptr) };
> +
> +        inner.data.revoke();
> +    }
> +}
> +
> +impl<T> Devres<T> {
> +    /// Creates a new [`Devres`] instance of the given `data`. The `data=
` encapsulated within the
> +    /// returned `Devres` instance' `data` will be revoked once the devi=
ce is detached.
> +    pub fn new(dev: &Device, data: T, flags: Flags) -> Result<Self> {
> +        let inner =3D DevresInner::new(dev, data, flags)?;
> +
> +        Ok(Devres(inner))
> +    }
> +
> +    /// Same as [`Devres::new`], but does not return a `Devres` instance=
. Instead the given `data`
> +    /// is owned by devres and will be revoked / dropped, once the devic=
e is detached.
> +    pub fn new_foreign_owned(dev: &Device, data: T, flags: Flags) -> Res=
ult {
> +        let _ =3D DevresInner::new(dev, data, flags)?;
> +
> +        Ok(())
> +    }
> +}
> +
> +impl<T> Deref for Devres<T> {
> +    type Target =3D Revocable<T>;
> +
> +    fn deref(&self) -> &Self::Target {
> +        &self.0.data
> +    }
> +}
> +
> +impl<T> Drop for Devres<T> {
> +    fn drop(&mut self) {
> +        // Revoke the data, such that it gets dropped already and the ac=
tual resource is freed.
> +        // `DevresInner` has to stay alive until the devres callback has=
 been called. This is
> +        // necessary since we don't know when `Devres` is dropped and ca=
lling
> +        // `devm_remove_action()` instead could race with `devres_releas=
e_all()`.
> +        self.revoke();

When the destructor runs, it's guaranteed that nobody is accessing the
inner resource since the only way to do that is through the Devres
handle, but its destructor is running. Therefore, you can skip the
synchronize_rcu() call in this case.

Alice

