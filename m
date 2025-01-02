Return-Path: <linux-pci+bounces-19150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF8A9FF779
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 10:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120D2162014
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 09:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F206199920;
	Thu,  2 Jan 2025 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Crig4Kem"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BC5190664;
	Thu,  2 Jan 2025 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735810487; cv=none; b=fl4k8JtfFJPaFgFEhgvXNKgIXguC7DH2RMc++Ny2ZUcjJZSQDoT4AUpVEAVlygcEO/HWwjNwkYcnvu0oW5bInzcUXdNKEmFoXsCJC1jGfORIaEsoa+gUr3a9FQCe5RKE4jQ7FTIXMAyoWelUVurtaOY8qP+k2Fkk91DctsadzL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735810487; c=relaxed/simple;
	bh=OUDBQJThGstWw2l0mZV4B+XMNXyMUYV3+qOoyISK7Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEX2Z861XNVnZUCERAIiiWxnIsdXb/YvWQghcRxKZO1DRja9PohKuhR1tL+HUk/QIKxMMAdLb5ef8A+OEYHImfq59PSl3C+0HjOueWhr/Q72NallN0xxKwvaQbGfsmlelvrbPCJKNsWrw38lyDt4bfuuW56O066xL0nywYkprc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Crig4Kem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397E0C4CED0;
	Thu,  2 Jan 2025 09:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735810486;
	bh=OUDBQJThGstWw2l0mZV4B+XMNXyMUYV3+qOoyISK7Vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Crig4KemQXRV1w8TLVFsk2QTdTY7lAMSw5NQyFQMUb1IPCHUk5OGqeb9fGV7q3f6x
	 zLtp6IeSL4GHC+M0BmJXM2ysEc1e6VAZ9FffcQDTEGFG7fF4GOug7abN/WQoE57RHz
	 yTJA9hQ4CWQo0961A4ntC16Kx9aDy3JEqrDQSJiByr3l1zeN2RfdMJ3Heg4sZcU7p7
	 JCFmHSI2p5sPaxfSQN88gTxeDLWpHjY4gTqd57+Bd39sTgRtnpKyk2FisLQRxgEV6K
	 LKB04rrSZmXWmNgKEbI9EtvRPNiGZNR859TQh2tU90JFfwN7nkIB3jXbY/TdwdUmIy
	 MPIjdcKmEoPVw==
Date: Thu, 2 Jan 2025 10:34:37 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, tmgross@umich.edu,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com, paulmck@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	rcu@vger.kernel.org, Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: Re: [PATCH v7 02/16] rust: implement generic driver registration
Message-ID: <Z3ZdreeFVp_1KktC@cassiopeiae>
References: <20241219170425.12036-1-dakr@kernel.org>
 <20241219170425.12036-3-dakr@kernel.org>
 <20241224195821.3b43302b.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224195821.3b43302b.gary@garyguo.net>

Hi Gary,

On Tue, Dec 24, 2024 at 07:58:21PM +0000, Gary Guo wrote:
> On Thu, 19 Dec 2024 18:04:04 +0100
> Danilo Krummrich <dakr@kernel.org> wrote:
> 
> > Implement the generic `Registration` type and the `RegistrationOps`
> > trait.
> > 
> > The `Registration` structure is the common type that represents a driver
> > registration and is typically bound to the lifetime of a module. However,
> > it doesn't implement actual calls to the kernel's driver core to register
> > drivers itself.
> > 
> > Instead the `RegistrationOps` trait is provided to subsystems, which have
> > to implement `RegistrationOps::register` and
> > `RegistrationOps::unregister`. Subsystems have to provide an
> > implementation for both of those methods where the subsystem specific
> > variants to register / unregister a driver have to implemented.
> > 
> > For instance, the PCI subsystem would call __pci_register_driver() from
> > `RegistrationOps::register` and pci_unregister_driver() from
> > `DrvierOps::unregister`.
> > 
> > Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> 
> Hi Danilo,
> 
> I think there're soundness issues with this API, please see comments
> inlined below.

Just in case you did not note, this series has been applied to the driver-core
tree already.

> 
> Best,
> Gary
> 
> > ---
> >  MAINTAINERS           |   1 +
> >  rust/kernel/driver.rs | 117 ++++++++++++++++++++++++++++++++++++++++++
> >  rust/kernel/lib.rs    |   1 +
> >  3 files changed, 119 insertions(+)
> >  create mode 100644 rust/kernel/driver.rs
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index baf0eeb9a355..2ad58ed40079 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7033,6 +7033,7 @@ F:	include/linux/kobj*
> >  F:	include/linux/property.h
> >  F:	lib/kobj*
> >  F:	rust/kernel/device.rs
> > +F:	rust/kernel/driver.rs
> >  
> >  DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
> >  M:	Nishanth Menon <nm@ti.com>
> > diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> > new file mode 100644
> > index 000000000000..c1957ee7bb7e
> > --- /dev/null
> > +++ b/rust/kernel/driver.rs
> > @@ -0,0 +1,117 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Generic support for drivers of different buses (e.g., PCI, Platform, Amba, etc.).
> > +//!
> > +//! Each bus / subsystem is expected to implement [`RegistrationOps`], which allows drivers to
> > +//! register using the [`Registration`] class.
> > +
> > +use crate::error::{Error, Result};
> > +use crate::{init::PinInit, str::CStr, try_pin_init, types::Opaque, ThisModule};
> > +use core::pin::Pin;
> > +use macros::{pin_data, pinned_drop};
> > +
> > +/// The [`RegistrationOps`] trait serves as generic interface for subsystems (e.g., PCI, Platform,
> > +/// Amba, etc.) to provide the corresponding subsystem specific implementation to register /
> > +/// unregister a driver of the particular type (`RegType`).
> > +///
> > +/// For instance, the PCI subsystem would set `RegType` to `bindings::pci_driver` and call
> > +/// `bindings::__pci_register_driver` from `RegistrationOps::register` and
> > +/// `bindings::pci_unregister_driver` from `RegistrationOps::unregister`.
> > +pub trait RegistrationOps {
> > +    /// The type that holds information about the registration. This is typically a struct defined
> > +    /// by the C portion of the kernel.
> > +    type RegType: Default;
> > +
> > +    /// Registers a driver.
> > +    ///
> > +    /// On success, `reg` must remain pinned and valid until the matching call to
> > +    /// [`RegistrationOps::unregister`].
> 
> This looks like an obligation for the caller, so this function should
> be unsafe?
> 
> > +    fn register(
> > +        reg: &Opaque<Self::RegType>,
> > +        name: &'static CStr,
> > +        module: &'static ThisModule,
> > +    ) -> Result;
> > +
> > +    /// Unregisters a driver previously registered with [`RegistrationOps::register`].
> 
> Similarly this is an obligation for the caller.

I think you're right. I didn't want this to be unsafe, and when I got rid of the
raw pointer, and hence removed the unsafe, I did miss the fact you point out
here. It's a bit unfortunate, especially, since `register` and `unregister` are
only ever called from this file.

I'll send a patch to fix it up, unless you want to send one yourself.

> 
> > +    fn unregister(reg: &Opaque<Self::RegType>);
> > +}
> > +
> > +/// A [`Registration`] is a generic type that represents the registration of some driver type (e.g.
> > +/// `bindings::pci_driver`). Therefore a [`Registration`] must be initialized with a type that
> > +/// implements the [`RegistrationOps`] trait, such that the generic `T::register` and
> > +/// `T::unregister` calls result in the subsystem specific registration calls.
> > +///
> > +///Once the `Registration` structure is dropped, the driver is unregistered.
> > +#[pin_data(PinnedDrop)]
> > +pub struct Registration<T: RegistrationOps> {
> > +    #[pin]
> > +    reg: Opaque<T::RegType>,
> > +}
> > +
> > +// SAFETY: `Registration` has no fields or methods accessible via `&Registration`, so it is safe to
> > +// share references to it with multiple threads as nothing can be done.
> > +unsafe impl<T: RegistrationOps> Sync for Registration<T> {}
> > +
> > +// SAFETY: Both registration and unregistration are implemented in C and safe to be performed from
> > +// any thread, so `Registration` is `Send`.
> > +unsafe impl<T: RegistrationOps> Send for Registration<T> {}
> > +
> > +impl<T: RegistrationOps> Registration<T> {
> > +    /// Creates a new instance of the registration object.
> > +    pub fn new(name: &'static CStr, module: &'static ThisModule) -> impl PinInit<Self, Error> {
> > +        try_pin_init!(Self {
> > +            reg <- Opaque::try_ffi_init(|ptr: *mut T::RegType| {
> > +                // SAFETY: `try_ffi_init` guarantees that `ptr` is valid for write.
> > +                unsafe { ptr.write(T::RegType::default()) };
> 
> Any reason that this is initialised with a default, and not be up to
> `T::register` to initialise?

`T::RegType` is always an FFI type, so this can be in the common code.

> 
> > +
> > +                // SAFETY: `try_ffi_init` guarantees that `ptr` is valid for write, and it has
> > +                // just been initialised above, so it's also valid for read.
> 
> Opaque can hold uninitialised value so as long as `ptr` is not dangling
> this is fine. There's no need to actually initialise.

I think the "initialized" part is from before it was an `Opaque`.

> 
> > +                let drv = unsafe { &*(ptr as *const Opaque<T::RegType>) };
> > +
> > +                T::register(drv, name, module)
> > +            }),
> > +        })
> > +    }
> > +}
> > +
> > +#[pinned_drop]
> > +impl<T: RegistrationOps> PinnedDrop for Registration<T> {
> > +    fn drop(self: Pin<&mut Self>) {
> > +        T::unregister(&self.reg);
> > +    }
> > +}
> > +
> > +/// Declares a kernel module that exposes a single driver.
> > +///
> > +/// It is meant to be used as a helper by other subsystems so they can more easily expose their own
> > +/// macros.
> > +#[macro_export]
> 
> I think this is supposed to be used by other macros only? If so, please
> add `#[doc(hidden)]`.

Why? It's a public kernel API to be used by bus abstractions. I don't think
documentation should be for drivers only.

> 
> > +macro_rules! module_driver {
> > +    (<$gen_type:ident>, $driver_ops:ty, { type: $type:ty, $($f:tt)* }) => {
> > +        type Ops<$gen_type> = $driver_ops;
> > +
> > +        #[$crate::prelude::pin_data]
> > +        struct DriverModule {
> > +            #[pin]
> > +            _driver: $crate::driver::Registration<Ops<$type>>,
> > +        }
> > +
> > +        impl $crate::InPlaceModule for DriverModule {
> > +            fn init(
> > +                module: &'static $crate::ThisModule
> > +            ) -> impl $crate::init::PinInit<Self, $crate::error::Error> {
> > +                $crate::try_pin_init!(Self {
> > +                    _driver <- $crate::driver::Registration::new(
> > +                        <Self as $crate::ModuleMetadata>::NAME,
> > +                        module,
> > +                    ),
> > +                })
> > +            }
> > +        }
> > +
> > +        $crate::prelude::module! {
> > +            type: DriverModule,
> > +            $($f)*
> > +        }
> > +    }
> > +}
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index 61b82b78b915..7818407f9aac 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -35,6 +35,7 @@
> >  mod build_assert;
> >  pub mod cred;
> >  pub mod device;
> > +pub mod driver;
> >  pub mod error;
> >  #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
> >  pub mod firmware;
> 

