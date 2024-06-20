Return-Path: <linux-pci+bounces-9033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71A1910E25
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 19:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6351C23131
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 17:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3874F1B29BE;
	Thu, 20 Jun 2024 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNJZ+TQP"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DA317545
	for <linux-pci@vger.kernel.org>; Thu, 20 Jun 2024 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718903574; cv=none; b=AYrLtZBEKTge3Oxcg0xNLHPcsCW27TKg6mNGbFy7nvu0AdjmIS32JE0LHNx297VHIvBkZXbIXAQztL43xm7j5+vNudhY+OesZAIja8ybqlKLmlrPpHUNprakGJliDZqYqNqMSGhn70VW97YH9PE6oleawOzonjP20Pl0cpjP5iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718903574; c=relaxed/simple;
	bh=Ger7p7oM897QyYhJ1XeuOYoIhv0OV/8UpvuFlLKlA1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1CyPUGuJZSGpVYAMrwj1VpBC2XGdfGeUcHPvHU1Th7IAcn+lNSP1Et0C5oTzHf8S9krQrKIYvU8ozYqc7xbIs6QyUwDWSLJez7ttxRdi1Lk1IMnr0cy0GsAo7w7QL0ZAREzGQ+OUsWNEma8cRhE7iCI3/KZJu2RTDQbBt65QKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NNJZ+TQP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718903570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ONGpA5HC1cN6Ni1gaU57LS84x/FJ3aonLWqa6dVT81g=;
	b=NNJZ+TQPm2L74HFfx2deGiLrdl8LPiXC8HxhHTzDIboFzPJ8N0giMW5XdM9YbwUQ2HlCZb
	50Ocoatg47tmFgv4dmciIGRuleRY1lkYhky/UMCqEaHllzWeX9L7Os/BTiEzQ14LAO4Adu
	JcizpmAbIstYJ96YCJjJwFVekBqqFxw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-LSAyaKSlON-niDCiDZ_Cog-1; Thu, 20 Jun 2024 13:12:48 -0400
X-MC-Unique: LSAyaKSlON-niDCiDZ_Cog-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3648793ae51so618097f8f.2
        for <linux-pci@vger.kernel.org>; Thu, 20 Jun 2024 10:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718903567; x=1719508367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONGpA5HC1cN6Ni1gaU57LS84x/FJ3aonLWqa6dVT81g=;
        b=LVP3TbylLtfFfE53au1gPRAmuh079l/8t6pVLxwyMybCN+47ipa0R61wonbmGVKOI4
         AHAy4mFXFFp7T6j3UE4Tteu8g8iiosJCT9CPvPsh1NbrEHuWX/wVGSJhz+sg0t2yyJSY
         Ms2VST2R/I1uaACWHhup5CMcOAGomXqhH9qdIe13YY6vgIjrrX8mFFJrqFpYtJx9fx3H
         IK4kW1OSpEe7D8rqrM6sn1HEdXuaB/RnSlDm4XImR4XzPX6ZB0YVM6Ouw5IhX3+PBYYd
         Bojh7mCvoVOrmAngDADQ8IpOSYJ8u48wtwe74O61cd7bPCgp7SRu65CFquGzMN40TSwN
         CmgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsRNG5x2YXt3VI6G7x/tHbD3mN+BFU6PwqNz+cffgjr0hgmMU+N9XusbW6TN5X05T2muNoBDrPARNr/hnbVNceoxCsXKI3zItq
X-Gm-Message-State: AOJu0Yy2+tIYLJpVhDnw+7CZe3EP6nDqFvB966u0GW/bw+BLz3IsDpIj
	oyxLenChjdEf7PtVZybdODXrQ11W0y8pjHkm41chUViBXchrDkygtK8bwa8qLsqScMIVoqJdchm
	EhxAUMjc+EF52dTakLEC7LWz85UTg7EmY77wLp5o3INCHNHg17SOcTeztsA==
X-Received: by 2002:adf:ce09:0:b0:35f:22e4:fb58 with SMTP id ffacd0b85a97d-363170ecb01mr4418468f8f.8.1718903567337;
        Thu, 20 Jun 2024 10:12:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq7ukG6AgkRzqD6QNBAGj1MkzX4TQMCHRwQ7LnYNRoVq6cRRzQn4cru40hot5nzW1ZmNXqFA==
X-Received: by 2002:adf:ce09:0:b0:35f:22e4:fb58 with SMTP id ffacd0b85a97d-363170ecb01mr4418435f8f.8.1718903566840;
        Thu, 20 Jun 2024 10:12:46 -0700 (PDT)
Received: from cassiopeiae ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-362a5ff6085sm6577954f8f.106.2024.06.20.10.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:12:46 -0700 (PDT)
Date: Thu, 20 Jun 2024 19:12:42 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 02/10] rust: implement generic driver registration
Message-ID: <ZnRjCnvtPBhEatt_@cassiopeiae>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240618234025.15036-3-dakr@redhat.com>
 <2024062025-wrecking-utilize-30cf@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024062025-wrecking-utilize-30cf@gregkh>

On Thu, Jun 20, 2024 at 04:28:23PM +0200, Greg KH wrote:
> On Wed, Jun 19, 2024 at 01:39:48AM +0200, Danilo Krummrich wrote:
> > Implement the generic `Registration` type and the `DriverOps` trait.
> 
> I don't think this is needed, more below...
> 
> > The `Registration` structure is the common type that represents a driver
> > registration and is typically bound to the lifetime of a module. However,
> > it doesn't implement actual calls to the kernel's driver core to register
> > drivers itself.
> 
> But that's not what normally happens, more below...

I can't find below a paragraph that seems related to this, hence I reply here.

The above is just different wording for: A driver is typically registered in
module_init() and unregistered in module_exit().

Isn't that what happens normally?

> 
> > Instead the `DriverOps` trait is provided to subsystems, which have to
> > implement `DriverOps::register` and `DrvierOps::unregister`. Subsystems
> > have to provide an implementation for both of those methods where the
> > subsystem specific variants to register / unregister a driver have to
> > implemented.
> 
> So you are saying this should be something that a "bus" would do?
> Please be explicit as to what you mean by "subsystem" here.

Yes, I agree it's more precise to say that this should be implemented by a bus
(e.g. PCI). I can reword this one.

> 
> > For instance, the PCI subsystem would call __pci_register_driver() from
> > `DriverOps::register` and pci_unregister_driver() from
> > `DrvierOps::unregister`.
> 
> So this is a BusOps, or more in general, a "subsystem" if it's not a
> bus (i.e. it's a class).  Note, we used to use the term "subsystem" a
> very long time ago but got rid of them in the driver core, let's not
> bring it back unless we REALLY know we want it this time.
> 
> So why isn't this just a BusOps?

I think it's really about perspective. Generally speaking, when a driver is
registered it gets added to a bus through bus_add_driver(). Now, one could argue
that the "register" operation is a bus operation, since something gets
registered on the bus, but one could also argue that it's a driver operation,
since a driver is registered on something.

Consequently, I think it's neither wrong to call this one `BusOps` nor is it
wrong to call it `DriverOps`.

I still think `DriverOps` is more appropriate, since here we're looking at it
from the perspective of the driver.

In the end we call it as `driver.register()` instead of `bus.register()`. For
instance, in the PCI implementation of it, we call __pci_register_driver() from
`DriverOps::register`.

> > This patch is based on previous work from Wedson Almeida Filho.
> > 
> > Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > ---
> >  rust/kernel/driver.rs | 128 ++++++++++++++++++++++++++++++++++++++++++
> >  rust/kernel/lib.rs    |   1 +
> >  2 files changed, 129 insertions(+)
> >  create mode 100644 rust/kernel/driver.rs
> > 
> > diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> > new file mode 100644
> > index 000000000000..e04406b93b56
> > --- /dev/null
> > +++ b/rust/kernel/driver.rs
> > @@ -0,0 +1,128 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Generic support for drivers of different buses (e.g., PCI, Platform, Amba, etc.).
> 
> See, you think it's a bus, let's call it a bus!  :)
> 
> > +//!
> > +//! Each bus / subsystem is expected to implement [`DriverOps`], which allows drivers to register
> > +//! using the [`Registration`] class.
> > +
> > +use crate::error::{Error, Result};
> > +use crate::{init::PinInit, str::CStr, try_pin_init, types::Opaque, ThisModule};
> > +use core::pin::Pin;
> > +use macros::{pin_data, pinned_drop};
> > +
> > +/// The [`DriverOps`] trait serves as generic interface for subsystems (e.g., PCI, Platform, Amba,
> > +/// etc.) to privide the corresponding subsystem specific implementation to register / unregister a
> > +/// driver of the particular type (`RegType`).
> > +///
> > +/// For instance, the PCI subsystem would set `RegType` to `bindings::pci_driver` and call
> > +/// `bindings::__pci_register_driver` from `DriverOps::register` and
> > +/// `bindings::pci_unregister_driver` from `DriverOps::unregister`.
> > +pub trait DriverOps {
> > +    /// The type that holds information about the registration. This is typically a struct defined
> > +    /// by the C portion of the kernel.
> > +    type RegType: Default;
> > +
> > +    /// Registers a driver.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `reg` must point to valid, initialised, and writable memory. It may be modified by this
> > +    /// function to hold registration state.
> > +    ///
> > +    /// On success, `reg` must remain pinned and valid until the matching call to
> > +    /// [`DriverOps::unregister`].
> > +    fn register(
> > +        reg: &mut Self::RegType,
> > +        name: &'static CStr,
> > +        module: &'static ThisModule,
> > +    ) -> Result;
> > +
> > +    /// Unregisters a driver previously registered with [`DriverOps::register`].
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `reg` must point to valid writable memory, initialised by a previous successful call to
> > +    /// [`DriverOps::register`].
> > +    fn unregister(reg: &mut Self::RegType);
> > +}
> 
> So you are getting into what a bus wants/needs to support here, why is
> register/unregister the "big" things to be implemented first?  Why not
> just map the current register/unregister bus functions to a bus-specific
> trait for now?  And then, if you think it really should be generic, we

A bus specific trait would not add any value. The whole point if a trait is to
represent a generic interface. It basically describes the functionality we
expect from a certain category of types.

In this case we know that every driver can be registered and unregistered, hence
we can define a generic trait that every bus specific driver structure, e.g. PCI
driver, has to implement.

> can make it that way then.  I don't see why this needs to be generic now
> as you aren't implementing a bus in rust at this point in time, right?

With the above tait (or interface) we now can have a generic `Registration` that
calls `T::register` and `T::unregister` and works for all driver types (PCI,
platform, etc.). Otherwise we'd need a `pci::Registration`, a
`platform::Registration` etc. and copy-paste the below code for all of them.

> 
> > +
> > +/// A [`Registration`] is a generic type that represents the registration of some driver type (e.g.
> > +/// `bindings::pci_driver`). Therefore a [`Registration`] is initialized with some type that
> > +/// implements the [`DriverOps`] trait, such that the generic `T::register` and `T::unregister`
> > +/// calls result in the subsystem specific registration calls.
> > +///
> > +///Once the `Registration` structure is dropped, the driver is unregistered.
> > +#[pin_data(PinnedDrop)]
> > +pub struct Registration<T: DriverOps> {
> > +    #[pin]
> > +    reg: Opaque<T::RegType>,
> > +}
> > +
> > +// SAFETY: `Registration` has no fields or methods accessible via `&Registration`, so it is safe to
> > +// share references to it with multiple threads as nothing can be done.
> > +unsafe impl<T: DriverOps> Sync for Registration<T> {}
> > +
> > +// SAFETY: Both registration and unregistration are implemented in C and safe to be performed from
> > +// any thread, so `Registration` is `Send`.
> > +unsafe impl<T: DriverOps> Send for Registration<T> {}
> > +
> > +impl<T: DriverOps> Registration<T> {
> > +    /// Creates a new instance of the registration object.
> > +    pub fn new(name: &'static CStr, module: &'static ThisModule) -> impl PinInit<Self, Error> {
> 
> Drivers have modules, not busses.  So you are registering a driver with
> a bus here, it's not something that a driver itself implements as you
> have named here.

We are registering a driver on bus here, see the below `T::register` call, this
one ends up in __pci_register_driver() or __platform_driver_register(), etc. Hence
we need the module and the module name.

Please see the first patch of the series for an explanation why THIS_MODULE and
KBUILD_MODNAME is not in scope here and why we need to pass this through.

> 
> 
> > +        try_pin_init!(Self {
> > +            reg <- Opaque::try_ffi_init(|ptr: *mut T::RegType| {
> > +                // SAFETY: `try_ffi_init` guarantees that `ptr` is valid for write.
> > +                unsafe { ptr.write(T::RegType::default()) };
> > +
> > +                // SAFETY: `try_ffi_init` guarantees that `ptr` is valid for write, and it has
> > +                // just been initialised above, so it's also valid for read.
> > +                let drv = unsafe { &mut *ptr };
> > +
> > +                T::register(drv, name, module)
> > +            }),
> > +        })
> > +    }
> > +}
> > +
> > +#[pinned_drop]
> > +impl<T: DriverOps> PinnedDrop for Registration<T> {
> > +    fn drop(self: Pin<&mut Self>) {
> > +        let drv = unsafe { &mut *self.reg.get() };
> > +
> > +        T::unregister(drv);
> > +    }
> > +}
> > +
> > +/// A kernel module that only registers the given driver on init.
> > +///
> > +/// This is a helper struct to make it easier to define single-functionality modules, in this case,
> > +/// modules that offer a single driver.
> > +#[pin_data]
> > +pub struct Module<T: DriverOps> {
> > +    #[pin]
> > +    _driver: Registration<T>,
> > +}
> 
> While these are nice, let's not add them just yet, let's keep it simple
> for now until we work out the proper model and see what is, and is not,
> common for drivers to do.

Honestly, even though it seems to be complicated, this is in fact the simple
way. This really is the minimum we can do to register a driver and get it
probed.

Please also consider that all the abstractions I am submitting in this series
are only making use of APIs that regular C drivers use as well. This series
doesn't touch internals of any subsystem.

Hence, we know the model very well. It's the same as in C, we're just
abstracting it into common Rust design patterns.

The only exception might be passing through the module name, but this is just
the consequence of the design and necessity that already has been discussed and
was merged.

> 
> That way we keep the review simpler as well, and saves you time
> rewriting things as we rename / modify stuff.
> 
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -29,6 +29,7 @@
> >  pub mod alloc;
> >  mod build_assert;
> >  pub mod device;
> > +pub mod driver;
> 
> Nope, this is a bus :)
> 
> thanks,
> 
> greg k-h
> 


