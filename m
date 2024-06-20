Return-Path: <linux-pci+bounces-9018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A86C6910836
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 16:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604922810C4
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 14:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5B71AD4AF;
	Thu, 20 Jun 2024 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q9865+if"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7821AD486;
	Thu, 20 Jun 2024 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893707; cv=none; b=ngqR2SxnE3bO0+NPw99xA3P7j8ymdOks8MN008jB/6JUwiIWuJIDcynnHMIAIXuUyf2lkLdRyWc2eueC0OQq7QgGaDSoZa5+cqoIt/5P/1NUuu7/wW4EuYRs9l/Q9/7AeZXlubNE63cj8DoqanIpdN1onLwmGATgkTxExhRH1Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893707; c=relaxed/simple;
	bh=3EE/QBsK6JKLzOy9Bdru3jUCcnA/OWzLURwrKzOV/80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPxU9RnR21GYwRVpbIlMyd0D7ffGS27STO7i69WgPJ5qHEv32OMG795a561cWEFzMhnGLZFLHydGn6Fl3XrED6RWMqGjuuH2hlb9iRSwNH45nqhx5C8sQscW90x/HJJC44/ZaduegcldFIEHGRDEdXuj6w473FvqwNn2C+p9gto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q9865+if; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF7FC2BD10;
	Thu, 20 Jun 2024 14:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718893706;
	bh=3EE/QBsK6JKLzOy9Bdru3jUCcnA/OWzLURwrKzOV/80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q9865+ifPTyM90oTKmNL1pu14RyMkZCRqAdr2EPyYCWxalNzSx7o8GnNRd+JLPdnT
	 F7kP6fmVg1Z+oQw2owJyu9D/tpGFr2ROlH2Ct2GZO7rXOZvUd1AFj0hZqbqvNYgroD
	 UwdfmFiR9RfWyajY/1CU0AlTwc+CZSyHWSp7Xy2g=
Date: Thu, 20 Jun 2024 16:28:23 +0200
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
Subject: Re: [PATCH v2 02/10] rust: implement generic driver registration
Message-ID: <2024062025-wrecking-utilize-30cf@gregkh>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240618234025.15036-3-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618234025.15036-3-dakr@redhat.com>

On Wed, Jun 19, 2024 at 01:39:48AM +0200, Danilo Krummrich wrote:
> Implement the generic `Registration` type and the `DriverOps` trait.

I don't think this is needed, more below...

> The `Registration` structure is the common type that represents a driver
> registration and is typically bound to the lifetime of a module. However,
> it doesn't implement actual calls to the kernel's driver core to register
> drivers itself.

But that's not what normally happens, more below...

> Instead the `DriverOps` trait is provided to subsystems, which have to
> implement `DriverOps::register` and `DrvierOps::unregister`. Subsystems
> have to provide an implementation for both of those methods where the
> subsystem specific variants to register / unregister a driver have to
> implemented.

So you are saying this should be something that a "bus" would do?
Please be explicit as to what you mean by "subsystem" here.

> For instance, the PCI subsystem would call __pci_register_driver() from
> `DriverOps::register` and pci_unregister_driver() from
> `DrvierOps::unregister`.

So this is a BusOps, or more in general, a "subsystem" if it's not a
bus (i.e. it's a class).  Note, we used to use the term "subsystem" a
very long time ago but got rid of them in the driver core, let's not
bring it back unless we REALLY know we want it this time.

So why isn't this just a BusOps?
> This patch is based on previous work from Wedson Almeida Filho.
> 
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>  rust/kernel/driver.rs | 128 ++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs    |   1 +
>  2 files changed, 129 insertions(+)
>  create mode 100644 rust/kernel/driver.rs
> 
> diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> new file mode 100644
> index 000000000000..e04406b93b56
> --- /dev/null
> +++ b/rust/kernel/driver.rs
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Generic support for drivers of different buses (e.g., PCI, Platform, Amba, etc.).

See, you think it's a bus, let's call it a bus!  :)

> +//!
> +//! Each bus / subsystem is expected to implement [`DriverOps`], which allows drivers to register
> +//! using the [`Registration`] class.
> +
> +use crate::error::{Error, Result};
> +use crate::{init::PinInit, str::CStr, try_pin_init, types::Opaque, ThisModule};
> +use core::pin::Pin;
> +use macros::{pin_data, pinned_drop};
> +
> +/// The [`DriverOps`] trait serves as generic interface for subsystems (e.g., PCI, Platform, Amba,
> +/// etc.) to privide the corresponding subsystem specific implementation to register / unregister a
> +/// driver of the particular type (`RegType`).
> +///
> +/// For instance, the PCI subsystem would set `RegType` to `bindings::pci_driver` and call
> +/// `bindings::__pci_register_driver` from `DriverOps::register` and
> +/// `bindings::pci_unregister_driver` from `DriverOps::unregister`.
> +pub trait DriverOps {
> +    /// The type that holds information about the registration. This is typically a struct defined
> +    /// by the C portion of the kernel.
> +    type RegType: Default;
> +
> +    /// Registers a driver.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `reg` must point to valid, initialised, and writable memory. It may be modified by this
> +    /// function to hold registration state.
> +    ///
> +    /// On success, `reg` must remain pinned and valid until the matching call to
> +    /// [`DriverOps::unregister`].
> +    fn register(
> +        reg: &mut Self::RegType,
> +        name: &'static CStr,
> +        module: &'static ThisModule,
> +    ) -> Result;
> +
> +    /// Unregisters a driver previously registered with [`DriverOps::register`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// `reg` must point to valid writable memory, initialised by a previous successful call to
> +    /// [`DriverOps::register`].
> +    fn unregister(reg: &mut Self::RegType);
> +}

So you are getting into what a bus wants/needs to support here, why is
register/unregister the "big" things to be implemented first?  Why not
just map the current register/unregister bus functions to a bus-specific
trait for now?  And then, if you think it really should be generic, we
can make it that way then.  I don't see why this needs to be generic now
as you aren't implementing a bus in rust at this point in time, right?

> +
> +/// A [`Registration`] is a generic type that represents the registration of some driver type (e.g.
> +/// `bindings::pci_driver`). Therefore a [`Registration`] is initialized with some type that
> +/// implements the [`DriverOps`] trait, such that the generic `T::register` and `T::unregister`
> +/// calls result in the subsystem specific registration calls.
> +///
> +///Once the `Registration` structure is dropped, the driver is unregistered.
> +#[pin_data(PinnedDrop)]
> +pub struct Registration<T: DriverOps> {
> +    #[pin]
> +    reg: Opaque<T::RegType>,
> +}
> +
> +// SAFETY: `Registration` has no fields or methods accessible via `&Registration`, so it is safe to
> +// share references to it with multiple threads as nothing can be done.
> +unsafe impl<T: DriverOps> Sync for Registration<T> {}
> +
> +// SAFETY: Both registration and unregistration are implemented in C and safe to be performed from
> +// any thread, so `Registration` is `Send`.
> +unsafe impl<T: DriverOps> Send for Registration<T> {}
> +
> +impl<T: DriverOps> Registration<T> {
> +    /// Creates a new instance of the registration object.
> +    pub fn new(name: &'static CStr, module: &'static ThisModule) -> impl PinInit<Self, Error> {

Drivers have modules, not busses.  So you are registering a driver with
a bus here, it's not something that a driver itself implements as you
have named here.


> +        try_pin_init!(Self {
> +            reg <- Opaque::try_ffi_init(|ptr: *mut T::RegType| {
> +                // SAFETY: `try_ffi_init` guarantees that `ptr` is valid for write.
> +                unsafe { ptr.write(T::RegType::default()) };
> +
> +                // SAFETY: `try_ffi_init` guarantees that `ptr` is valid for write, and it has
> +                // just been initialised above, so it's also valid for read.
> +                let drv = unsafe { &mut *ptr };
> +
> +                T::register(drv, name, module)
> +            }),
> +        })
> +    }
> +}
> +
> +#[pinned_drop]
> +impl<T: DriverOps> PinnedDrop for Registration<T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        let drv = unsafe { &mut *self.reg.get() };
> +
> +        T::unregister(drv);
> +    }
> +}
> +
> +/// A kernel module that only registers the given driver on init.
> +///
> +/// This is a helper struct to make it easier to define single-functionality modules, in this case,
> +/// modules that offer a single driver.
> +#[pin_data]
> +pub struct Module<T: DriverOps> {
> +    #[pin]
> +    _driver: Registration<T>,
> +}

While these are nice, let's not add them just yet, let's keep it simple
for now until we work out the proper model and see what is, and is not,
common for drivers to do.

That way we keep the review simpler as well, and saves you time
rewriting things as we rename / modify stuff.

> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -29,6 +29,7 @@
>  pub mod alloc;
>  mod build_assert;
>  pub mod device;
> +pub mod driver;

Nope, this is a bus :)

thanks,

greg k-h

