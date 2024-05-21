Return-Path: <linux-pci+bounces-7706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAE08CA990
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 10:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9A11C20F86
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 08:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB89E4CE04;
	Tue, 21 May 2024 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kUQMWWjX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB3A46521;
	Tue, 21 May 2024 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716278645; cv=none; b=rRaD+u1nSuZNwiQmbEJXdHCg8XlDJGbZMNOYahWKIRVoq0tDZHRXrRqRtLGBPnNlde4GvgS9kKVf8IZvzv9VUt0ltXkNwHF6P0wo/bu8sB92gZbB3hkevQSJAsuOEsn5qqKJVfvvq4RwFYFJuHgtf0UUw/W40hXeS6kE8Xy3mVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716278645; c=relaxed/simple;
	bh=fkLgpu0lDtMUuqakm3N4Eb4WX76RtVTDdfpc5Wjd6qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUr/P/iizxcfyAs7xrTjQ/7TSRkEN9c2nSmitVjuEy1xMJf8ZhOHH8g2WPj9TyXBQN3TFPjR6QlxfDu18BnQry/pUpQDi1whgo/0OnyTHZRftToUFT3ElKBkoHKZ0MZbvUSjzVqSkRNZKfTe+PraMgJ0USuzlj8wlzV4MsyPfis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kUQMWWjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E9DC2BD11;
	Tue, 21 May 2024 08:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716278645;
	bh=fkLgpu0lDtMUuqakm3N4Eb4WX76RtVTDdfpc5Wjd6qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kUQMWWjXL7fLwLhYuQkpJdruRezPgOIsDAK7Eyy/Zxz+xOIdUr0HUuR0nl4dz1azF
	 sQ+4KeYai4zte9N3OpITPI2xEzSIOQa+rhMXbuFtWmhqxkASXzi3rYaFuXR6IS16+V
	 JXzzBysQ4i7F3M6Qtmv/J0KIWBWdk+mbZ0SuUoOA=
Date: Tue, 21 May 2024 10:04:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dave Airlie <airlied@gmail.com>
Cc: Danilo Krummrich <dakr@redhat.com>, rafael@kernel.org,
	bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com,
	wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 02/11] rust: add driver abstraction
Message-ID: <2024052125-vagueness-tackiness-826b@gregkh>
References: <20240520172554.182094-1-dakr@redhat.com>
 <20240520172554.182094-3-dakr@redhat.com>
 <2024052045-lived-retiree-d8b9@gregkh>
 <CAPM=9txQPmYU593MAR97yyCoHaQR3o+E_N1D2mJjP23Gevzddw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9txQPmYU593MAR97yyCoHaQR3o+E_N1D2mJjP23Gevzddw@mail.gmail.com>

On Tue, May 21, 2024 at 03:42:50PM +1000, Dave Airlie wrote:
> On Tue, 21 May 2024 at 04:14, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, May 20, 2024 at 07:25:39PM +0200, Danilo Krummrich wrote:
> > > From: Wedson Almeida Filho <wedsonaf@gmail.com>
> > >
> > > This defines general functionality related to registering drivers with
> > > their respective subsystems, and registering modules that implement
> > > drivers.
> > >
> > > Co-developed-by: Asahi Lina <lina@asahilina.net>
> > > Signed-off-by: Asahi Lina <lina@asahilina.net>
> > > Co-developed-by: Andreas Hindborg <a.hindborg@samsung.com>
> > > Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> > > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > > ---
> > >  rust/kernel/driver.rs        | 492 +++++++++++++++++++++++++++++++++++
> > >  rust/kernel/lib.rs           |   4 +-
> > >  rust/macros/module.rs        |   2 +-
> > >  samples/rust/rust_minimal.rs |   2 +-
> > >  samples/rust/rust_print.rs   |   2 +-
> > >  5 files changed, 498 insertions(+), 4 deletions(-)
> > >  create mode 100644 rust/kernel/driver.rs
> > >
> > > diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> > > new file mode 100644
> > > index 000000000000..e0cfc36d47ff
> > > --- /dev/null
> > > +++ b/rust/kernel/driver.rs
> > > @@ -0,0 +1,492 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +//! Generic support for drivers of different buses (e.g., PCI, Platform, Amba, etc.).
> > > +//!
> > > +//! Each bus/subsystem is expected to implement [`DriverOps`], which allows drivers to register
> > > +//! using the [`Registration`] class.
> >
> > Why are you creating new "names" here?  "DriverOps" is part of a 'struct
> > device_driver' why are you separating it out here?  And what is
> > 'Registration'?  That's a bus/class thing, not a driver thing.
> >
> > And be very careful of the use of the word 'class' here, remember, there
> > is 'struct class' as part of the driver model :)
> >
> > > +use crate::{
> > > +    alloc::{box_ext::BoxExt, flags::*},
> > > +    error::code::*,
> > > +    error::Result,
> > > +    str::CStr,
> > > +    sync::Arc,
> > > +    ThisModule,
> > > +};
> > > +use alloc::boxed::Box;
> > > +use core::{cell::UnsafeCell, marker::PhantomData, ops::Deref, pin::Pin};
> > > +
> > > +/// A subsystem (e.g., PCI, Platform, Amba, etc.) that allows drivers to be written for it.
> > > +pub trait DriverOps {
> >
> > Again, why is this not called DeviceDriver?
> 
> This is not the same as the C device_driver, it might mildly align in
> concept with it, but I'm not sure it shares enough to align it name
> wise with the C one.

Why not use the same terms and design decisions that the C code has?  To
differ needs to have a good reason, otherwise it's just going to cause
us all confusion as we have to learn two different terms for the same
thing.

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
> > > +    unsafe fn register(
> > > +        reg: *mut Self::RegType,
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
> > > +    unsafe fn unregister(reg: *mut Self::RegType);
> > > +}
> > > +
> > > +/// The registration of a driver.
> > > +pub struct Registration<T: DriverOps> {
> > > +    is_registered: bool,
> >
> > Why does a driver need to know if it is registered or not?  Only the
> > driver core cares about that, please do not expose that, it's racy and
> > should not be relied on.
> 
> >From the C side this does look unusual because on the C side something
> like struct pci_driver is statically allocated everywhere.
> In this rust abstraction, these are allocated dynamically, so instead
> of just it always being safe to just call register/unregister
> with static memory, a flag is kept around to say if the unregister
> should happen at all, as the memory may have
> been allocated but never registered. This is all the Registration is
> for, it's tracking the bus _driver structure allocation, and
> whether the bus register/unregister have been called since the object
> was allocated.
> 
> I'm not sure it makes sense (or if you can at all), have a static like
> pci_driver object here to match how C does things.

Wait, why can't you have a static "rust_driver" type thing?  Having it
be in ram feels like a waste of memory.  We are working hard to move
more and more of these driver model structures into read-only memory for
good reasons (security, reduce bugs, etc.), moving backwards to having
them all be dynamically created/copied around feels wrong.

We are one stage away from being able to mark all 'driver_*()' calls as
using a const * to struct driver, please don't make that work pointless
if you want to write a driver in rust instead.

And again, a driver should never know/care/wonder if it has been
registered or not, that is up to the driver core to handle, not the rust
code, as it is the only thing that can know this, and the only thing
that should need to know it.  A driver structure should not have any
dynamic memory associated with it to require knowing its "state" in the
system, so let's not move backwards here to require that just because we
are using Rust.

> > > +impl<T: DriverOps> Drop for Registration<T> {
> > > +    fn drop(&mut self) {
> > > +        if self.is_registered {
> > > +            // SAFETY: This path only runs if a previous call to `T::register` completed
> > > +            // successfully.
> > > +            unsafe { T::unregister(self.concrete_reg.get()) };
> >
> > Can't the rust code ensure that this isn't run if register didn't
> > succeed?  Having a boolean feels really wrong here (can't that race?)
> 
> There might be a way of using Option<> here but I don't think it adds
> anything over and above using an explicit bool.

Again, this should not be needed.  If so, something is designed
incorrectly with the bindings.

> > > +///
> > > +/// This is meant to be implemented by buses/subsystems so that they can use [`IdTable`] to
> > > +/// guarantee (at compile-time) zero-termination of device id tables provided by drivers.
> > > +///
> > > +/// Originally, RawDeviceId was implemented as a const trait. However, this unstable feature is
> > > +/// broken/gone in 1.73. To work around this, turn IdArray::new() into a macro such that it can use
> > > +/// concrete types (which can still have const associated functions) instead of a trait.
> > > +///
> > > +/// # Safety
> > > +///
> > > +/// Implementers must ensure that:
> > > +///   - [`RawDeviceId::ZERO`] is actually a zeroed-out version of the raw device id.
> > > +///   - [`RawDeviceId::to_rawid`] stores `offset` in the context/data field of the raw device id so
> > > +///     that buses can recover the pointer to the data.
> > > +pub unsafe trait RawDeviceId {
> > > +    /// The raw type that holds the device id.
> > > +    ///
> > > +    /// Id tables created from [`Self`] are going to hold this type in its zero-terminated array.
> > > +    type RawType: Copy;
> > > +
> > > +    /// A zeroed-out representation of the raw device id.
> > > +    ///
> > > +    /// Id tables created from [`Self`] use [`Self::ZERO`] as the sentinel to indicate the end of
> > > +    /// the table.
> > > +    const ZERO: Self::RawType;
> >
> > All busses have their own way of creating "ids" and that is limited to
> > the bus code itself, why is any of this in the rust side?  What needs
> > this?  A bus will create the id for the devices it manages, and can use
> > it as part of the name it gives the device (but not required), so all of
> > this belongs to the bus, NOT to a driver, or a device.
> 
> Consider this a base class (Trait) for bus specific IDs.

Then all of that should be in a separate file as they belong to a "bus"
not a driver, as each and every bus will have a different way of
expressing the list of devices a driver can bind to.

And again, the core "struct device_driver" does not have a list of ids,
and neither should the rust bindings, that belongs to the bus logic.

> > > +/// Custom code within device removal.
> >
> > You better define the heck out of "device removal" as specified last
> > time this all came up.  From what I can see here, this is totally wrong
> > and confusing and will be a mess.
> >
> > Do it right, name it properly.
> >
> > I'm not reviewingn beyond here, sorry.  It's the merge window and I
> > shouldn't have even looked at this until next week anyway.
> >
> > But I was hoping that the whole long rant I gave last time would be
> > addressed at least a little bit.  I don't see that it has :(
> 
> I won't comment too much on the specifics here, but you've twice got
> to this stage, said something is wrong, change it, and given no
> actionable feedback on what is wrong, or what to change.
> 
> I've looked at this code for a few hours today with the device docs
> and core code and can't spot what you are seeing that is wrong here,
> which means I don't expect anyone else is going to unless you can help
> educate us more.

A lifecycle of a device is:
	device create by the bus
	device register with driver core
	device bind to a driver (i.e. probe() callback in the driver)
	device unbind from a driver (i.e. remove() callback in the driver, can be triggered many ways)
	device destroy by the bus

"remove" can happen for a driver where it needs to clean up everything
it has done for a specific device, but that does not mean the device is
actually gone from the system, that's up to the bus to decide, as it
owns the device lifecycle and gets to decide when it thinks it is really
gone.  And then, when the bus tells the driver core that it wants to
mark the device as "destroyed", it's up to the driver core to eventually
call back into the bus to really clean that device up from the system at
some later point in time.

Try splitting this file out into driver and bus and device logic, like
the driver core has, and see if that helps in explaining and making all
of this more understandable, and to keep with the names/design of the
model we currently have.

Note, all of this is my biggest worry about writing a driver in rust,
getting the lifecycle of the driver core and it's logic of how it
handles memory manged in C, to align up with how rust is going to access
it with its different rules and requirements, is not going to be simple
as you have two different models intersecting at the same place.  I've
been working over the past year to make the rust side happen easier by
marking more and more of the C structures as "not mutable", i.e. const
*, so that the Rust side doesn't have to worry that the driver core
really will change things it passes to the C side, but there is more to
be done (see above about making struct device_driver * const).

I want to see this happen, but it's going to be a hard slog due to the
different expectations of these two systems.  Keeping naming identical
where possible is one way to make it simpler for everyone involved, as
would splitting the logic out the same way and not mixing it all up into
one big hairy file that combines different things into a single chunk.

thanks,

greg k-h

