Return-Path: <linux-pci+bounces-10082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3840E92D3E5
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 16:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5F128678D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 14:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0D41940B0;
	Wed, 10 Jul 2024 14:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JAxcEy7C"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4123419346A;
	Wed, 10 Jul 2024 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620643; cv=none; b=eB26ueZXhR1YgwwSYu3DIO6q6AhZPiCbN+JVjk0pxC4GPcKWhxjnStqviyiHj3JDYK//Vg8x8dESNREkxBFs7U/auHVQZUZLKpjtbTXs6L+VUUd2Lpr6G8UzvNXwfx5ajdFfXViDEtFlMT8fNXdlVYZwRi2LZ565JvT/N4UVBu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620643; c=relaxed/simple;
	bh=nDTy8rPWM2cyZ0nmnNV1tC8bbKmApbzgWSzmCTAq4gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gw+6SNtoMBkQRUv7FqEnX3i3YMY1Gj6LVkX22AXC6FjN5LXtJHgfL1GhusLIps/2355s0v8VgJ+vnQ3KsH/IwdIpxgs9bHMR07k+YDLk94hEiQPm7DRxal+vjsSQbjpYibkMrj0FcQJxML8IjXc2Sq9iHk+66jjRIZL7kxrMlLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JAxcEy7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FAFC32781;
	Wed, 10 Jul 2024 14:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720620642;
	bh=nDTy8rPWM2cyZ0nmnNV1tC8bbKmApbzgWSzmCTAq4gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JAxcEy7CxmTqyvvy3ArzfYyP8035acIouQ67LSfrd3qEoUlreswixmuhOBvq9egi0
	 OW40zZOrUQ+9rC51WW87KPZ188bp1YBpqP5I4HX0JPYn0f/flG9LblKRtlR6Rb7j+K
	 fbt2+J1pECTgx9Ic0OvGqstXS4yDxgn0CSRu65fc=
Date: Wed, 10 Jul 2024 16:10:40 +0200
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
Message-ID: <2024071052-bunion-kinswoman-6577@gregkh>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240618234025.15036-3-dakr@redhat.com>
 <2024062025-wrecking-utilize-30cf@gregkh>
 <ZnRjCnvtPBhEatt_@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnRjCnvtPBhEatt_@cassiopeiae>

On Thu, Jun 20, 2024 at 07:12:42PM +0200, Danilo Krummrich wrote:
> On Thu, Jun 20, 2024 at 04:28:23PM +0200, Greg KH wrote:
> > On Wed, Jun 19, 2024 at 01:39:48AM +0200, Danilo Krummrich wrote:
> > > Implement the generic `Registration` type and the `DriverOps` trait.
> > 
> > I don't think this is needed, more below...
> > 
> > > The `Registration` structure is the common type that represents a driver
> > > registration and is typically bound to the lifetime of a module. However,
> > > it doesn't implement actual calls to the kernel's driver core to register
> > > drivers itself.
> > 
> > But that's not what normally happens, more below...
> 
> I can't find below a paragraph that seems related to this, hence I reply here.
> 
> The above is just different wording for: A driver is typically registered in
> module_init() and unregistered in module_exit().
> 
> Isn't that what happens normally?

Yes, but it's nothing we have ever used in the kernel before.  You are
defining new terms in some places, and renaming existing ones in others,
which is going to do nothing but confuse us all.

I don't see why you need a "registration" structure here when no .c
driver ever does.  You just have a module init/exit call and go from
there.  Why not stick with that?

> > > Instead the `DriverOps` trait is provided to subsystems, which have to
> > > implement `DriverOps::register` and `DrvierOps::unregister`. Subsystems
> > > have to provide an implementation for both of those methods where the
> > > subsystem specific variants to register / unregister a driver have to
> > > implemented.
> > 
> > So you are saying this should be something that a "bus" would do?
> > Please be explicit as to what you mean by "subsystem" here.
> 
> Yes, I agree it's more precise to say that this should be implemented by a bus
> (e.g. PCI). I can reword this one.

Wording matters.

> > > For instance, the PCI subsystem would call __pci_register_driver() from
> > > `DriverOps::register` and pci_unregister_driver() from
> > > `DrvierOps::unregister`.
> > 
> > So this is a BusOps, or more in general, a "subsystem" if it's not a
> > bus (i.e. it's a class).  Note, we used to use the term "subsystem" a
> > very long time ago but got rid of them in the driver core, let's not
> > bring it back unless we REALLY know we want it this time.
> > 
> > So why isn't this just a BusOps?
> 
> I think it's really about perspective. Generally speaking, when a driver is
> registered it gets added to a bus through bus_add_driver(). Now, one could argue
> that the "register" operation is a bus operation, since something gets
> registered on the bus, but one could also argue that it's a driver operation,
> since a driver is registered on something.
> 
> Consequently, I think it's neither wrong to call this one `BusOps` nor is it
> wrong to call it `DriverOps`.
> 
> I still think `DriverOps` is more appropriate, since here we're looking at it
> from the perspective of the driver.

Stick with the same terms we have today please.  These are specific bus
operations.  Some drivers implement multiple bus operations within them
as they can handle multiple bus types.  Keep the same names we have
today, it will save maintaining this for the next 40+ years easier.

> In the end we call it as `driver.register()` instead of `bus.register()`. For
> instance, in the PCI implementation of it, we call __pci_register_driver() from
> `DriverOps::register`.

You are registering with a bus, stick with that term please.

> > > +/// The [`DriverOps`] trait serves as generic interface for subsystems (e.g., PCI, Platform, Amba,
> > > +/// etc.) to privide the corresponding subsystem specific implementation to register / unregister a
> > > +/// driver of the particular type (`RegType`).
> > > +///
> > > +/// For instance, the PCI subsystem would set `RegType` to `bindings::pci_driver` and call
> > > +/// `bindings::__pci_register_driver` from `DriverOps::register` and
> > > +/// `bindings::pci_unregister_driver` from `DriverOps::unregister`.
> > > +pub trait DriverOps {
> > > +    /// The type that holds information about the registration. This is typically a struct defined
> > > +    /// by the C portion of the kernel.
> > > +    type RegType: Default;
> > > +
> > > +    /// Registers a driver.
> > > +    ///
> > > +    /// # Safety
> > > +    ///
> > > +    /// `reg` must point to valid, initialised, and writable memory. It may be modified by this
> > > +    /// function to hold registration state.
> > > +    ///
> > > +    /// On success, `reg` must remain pinned and valid until the matching call to
> > > +    /// [`DriverOps::unregister`].
> > > +    fn register(
> > > +        reg: &mut Self::RegType,
> > > +        name: &'static CStr,
> > > +        module: &'static ThisModule,
> > > +    ) -> Result;
> > > +
> > > +    /// Unregisters a driver previously registered with [`DriverOps::register`].
> > > +    ///
> > > +    /// # Safety
> > > +    ///
> > > +    /// `reg` must point to valid writable memory, initialised by a previous successful call to
> > > +    /// [`DriverOps::register`].
> > > +    fn unregister(reg: &mut Self::RegType);
> > > +}
> > 
> > So you are getting into what a bus wants/needs to support here, why is
> > register/unregister the "big" things to be implemented first?  Why not
> > just map the current register/unregister bus functions to a bus-specific
> > trait for now?  And then, if you think it really should be generic, we
> 
> A bus specific trait would not add any value. The whole point if a trait is to
> represent a generic interface. It basically describes the functionality we
> expect from a certain category of types.
> 
> In this case we know that every driver can be registered and unregistered, hence
> we can define a generic trait that every bus specific driver structure, e.g. PCI
> driver, has to implement.

So this is a generic trait that all drivers of all bus types must do?
Ick, no, don't make this so generic it's impossible to unwind.

Make things specific FIRST.  Then implement a second one.  Then a third
one.  And THEN see what you can make generic, before then it's going to
be hard and a mess.

Stick with specifics first, you can always make them more generic later.

> > can make it that way then.  I don't see why this needs to be generic now
> > as you aren't implementing a bus in rust at this point in time, right?
> 
> With the above tait (or interface) we now can have a generic `Registration` that
> calls `T::register` and `T::unregister` and works for all driver types (PCI,
> platform, etc.). Otherwise we'd need a `pci::Registration`, a
> `platform::Registration` etc. and copy-paste the below code for all of them.

Good, copy/paste to start with and then if it gets messy on the third
implementation, THEN we can think about unifying them.

I'm going to argue that registering with a pci bus is VERY different
than registering with the platform bus, or a USB bus, which, if you look
at the kernel today, is why those are different functions!  Only in the
driver core is the unified portions.  Don't attempt to make the rust
code generic and then have it split back out, and THEN have it become
generic afterward.  That's an odd way to do things, please don't.

> > > +
> > > +/// A [`Registration`] is a generic type that represents the registration of some driver type (e.g.
> > > +/// `bindings::pci_driver`). Therefore a [`Registration`] is initialized with some type that
> > > +/// implements the [`DriverOps`] trait, such that the generic `T::register` and `T::unregister`
> > > +/// calls result in the subsystem specific registration calls.
> > > +///
> > > +///Once the `Registration` structure is dropped, the driver is unregistered.
> > > +#[pin_data(PinnedDrop)]
> > > +pub struct Registration<T: DriverOps> {
> > > +    #[pin]
> > > +    reg: Opaque<T::RegType>,
> > > +}
> > > +
> > > +// SAFETY: `Registration` has no fields or methods accessible via `&Registration`, so it is safe to
> > > +// share references to it with multiple threads as nothing can be done.
> > > +unsafe impl<T: DriverOps> Sync for Registration<T> {}
> > > +
> > > +// SAFETY: Both registration and unregistration are implemented in C and safe to be performed from
> > > +// any thread, so `Registration` is `Send`.
> > > +unsafe impl<T: DriverOps> Send for Registration<T> {}
> > > +
> > > +impl<T: DriverOps> Registration<T> {
> > > +    /// Creates a new instance of the registration object.
> > > +    pub fn new(name: &'static CStr, module: &'static ThisModule) -> impl PinInit<Self, Error> {
> > 
> > Drivers have modules, not busses.  So you are registering a driver with
> > a bus here, it's not something that a driver itself implements as you
> > have named here.
> 
> We are registering a driver on bus here, see the below `T::register` call, this
> one ends up in __pci_register_driver() or __platform_driver_register(), etc. Hence
> we need the module and the module name.

Again, let's be specific first, make things generic later.  Why do you
need/want a trait at all when you have only 1 bus type in the whole
kernel?

Keep it simple, make it so obvious that I would be foolish to reject it.
Right now, it's so complex and generic that I feel foolish accepting it.

thanks,

greg k-h

