Return-Path: <linux-pci+bounces-9026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0437910926
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 16:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672B628306C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 14:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248EC1AE086;
	Thu, 20 Jun 2024 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pm8rdDTO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CBA1ACE89;
	Thu, 20 Jun 2024 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895521; cv=none; b=cCJeGU6lxXcCmNepOoCI++bumjXrAIVNcIVV2Tmku2S0U2GO2Bpv82ya1UrImjqknkhNNvgFXlPLu80iwMccMEQvZFPr1rHrniAnL43yTxot2qs130usUxVUO5Y/1SMhvdVDl+CAVIh4mQUiQNY1X9WP3m6j9MxHI3VmJIeJLa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895521; c=relaxed/simple;
	bh=sIAmacjUT9hybHQ+dEDQJ3pkqgFTfvJtgU4QdNg0KUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6/L7K4YfZcHAFOw/Au07RVwCpX1FIQt7rVgPm2m81DzqJRfJk8khTn2uugWl030MFB1Xta6/GckLnpVBBDJpeTZlnxZmiqi0KZYFr13H/yzJRpT6tMk5CKO1upH7QT9epnkBm5eQ3k6RrWDJgXqfDlvL4OOR/3x6eqE1UXo7As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pm8rdDTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB05FC2BD10;
	Thu, 20 Jun 2024 14:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718895520;
	bh=sIAmacjUT9hybHQ+dEDQJ3pkqgFTfvJtgU4QdNg0KUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pm8rdDTOD/sMRafm7umytx4aVpeIyMdQGw92pURrfU9X+oZzTr8O9DZaLx9fz2y5q
	 XVMPTUYdFr0NlW4V3LtZQo0kMZ+B5Vmr4OloFRY4kO/+QWJQcVc7Wm+WvSyBDpfl/6
	 vPhtBuEq3L2vXE6Y5og0kYmBPad+iqaxdV/MKjOk=
Date: Thu, 20 Jun 2024 16:58:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 08/10] rust: add devres abstraction
Message-ID: <2024062029-timothy-police-4db0@gregkh>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240618234025.15036-9-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618234025.15036-9-dakr@redhat.com>

On Wed, Jun 19, 2024 at 01:39:54AM +0200, Danilo Krummrich wrote:
> Add a Rust abstraction for the kernel's devres (device resource
> management) implementation.

Ah, here's the devm stuff.  Why not put it right after the "revokable"
stuff?

And why have revokable at all?  Why not just put it all here in devres?
Who's going to use the generic type?  Especially as it uses rcu when
devres today does NOT use rcu, so you are might get some "interesting"
issues with the interaction of the two.

> The Devres type acts as a container to manage the lifetime and
> accessibility of device bound resources. Therefore it registers a
> devres callback and revokes access to the resource on invocation.

Is this last sentence correct?  Revokes on invocation?

> Users of the Devres abstraction can simply free the corresponding
> resources in their Drop implementation, which is invoked when either the
> Devres instance goes out of scope or the devres callback leads to the
> resource being revoked, which implies a call to drop_in_place().

That's not how a normal driver will use it, right?  It's when the
remove() callback comes into the driver.  That might be well before
Drop() happens, as there might be other things keeping that memory
around (again, think of /dev/ node accesses.)

> --- /dev/null
> +++ b/rust/kernel/devres.rs
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0

One note for all of these new files, no copyright notices?  I'm all for
that, but I know a LOT of lawyers by people who work for companies that
have been working on this code do NOT want to see files without
copyright lines.

So please go check.  Otherwise you might get a "stern talking to" in the
future when someone notices what you all did...

> +
> +//! Devres abstraction
> +//!
> +//! [`Devres`] represents an abstraction for the kernel devres (device resource management)
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
> +/// This abstraction is meant to be used by subsystems to containerize [`Device`] bound resources to
> +/// manage their lifetime.
> +///
> +/// [`Device`] bound resources should be freed when either the resource goes out of scope or the
> +/// [`Device`] is unbound respectively, depending on what happens first.
> +///
> +/// To achieve that [`Devres`] registers a devres callback on creation, which is called once the
> +/// [`Device`] is unbound, revoking access to the encapsulated resource (see also [`Revocable`]).
> +///
> +/// After the [`Devres`] has been unbound it is not possible to access the encapsulated resource
> +/// anymore.
> +///
> +/// [`Devres`] users should make sure to simply free the corresponding backing resource in `T`'s
> +/// [`Drop`] implementation.
> +///
> +/// # Example
> +///
> +/// ```
> +/// # use kernel::{bindings, c_str, device::Device, devres::Devres, io::Io};
> +/// # use core::ops::Deref;
> +///
> +/// // See also [`pci::Bar`] for a real example.
> +/// struct IoMem<const SIZE: usize>(Io<SIZE>);
> +///
> +/// impl<const SIZE: usize> IoMem<SIZE> {
> +///     fn new(paddr: usize) -> Result<Self>{
> +///
> +///         // SAFETY: assert safety for this example
> +///         let addr = unsafe { bindings::ioremap(paddr as _, SIZE.try_into().unwrap()) };
> +///         if addr.is_null() {
> +///             return Err(ENOMEM);
> +///         }
> +///
> +///         // SAFETY: `addr` is guaranteed to be the start of a valid I/O mapped memory region of
> +///         // size `SIZE`.
> +///         let io = unsafe { Io::new(addr as _, SIZE)? };
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
> +///    type Target = Io<SIZE>;
> +///
> +///    fn deref(&self) -> &Self::Target {
> +///        &self.0
> +///    }
> +/// }
> +///
> +/// # // SAFETY: *NOT* safe, just for the example to get an `ARef<Device>` instance
> +/// # let dev = unsafe { Device::from_raw(core::ptr::null_mut()) };
> +///
> +/// let iomem = IoMem::<{ core::mem::size_of::<u32>() }>::new(0xBAAAAAAD).unwrap();
> +/// let devres = Devres::new(&dev, iomem, GFP_KERNEL).unwrap();
> +///
> +/// let res = devres.try_access().ok_or(ENXIO).unwrap();
> +/// res.writel(0x42, 0x0);
> +/// ```
> +///
> +pub struct Devres<T>(Arc<DevresInner<T>>);
> +
> +impl<T> DevresInner<T> {
> +    fn new(dev: &Device, data: T, flags: Flags) -> Result<Arc<DevresInner<T>>> {
> +        let inner = Arc::pin_init(
> +            pin_init!( DevresInner {
> +                data <- Revocable::new(data),
> +            }),
> +            flags,
> +        )?;
> +
> +        // Convert `Arc<DevresInner>` into a raw pointer and make devres own this reference until
> +        // `Self::devres_callback` is called.
> +        let data = inner.clone().into_raw();
> +        let ret = unsafe {
> +            bindings::devm_add_action(dev.as_raw(), Some(Self::devres_callback), data as _)
> +        };
> +
> +        if ret != 0 {
> +            // SAFETY: We just created another reference to `inner` in order to pass it to
> +            // `bindings::devm_add_action`. If `bindings::devm_add_action` fails, we have to drop
> +            // this reference accordingly.
> +            let _ = unsafe { Arc::from_raw(data) };
> +            return Err(Error::from_errno(ret));
> +        }
> +
> +        Ok(inner)
> +    }
> +
> +    unsafe extern "C" fn devres_callback(ptr: *mut c_void) {
> +        let ptr = ptr as *mut DevresInner<T>;
> +        // Devres owned this memory; now that we received the callback, drop the `Arc` and hence the
> +        // reference.
> +        // SAFETY: Safe, since we leaked an `Arc` reference to devm_add_action() in
> +        //         `DevresInner::new`.
> +        let inner = unsafe { Arc::from_raw(ptr) };
> +
> +        inner.data.revoke();
> +    }
> +}
> +
> +impl<T> Devres<T> {
> +    /// Creates a new [`Devres`] instance of the given `data`. The `data` encapsulated within the
> +    /// returned `Devres` instance' `data` will be revoked once the device is detached.
> +    pub fn new(dev: &Device, data: T, flags: Flags) -> Result<Self> {
> +        let inner = DevresInner::new(dev, data, flags)?;
> +
> +        Ok(Devres(inner))
> +    }
> +
> +    /// Same as [Devres::new`], but does not return a `Devres` instance. Instead the given `data`
> +    /// is owned by devres and will be revoked / dropped, once the device is detached.
> +    pub fn new_foreign_owned(dev: &Device, data: T, flags: Flags) -> Result {
> +        let _ = DevresInner::new(dev, data, flags)?;
> +
> +        Ok(())
> +    }
> +}
> +
> +impl<T> Deref for Devres<T> {
> +    type Target = Revocable<T>;
> +
> +    fn deref(&self) -> &Self::Target {
> +        &self.0.data
> +    }
> +}
> +
> +impl<T> Drop for Devres<T> {
> +    fn drop(&mut self) {
> +        // Revoke the data, such that it gets dropped already and the actual resource is freed.
> +        // `DevresInner` has to stay alive until the devres callback has been called. This is
> +        // necessary since we don't know when `Devres` is dropped and calling
> +        // `devm_remove_action()` instead could race with `devres_release_all()`.
> +        self.revoke();
> +    }
> +}

Again, I don't think this can happen at "drop", it needs to happen
earlier sometimes.  Or maybe not, I can't tell when exactly is Drop
called, where would I find that?

thanks,

greg k-h

