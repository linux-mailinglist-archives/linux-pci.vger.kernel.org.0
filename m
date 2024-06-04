Return-Path: <linux-pci+bounces-8240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D662D8FB57B
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 16:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE642862D5
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 14:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842F8149C45;
	Tue,  4 Jun 2024 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LzrZWvlq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A96149C41;
	Tue,  4 Jun 2024 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717511585; cv=none; b=k2f8yokvKVwu2BMfcAlvSb0no0UiuKxV22XlQvWtUx1N79V9PRJv5aT21/YmCWhZODSM9t/bt3gg9e6FUlgyrN85/OYTlpR27422iTTNE8DPZmvSVImBg+xOAMBPJb7jT7LoPuyJJMmkK9zyMTj27uXT5jjpZQqPTbiW4dXLIug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717511585; c=relaxed/simple;
	bh=WGX0LQIKn31QilnSgdvEzuanRgd2jUzWguiy+MLJlIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvF54RzXjIhNBgtBOuhP8z7R1kVsQ4dZS8I5ci2LGVv1HIF+Ve2eJM+PxOGetp+cjH4aU6SFdgXTEHnixwjnAe/F0yWFHziE+L6gxxoU2ShziixRPcmcEe3VNvwat0bFlkGPpc1nCYS9SZoz31Ro2Twgnno+MfShhu4Y4s/nB1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LzrZWvlq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C233C4AF07;
	Tue,  4 Jun 2024 14:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717511584;
	bh=WGX0LQIKn31QilnSgdvEzuanRgd2jUzWguiy+MLJlIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LzrZWvlq8L8jwmqGds51i6DDRahz5Qvr2WtODwlXP+Mr0fk6rmP7uFYNHNhom311G
	 I2dfEkZM8XmgnTfYLaKYngLaG1eLY+W+1s77r8FmIqBwFC1iNaergB0r+8eqw688is
	 9dApN1U1US7NaDbFpGTSUDM0deJ7yNYfiTjO/xBI=
Date: Tue, 4 Jun 2024 16:27:31 +0200
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
Message-ID: <2024060432-chloride-grappling-cf95@gregkh>
References: <20240520172554.182094-1-dakr@redhat.com>
 <20240520172554.182094-3-dakr@redhat.com>
 <2024052045-lived-retiree-d8b9@gregkh>
 <ZkvPDbAQLo2/7acY@pollux.localdomain>
 <2024052155-pulverize-feeble-49bb@gregkh>
 <Zk0egew_AxvNpUG-@pollux>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk0egew_AxvNpUG-@pollux>

On Wed, May 22, 2024 at 12:21:53AM +0200, Danilo Krummrich wrote:
> On Tue, May 21, 2024 at 11:35:43AM +0200, Greg KH wrote:
> > On Tue, May 21, 2024 at 12:30:37AM +0200, Danilo Krummrich wrote:
> > > On Mon, May 20, 2024 at 08:14:18PM +0200, Greg KH wrote:
> > > > On Mon, May 20, 2024 at 07:25:39PM +0200, Danilo Krummrich wrote:
> > > > > From: Wedson Almeida Filho <wedsonaf@gmail.com>
> > > > > 
> > > > > This defines general functionality related to registering drivers with
> > > > > their respective subsystems, and registering modules that implement
> > > > > drivers.
> > > > > 
> > > > > Co-developed-by: Asahi Lina <lina@asahilina.net>
> > > > > Signed-off-by: Asahi Lina <lina@asahilina.net>
> > > > > Co-developed-by: Andreas Hindborg <a.hindborg@samsung.com>
> > > > > Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> > > > > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > > > > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > > > > ---
> > > > >  rust/kernel/driver.rs        | 492 +++++++++++++++++++++++++++++++++++
> > > > >  rust/kernel/lib.rs           |   4 +-
> > > > >  rust/macros/module.rs        |   2 +-
> > > > >  samples/rust/rust_minimal.rs |   2 +-
> > > > >  samples/rust/rust_print.rs   |   2 +-
> > > > >  5 files changed, 498 insertions(+), 4 deletions(-)
> > > > >  create mode 100644 rust/kernel/driver.rs
> > > > > 
> > > > > diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> > > > > new file mode 100644
> > > > > index 000000000000..e0cfc36d47ff
> > > > > --- /dev/null
> > > > > +++ b/rust/kernel/driver.rs
> > > > > @@ -0,0 +1,492 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +
> > > > > +//! Generic support for drivers of different buses (e.g., PCI, Platform, Amba, etc.).
> > > > > +//!
> > > > > +//! Each bus/subsystem is expected to implement [`DriverOps`], which allows drivers to register
> > > > > +//! using the [`Registration`] class.
> > > > 
> > > > Why are you creating new "names" here?  "DriverOps" is part of a 'struct
> > > > device_driver' why are you separating it out here?  And what is
> > > 
> > > DriverOps is a trait which abstracts a subsystems register() and unregister()
> > > functions to (un)register drivers. It exists such that a generic Registration
> > > implementation calls the correct one for the subsystem.
> > > 
> > > For instance, PCI would implement DriverOps::register() by calling into
> > > bindings::__pci_register_driver().
> > > 
> > > We can discuss whether DriverOps is a good name for the trait, but it's not a
> > > (different) name for something that already exists and already has a name.
> > 
> > It's a name we don't have in the C code as the design of the driver core
> > does not need or provide it.  It's just the section of 'struct
> > device_driver' that provides function callbacks, why does it need to be
> > separate at all?
> 
> I'm confused by the relationship to `struct device_driver` you seem to imply.
> How is it related?
> 
> Again, this is just a trait for subsystems to provide their corresponding
> register and unregister implementation, e.g. pci_register_driver() and
> pci_unregister_driver(), such that they can be called from the generic
> Registration code below.
> 
> See [1] for an example implementation in PCI.

registering and unregistering drivers belongs in the bus code, NOT in
the driver code.

I think lots of the objections I had here will be fixed up when you move
the bus logic out to it's own file, it does not belong here in a driver
file (device ids, etc.)

> Please also consider that some structures might be a 1:1 representation of C
> structures, some C structures are not required at the Rust side at all, and
> then there might be additional structures and traits that abstract things C has
> no data structure for.

That's fine, but let's keep the separate of what we have today at the
very least and not try to lump it all into one file, that makes it
harder to review and maintain over time.

> > > > 'Registration'?  That's a bus/class thing, not a driver thing.
> > > 
> > > A Registration is an object representation of the driver's registered state.
> > 
> > And that representation should not ever need to be tracked by the
> > driver, that's up to the driver core to track that.
> 
> The driver doesn't need it, the Registration abstraction does need it. Please
> see my comments below.

Great, put it elsewhere please, it does not belong in driver.rs.

> > > Having an object representation for that is basically the Rust way to manage the
> > > lifetime of this state.
> > 
> > This all should be a static chunk of read-only memory that should never
> > have a lifetime, why does it need to be managed at all?
> 
> What I meant here is that if a driver was registered, we need to make sure it's
> going to be unregistered eventually, e.g. when the module is removed or when
> something fails after registration and we need to unwind.
> 
> When the Registration structure goes out of scope, which would happen in both
> the cases above, it will automatically unregister the driver, due to the
> automatic call to `drop()`.

That's fine, but again, this all should just be static code, not
dynamic.

> > > Once the Registration is dropped, the driver is
> > > unregistered. For instance, a PCI driver Registration can be bound to a module,
> > > such that the PCI driver is unregistered when the module is unloaded (the
> > > Registration is dropped in the module_exit() callback).
> > 
> > Ok, that's fine, but note that your module_exit() function will never be
> > called if your module_init() callback fails, so why do you need to track
> > this state?  Again, C drivers never need to track this state, why is
> > rust requiring more logic here for something that is NOT a dynamic chunk
> > of memory (or should not be a dynamic chunk of memory, let's get it
> > correct from the start and not require us to change things later on to
> > make it more secure).
> 
> That's fine, if module_init() would fail, the Registration would be dropped as
> well.
> 
> As for why doesn't C need this is a good example of what I wrote above. Because
> it is useful for Rust, but not for C.
> 
> In Rust we get drop() automatically called when a structure is destroyed. This
> means that if we let drivers put the Registration structure (e.g. representing
> that a PCI driver was registered) into its `Module` representation structure
> (already upstream) then this Registration is automatically destroyed once the
> module representation is destroyed (which happens on module_exit()). This leads
> to `drop()` of the `Registration` structure being called, which unregisteres the
> (e.g. PCI) driver.
> 
> This way the driver does not need to take care of unregistering the PCI driver
> explicitly. The driver can also place multiple registrations into the `Module`
> structure. All of them would be unregistered automatically in module_exit().

Ok, I think we are agreeing here, except that you do not need a "am I
registered" flag, as the existance of the "object" defines if it is
registered or not (i.e. if it exists and the "destructor" is called,
it's been registered, otherwise it hasn't been and the check is
pointless.)

> > Again, 'class' means something different here in the driver model, so be
> > careful with terms, language matters, especially when many of our
> > developers do not have English as their native language.
> > 
> > > > > +/// The registration of a driver.
> > > > > +pub struct Registration<T: DriverOps> {
> > > > > +    is_registered: bool,
> > > > 
> > > > Why does a driver need to know if it is registered or not?  Only the
> > > > driver core cares about that, please do not expose that, it's racy and
> > > > should not be relied on.
> > > 
> > > We need it to ensure we do not try to register the same thing twice
> > 
> > Your logic in your code is wrong if you attempt to register it twice,
> > AND the driver core will return an error if you do so, so a driver
> > should not need to care about this.
> 
> We want it to be safe, if the driver logic is wrong and registers it twice, we
> don't want it to blow up.

How could that happen?

> The driver core takes care, but I think there are subsystems that do
> initializations that could make things blow up when registering the driver
> twice.

Nope, should not be needed, see above.  Rust should make this _easier_
not harder, than C code here :)

> > > , some subsystems might just catch fire otherwise.
> > 
> > Which ones?
> 
> Let's take the one we provide abstractons for, PCI.
> 
> In __pci_register_driver() we call spin_lock_init() and INIT_LIST_HEAD() before
> driver_register() could bail out [1].
> 
> What if this driver is already registered and in use and we're randomly altering
> the list pointers or call spin_lock_init() on a spin lock that's currently being
> held?

I don't understand, why would you ever call "register driver" BEFORE the
driver was properly set up to actually be registered?

PCI works properly here, you don't register unless everything is set up.
Which is why it doesn't have a "hey, am I registered or not?" type flag,
it's not needed.

> > 
> > > > > +        }
> > > > > +    }
> > > > > +}
> > > > > +
> > > > > +/// Conversion from a device id to a raw device id.
> > > > > +///
> > > > > +/// This is meant to be implemented by buses/subsystems so that they can use [`IdTable`] to
> > > > > +/// guarantee (at compile-time) zero-termination of device id tables provided by drivers.
> > > > > +///
> > > > > +/// Originally, RawDeviceId was implemented as a const trait. However, this unstable feature is
> > > > > +/// broken/gone in 1.73. To work around this, turn IdArray::new() into a macro such that it can use
> > > > > +/// concrete types (which can still have const associated functions) instead of a trait.
> > > > > +///
> > > > > +/// # Safety
> > > > > +///
> > > > > +/// Implementers must ensure that:
> > > > > +///   - [`RawDeviceId::ZERO`] is actually a zeroed-out version of the raw device id.
> > > > > +///   - [`RawDeviceId::to_rawid`] stores `offset` in the context/data field of the raw device id so
> > > > > +///     that buses can recover the pointer to the data.
> > > > > +pub unsafe trait RawDeviceId {
> > > > > +    /// The raw type that holds the device id.
> > > > > +    ///
> > > > > +    /// Id tables created from [`Self`] are going to hold this type in its zero-terminated array.
> > > > > +    type RawType: Copy;
> > > > > +
> > > > > +    /// A zeroed-out representation of the raw device id.
> > > > > +    ///
> > > > > +    /// Id tables created from [`Self`] use [`Self::ZERO`] as the sentinel to indicate the end of
> > > > > +    /// the table.
> > > > > +    const ZERO: Self::RawType;
> > > > 
> > > > All busses have their own way of creating "ids" and that is limited to
> > > > the bus code itself, why is any of this in the rust side?  What needs
> > > > this?  A bus will create the id for the devices it manages, and can use
> > > > it as part of the name it gives the device (but not required), so all of
> > > > this belongs to the bus, NOT to a driver, or a device.
> > > 
> > > This is just a generalized interface which can be used by subsystems to
> > > implement the subsystem / bus specific ID type.
> > 
> > Please move this all to a different file as it has nothing to do with
> > the driver core bindings with the include/device/driver.h api.
> 
> I don't think driver.rs in an unreasonable place for a generic device ID
> representation that is required by every driver structure.

It has nothing to do with drivers on their own, it's a bus attribute,
please put that in bus.rs at the least.  Or it's own file if you need
lots of code for simple arrays like this :)

> But I'm also not overly resistant to move it out. What do you think would be a
> good name?
> 
> Please consider that this name will also be the namespace for this trait.
> Currently you can reference it with `kernel::driver::RawDeviceId`. If you move
> it to foo.rs, it'd be `kernel::foo::RawDeviceId`.

I don't see why this isn't just unique to each bus type, it is not a
driver attribute, but a bus-specific-driver type.  Please put it there
and don't attempt to make it "generic".

thanks,

greg k-h

