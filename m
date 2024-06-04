Return-Path: <linux-pci+bounces-8244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8268A8FB79D
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 17:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7564B1C218FE
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 15:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5C5145B15;
	Tue,  4 Jun 2024 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LU7O375J"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1E3143C7B
	for <linux-pci@vger.kernel.org>; Tue,  4 Jun 2024 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515692; cv=none; b=L/Ezq/BU4jVDd1+0HtyCXedNSpnCQOhHWJt80ZELBCNQkw5pJNbdC+UsWs/hUQrnMj7jWvl1eL0FYSXPe38k7ew3BwyJ1zxkuJqCrOSH6tIyQyb4oWWTksJx3xjJpqpQy+95Oh+qzgfXaQE3xmDCA8IlgL0Zf9ldaV413BxLTOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515692; c=relaxed/simple;
	bh=XxSUaDcVciyhPOXdjvOw1YcAxIcm7l6PsBDBbcU5kFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9D+8QmaI4dMHHEAO5ThvKeJRIMsgFqjaYO03qhl0goq2WxSBCqOiDgh5xwtpKxptr6olTLcJHHN9OLrLYrSwXjr2uAobQT3MCG1e6+EWZJIoJ5laTae597sO/meOkI03G4JtoM3v16/Qi/2PfwWEpyZYbOHRMVnArG6+9L7UNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LU7O375J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717515688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Km5F10mW+lSOaW0ZqHxygOfF3jSHDpEX8SFgVZH0Uu8=;
	b=LU7O375JiolMZ4rWOSlIQhZcUEXniTS6Gv0/AX+cYAd2WzFhTp47m0odYIITkrw4qdZaGh
	A+PEVd6yue2Rivc9qIttOgmWKe3unTVgzhhE0PhZblBeE1/RD8+P7zS0GWRmG+ruWD9tnc
	TC84Un1ayTxdLNbWJ+VeMgkkT1mpxtY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-G7JR-RtTOdK-DXYHemwmdQ-1; Tue, 04 Jun 2024 11:41:26 -0400
X-MC-Unique: G7JR-RtTOdK-DXYHemwmdQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4212bf90891so8830645e9.1
        for <linux-pci@vger.kernel.org>; Tue, 04 Jun 2024 08:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717515685; x=1718120485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Km5F10mW+lSOaW0ZqHxygOfF3jSHDpEX8SFgVZH0Uu8=;
        b=nAr4Qgo7IgGwVQCBfEJCiWYe9vZdQBd5OOnV+Sxgsy2SDSkxtuIZuZqG7Y0HAwJGOi
         MO4MBB/JGOFcdcYv9Yy5q5w+9GsmKEF7nK7d5/36eJRvmmkUnX9g3WxYyc5TUQ+YOCkj
         XALWKFnIS7aJQ9fsQNMKXWbjmJTh8IiZjwaZqXT78YFP42UigYzWvWTTgsmf5OsKCHe/
         A0iP55DuJVoRVjHWTLH5SWaQhr+86IBv7zBY81o/eJSrAVcoxHFNeIy6rVzlAaUWjKyQ
         54dZWjThNXw35uRYKnr9Uxj5xZPx1f0g8Q8pFwqkqZ+TQqV5Yw3dEy1V0qTPngHx7bGN
         KJOg==
X-Forwarded-Encrypted: i=1; AJvYcCXXTnsDXN+gheDTsMD+qQCxscM2QY5SYiSZFYhSJP+Og/JVNS7k3DHCo50bJJyIpibdFbolLK3A0sU5rJU/9wsgRB1cARxSDs5X
X-Gm-Message-State: AOJu0YyGnTlADiUb+K8kHWaJ2nb05d0gv+lULmW5iF+bZEGd2O4ov3xz
	mG17GMz8zwFAnLoO9O6dosgGfZEnhSBG5+xy8qrFEKAhIpA6v6CumZl3AxVi+1HGY3NR4A+SHYM
	2ySZczi6p4hW4vud9GpC8gXwNmCrRkoOAc5Tkx4LVvyfJs4LKz7QKqSV5LQ==
X-Received: by 2002:a05:600c:4583:b0:416:2471:e102 with SMTP id 5b1f17b1804b1-4212e0ae621mr95526865e9.37.1717515684686;
        Tue, 04 Jun 2024 08:41:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQGMJTF33Hst794NpTk6SjJ9YG0K8w+ZjkAluCMrDS2lWSBCo6+x2DyKQRAkH4p8bEQxKh1A==
X-Received: by 2002:a05:600c:4583:b0:416:2471:e102 with SMTP id 5b1f17b1804b1-4212e0ae621mr95526525e9.37.1717515684138;
        Tue, 04 Jun 2024 08:41:24 -0700 (PDT)
Received: from cassiopeiae ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b8a758csm157966275e9.36.2024.06.04.08.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 08:41:23 -0700 (PDT)
Date: Tue, 4 Jun 2024 17:41:21 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 02/11] rust: add driver abstraction
Message-ID: <Zl81oUmNO5TX063x@cassiopeiae>
References: <20240520172554.182094-1-dakr@redhat.com>
 <20240520172554.182094-3-dakr@redhat.com>
 <2024052045-lived-retiree-d8b9@gregkh>
 <ZkvPDbAQLo2/7acY@pollux.localdomain>
 <2024052155-pulverize-feeble-49bb@gregkh>
 <Zk0egew_AxvNpUG-@pollux>
 <2024060432-chloride-grappling-cf95@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024060432-chloride-grappling-cf95@gregkh>

On Tue, Jun 04, 2024 at 04:27:31PM +0200, Greg KH wrote:
> On Wed, May 22, 2024 at 12:21:53AM +0200, Danilo Krummrich wrote:
> > On Tue, May 21, 2024 at 11:35:43AM +0200, Greg KH wrote:
> > > On Tue, May 21, 2024 at 12:30:37AM +0200, Danilo Krummrich wrote:
> > > > On Mon, May 20, 2024 at 08:14:18PM +0200, Greg KH wrote:
> > > > > On Mon, May 20, 2024 at 07:25:39PM +0200, Danilo Krummrich wrote:
> > > > > > From: Wedson Almeida Filho <wedsonaf@gmail.com>
> > > > > > 
> > > > > > This defines general functionality related to registering drivers with
> > > > > > their respective subsystems, and registering modules that implement
> > > > > > drivers.
> > > > > > 
> > > > > > Co-developed-by: Asahi Lina <lina@asahilina.net>
> > > > > > Signed-off-by: Asahi Lina <lina@asahilina.net>
> > > > > > Co-developed-by: Andreas Hindborg <a.hindborg@samsung.com>
> > > > > > Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> > > > > > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > > > > > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > > > > > ---
> > > > > >  rust/kernel/driver.rs        | 492 +++++++++++++++++++++++++++++++++++
> > > > > >  rust/kernel/lib.rs           |   4 +-
> > > > > >  rust/macros/module.rs        |   2 +-
> > > > > >  samples/rust/rust_minimal.rs |   2 +-
> > > > > >  samples/rust/rust_print.rs   |   2 +-
> > > > > >  5 files changed, 498 insertions(+), 4 deletions(-)
> > > > > >  create mode 100644 rust/kernel/driver.rs
> > > > > > 
> > > > > > diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> > > > > > new file mode 100644
> > > > > > index 000000000000..e0cfc36d47ff
> > > > > > --- /dev/null
> > > > > > +++ b/rust/kernel/driver.rs
> > > > > > @@ -0,0 +1,492 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > +
> > > > > > +//! Generic support for drivers of different buses (e.g., PCI, Platform, Amba, etc.).
> > > > > > +//!
> > > > > > +//! Each bus/subsystem is expected to implement [`DriverOps`], which allows drivers to register
> > > > > > +//! using the [`Registration`] class.
> > > > > 
> > > > > Why are you creating new "names" here?  "DriverOps" is part of a 'struct
> > > > > device_driver' why are you separating it out here?  And what is
> > > > 
> > > > DriverOps is a trait which abstracts a subsystems register() and unregister()
> > > > functions to (un)register drivers. It exists such that a generic Registration
> > > > implementation calls the correct one for the subsystem.
> > > > 
> > > > For instance, PCI would implement DriverOps::register() by calling into
> > > > bindings::__pci_register_driver().
> > > > 
> > > > We can discuss whether DriverOps is a good name for the trait, but it's not a
> > > > (different) name for something that already exists and already has a name.
> > > 
> > > It's a name we don't have in the C code as the design of the driver core
> > > does not need or provide it.  It's just the section of 'struct
> > > device_driver' that provides function callbacks, why does it need to be
> > > separate at all?
> > 
> > I'm confused by the relationship to `struct device_driver` you seem to imply.
> > How is it related?
> > 
> > Again, this is just a trait for subsystems to provide their corresponding
> > register and unregister implementation, e.g. pci_register_driver() and
> > pci_unregister_driver(), such that they can be called from the generic
> > Registration code below.
> > 
> > See [1] for an example implementation in PCI.
> 
> registering and unregistering drivers belongs in the bus code, NOT in
> the driver code.

Why? We're not (re-)implementing a bus here. Again, those are just abstractions
to call the C functions to register a driver. The corresponding C functions are
e.g. driver_register() or __pci_register_driver(). Those are defined in
drivers/base/driver.c and drivers/pci/pci-driver.c respectively.

Why wouldn't we follow the same scheme in Rust abstractions?

> 
> I think lots of the objections I had here will be fixed up when you move
> the bus logic out to it's own file, it does not belong here in a driver
> file (device ids, etc.)
> 
> > Please also consider that some structures might be a 1:1 representation of C
> > structures, some C structures are not required at the Rust side at all, and
> > then there might be additional structures and traits that abstract things C has
> > no data structure for.
> 
> That's fine, but let's keep the separate of what we have today at the
> very least and not try to lump it all into one file, that makes it
> harder to review and maintain over time.
> 
> > > > > 'Registration'?  That's a bus/class thing, not a driver thing.
> > > > 
> > > > A Registration is an object representation of the driver's registered state.
> > > 
> > > And that representation should not ever need to be tracked by the
> > > driver, that's up to the driver core to track that.
> > 
> > The driver doesn't need it, the Registration abstraction does need it. Please
> > see my comments below.
> 
> Great, put it elsewhere please, it does not belong in driver.rs.

This `Registration` structure is a generic abstraction to call some
$SUBSYSTEM_driver_register() function (e.g. pci_register_driver()). Why would it
belong somewhere else? Again, the corresponding C functions are in some driver.c
file as well.

> 
> > > > Having an object representation for that is basically the Rust way to manage the
> > > > lifetime of this state.
> > > 
> > > This all should be a static chunk of read-only memory that should never
> > > have a lifetime, why does it need to be managed at all?
> > 
> > What I meant here is that if a driver was registered, we need to make sure it's
> > going to be unregistered eventually, e.g. when the module is removed or when
> > something fails after registration and we need to unwind.
> > 
> > When the Registration structure goes out of scope, which would happen in both
> > the cases above, it will automatically unregister the driver, due to the
> > automatic call to `drop()`.
> 
> That's fine, but again, this all should just be static code, not
> dynamic.

I agree. As already mentioned in another thread, this will be static in v2.

I got the code for that in place already. :)

> 
> > > > Once the Registration is dropped, the driver is
> > > > unregistered. For instance, a PCI driver Registration can be bound to a module,
> > > > such that the PCI driver is unregistered when the module is unloaded (the
> > > > Registration is dropped in the module_exit() callback).
> > > 
> > > Ok, that's fine, but note that your module_exit() function will never be
> > > called if your module_init() callback fails, so why do you need to track
> > > this state?  Again, C drivers never need to track this state, why is
> > > rust requiring more logic here for something that is NOT a dynamic chunk
> > > of memory (or should not be a dynamic chunk of memory, let's get it
> > > correct from the start and not require us to change things later on to
> > > make it more secure).
> > 
> > That's fine, if module_init() would fail, the Registration would be dropped as
> > well.
> > 
> > As for why doesn't C need this is a good example of what I wrote above. Because
> > it is useful for Rust, but not for C.
> > 
> > In Rust we get drop() automatically called when a structure is destroyed. This
> > means that if we let drivers put the Registration structure (e.g. representing
> > that a PCI driver was registered) into its `Module` representation structure
> > (already upstream) then this Registration is automatically destroyed once the
> > module representation is destroyed (which happens on module_exit()). This leads
> > to `drop()` of the `Registration` structure being called, which unregisteres the
> > (e.g. PCI) driver.
> > 
> > This way the driver does not need to take care of unregistering the PCI driver
> > explicitly. The driver can also place multiple registrations into the `Module`
> > structure. All of them would be unregistered automatically in module_exit().
> 
> Ok, I think we are agreeing here, except that you do not need a "am I
> registered" flag, as the existance of the "object" defines if it is
> registered or not (i.e. if it exists and the "destructor" is called,
> it's been registered, otherwise it hasn't been and the check is
> pointless.)

The static implementation does not need this anymore, since there is no separate
register() function anymore that we need to protect.

> 
> > > Again, 'class' means something different here in the driver model, so be
> > > careful with terms, language matters, especially when many of our
> > > developers do not have English as their native language.
> > > 
> > > > > > +/// The registration of a driver.
> > > > > > +pub struct Registration<T: DriverOps> {
> > > > > > +    is_registered: bool,
> > > > > 
> > > > > Why does a driver need to know if it is registered or not?  Only the
> > > > > driver core cares about that, please do not expose that, it's racy and
> > > > > should not be relied on.
> > > > 
> > > > We need it to ensure we do not try to register the same thing twice
> > > 
> > > Your logic in your code is wrong if you attempt to register it twice,
> > > AND the driver core will return an error if you do so, so a driver
> > > should not need to care about this.
> > 
> > We want it to be safe, if the driver logic is wrong and registers it twice, we
> > don't want it to blow up.
> 
> How could that happen?
> 
> > The driver core takes care, but I think there are subsystems that do
> > initializations that could make things blow up when registering the driver
> > twice.
> 
> Nope, should not be needed, see above.  Rust should make this _easier_
> not harder, than C code here :)

Agree, and as mentioned above, with v2 Rust drivers can't register the same
thing twice anymore.

> 
> > > > , some subsystems might just catch fire otherwise.
> > > 
> > > Which ones?
> > 
> > Let's take the one we provide abstractons for, PCI.
> > 
> > In __pci_register_driver() we call spin_lock_init() and INIT_LIST_HEAD() before
> > driver_register() could bail out [1].
> > 
> > What if this driver is already registered and in use and we're randomly altering
> > the list pointers or call spin_lock_init() on a spin lock that's currently being
> > held?
> 
> I don't understand, why would you ever call "register driver" BEFORE the
> driver was properly set up to actually be registered?
> 
> PCI works properly here, you don't register unless everything is set up.
> Which is why it doesn't have a "hey, am I registered or not?" type flag,
> it's not needed.

That's not what I meant, but I think we can drop this specific part of the
discussion anyways, since with v2 we can't hit this anymore. :)

> 
> > > 
> > > > > > +        }
> > > > > > +    }
> > > > > > +}
> > > > > > +
> > > > > > +/// Conversion from a device id to a raw device id.
> > > > > > +///
> > > > > > +/// This is meant to be implemented by buses/subsystems so that they can use [`IdTable`] to
> > > > > > +/// guarantee (at compile-time) zero-termination of device id tables provided by drivers.
> > > > > > +///
> > > > > > +/// Originally, RawDeviceId was implemented as a const trait. However, this unstable feature is
> > > > > > +/// broken/gone in 1.73. To work around this, turn IdArray::new() into a macro such that it can use
> > > > > > +/// concrete types (which can still have const associated functions) instead of a trait.
> > > > > > +///
> > > > > > +/// # Safety
> > > > > > +///
> > > > > > +/// Implementers must ensure that:
> > > > > > +///   - [`RawDeviceId::ZERO`] is actually a zeroed-out version of the raw device id.
> > > > > > +///   - [`RawDeviceId::to_rawid`] stores `offset` in the context/data field of the raw device id so
> > > > > > +///     that buses can recover the pointer to the data.
> > > > > > +pub unsafe trait RawDeviceId {
> > > > > > +    /// The raw type that holds the device id.
> > > > > > +    ///
> > > > > > +    /// Id tables created from [`Self`] are going to hold this type in its zero-terminated array.
> > > > > > +    type RawType: Copy;
> > > > > > +
> > > > > > +    /// A zeroed-out representation of the raw device id.
> > > > > > +    ///
> > > > > > +    /// Id tables created from [`Self`] use [`Self::ZERO`] as the sentinel to indicate the end of
> > > > > > +    /// the table.
> > > > > > +    const ZERO: Self::RawType;
> > > > > 
> > > > > All busses have their own way of creating "ids" and that is limited to
> > > > > the bus code itself, why is any of this in the rust side?  What needs
> > > > > this?  A bus will create the id for the devices it manages, and can use
> > > > > it as part of the name it gives the device (but not required), so all of
> > > > > this belongs to the bus, NOT to a driver, or a device.
> > > > 
> > > > This is just a generalized interface which can be used by subsystems to
> > > > implement the subsystem / bus specific ID type.
> > > 
> > > Please move this all to a different file as it has nothing to do with
> > > the driver core bindings with the include/device/driver.h api.
> > 
> > I don't think driver.rs in an unreasonable place for a generic device ID
> > representation that is required by every driver structure.
> 
> It has nothing to do with drivers on their own, it's a bus attribute,
> please put that in bus.rs at the least.  Or it's own file if you need
> lots of code for simple arrays like this :)

It's not a lot of code actually, probably less than 100 lines, there is a lot of
documentation / examples though. :)

The corresponding C structure definitions are in
include/linux/mod_devicetable.h. Maybe we can move it to a separte device_id.rs
if you prefer that?

> 
> > But I'm also not overly resistant to move it out. What do you think would be a
> > good name?
> > 
> > Please consider that this name will also be the namespace for this trait.
> > Currently you can reference it with `kernel::driver::RawDeviceId`. If you move
> > it to foo.rs, it'd be `kernel::foo::RawDeviceId`.
> 
> I don't see why this isn't just unique to each bus type, it is not a
> driver attribute, but a bus-specific-driver type.  Please put it there
> and don't attempt to make it "generic".

If we don't make it generic we end up with a lot of duplicate code in every
subsystem that has some kind of device ID, e.g. OF, PCI, etc. Why would we want
to do that? I think moving the generic abstraction into a separate device_id.rs
seems to be the better option.

> 
> thanks,
> 
> greg k-h
> 


