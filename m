Return-Path: <linux-pci+bounces-7711-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6DE8CAADA
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 11:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722191C21804
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 09:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E338857C8B;
	Tue, 21 May 2024 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DWX2URUB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF0D51C30;
	Tue, 21 May 2024 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716284146; cv=none; b=ANAGlaJFmsTl9+ZFONHRHGwAQiXd0633OjO+Ly5BgeZF6kQYt93tGNQfgC43u/+e+DhZs01VEiTRMrpQCHs22S37poRzQEXWbJKyWhXFWQ4ucKAjYMI6lSGWZCftAjTQ2zGYmMZz77m87tQmV6XsWYj43q62kP4tSa2bsvmoiI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716284146; c=relaxed/simple;
	bh=h2y4kqBj3xtVPuMZfsEpwMJV6NjA6ct4HRvoImPW/1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oB3frQ1vd89C5z6Dynxm1Kd1m4uvf+xMUTDzUBGoKT4Tj6AAzwOHA6KwSBNe6WDi57blbpG6E5QPy2Mg7GRq+O1CAHiPnbc9spix1qu3+1pnd1OK81OabwFV/QPaoAZitb/c6rDe8fNulwHrC25QppA2agf5Fd+UJ0e2jPjvIiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DWX2URUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DD7C2BD11;
	Tue, 21 May 2024 09:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716284146;
	bh=h2y4kqBj3xtVPuMZfsEpwMJV6NjA6ct4HRvoImPW/1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWX2URUBomBs49q59c3p9c5tC15i7TZmJwMaHszJ/s2zPpmUgvFPuB9mj89O8KGK8
	 Ev91e2Q8jYLhl6wT8VPbfImUw2/Gxwv2UnBpxUtae0hzXoYT54mc/vem4V0wwpcv7b
	 YWKpmd/6kVdpb0nbFGzCXUNKa+5C5yT00euk0d9g=
Date: Tue, 21 May 2024 11:35:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 02/11] rust: add driver abstraction
Message-ID: <2024052155-pulverize-feeble-49bb@gregkh>
References: <20240520172554.182094-1-dakr@redhat.com>
 <20240520172554.182094-3-dakr@redhat.com>
 <2024052045-lived-retiree-d8b9@gregkh>
 <ZkvPDbAQLo2/7acY@pollux.localdomain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkvPDbAQLo2/7acY@pollux.localdomain>

On Tue, May 21, 2024 at 12:30:37AM +0200, Danilo Krummrich wrote:
> On Mon, May 20, 2024 at 08:14:18PM +0200, Greg KH wrote:
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
> 
> DriverOps is a trait which abstracts a subsystems register() and unregister()
> functions to (un)register drivers. It exists such that a generic Registration
> implementation calls the correct one for the subsystem.
> 
> For instance, PCI would implement DriverOps::register() by calling into
> bindings::__pci_register_driver().
> 
> We can discuss whether DriverOps is a good name for the trait, but it's not a
> (different) name for something that already exists and already has a name.

It's a name we don't have in the C code as the design of the driver core
does not need or provide it.  It's just the section of 'struct
device_driver' that provides function callbacks, why does it need to be
separate at all?

> > 'Registration'?  That's a bus/class thing, not a driver thing.
> 
> A Registration is an object representation of the driver's registered state.

And that representation should not ever need to be tracked by the
driver, that's up to the driver core to track that.

> Having an object representation for that is basically the Rust way to manage the
> lifetime of this state.

This all should be a static chunk of read-only memory that should never
have a lifetime, why does it need to be managed at all?

> Once the Registration is dropped, the driver is
> unregistered. For instance, a PCI driver Registration can be bound to a module,
> such that the PCI driver is unregistered when the module is unloaded (the
> Registration is dropped in the module_exit() callback).

Ok, that's fine, but note that your module_exit() function will never be
called if your module_init() callback fails, so why do you need to track
this state?  Again, C drivers never need to track this state, why is
rust requiring more logic here for something that is NOT a dynamic chunk
of memory (or should not be a dynamic chunk of memory, let's get it
correct from the start and not require us to change things later on to
make it more secure).

> > And be very careful of the use of the word 'class' here, remember, there
> > is 'struct class' as part of the driver model :)
> 
> I think in this context "class" might be meant as something like "struct with
> methods", not sure what would be the best term to describe this.

"struct with methods" is nice :)

Again, 'class' means something different here in the driver model, so be
careful with terms, language matters, especially when many of our
developers do not have English as their native language.

> > > +/// The registration of a driver.
> > > +pub struct Registration<T: DriverOps> {
> > > +    is_registered: bool,
> > 
> > Why does a driver need to know if it is registered or not?  Only the
> > driver core cares about that, please do not expose that, it's racy and
> > should not be relied on.
> 
> We need it to ensure we do not try to register the same thing twice

Your logic in your code is wrong if you attempt to register it twice,
AND the driver core will return an error if you do so, so a driver
should not need to care about this.

> , some subsystems might just catch fire otherwise.

Which ones?

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
> No, we want to automatically unregister once this object is destroyed, but not
> if it was never registered in the first place.
> 
> This shouldn't be racy, we only ever (un)register things in places like probe()
> / remove() or module_init() / module_exit().

probe/remove never calls driver_register/unregister on itself, so that's
not an issue.  module_init/exit() does not race with itself and again,
module_exit() is not called if module_init() fails.

Again, you are adding logic here that is not needed.  Or if it really is
needed, please explain why the C code does not need this today and let's
work to fix that.

> > > +        }
> > > +    }
> > > +}
> > > +
> > > +/// Conversion from a device id to a raw device id.
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
> This is just a generalized interface which can be used by subsystems to
> implement the subsystem / bus specific ID type.

Please move this all to a different file as it has nothing to do with
the driver core bindings with the include/device/driver.h api.

Let's keep it simple and obvious please, and separate out things into
logical chunks, hopefully in the same way that the C apis are separated
out into.  That way we can properly review, understand, and most
importantly for all of us, maintain the code over the next 40+ years.

thanks,

greg k-h

