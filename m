Return-Path: <linux-pci+bounces-10080-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9B192D3BA
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 16:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D29287668
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 14:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6D919412D;
	Wed, 10 Jul 2024 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tSmIFejt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473C8194120;
	Wed, 10 Jul 2024 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620128; cv=none; b=hmNyqM+DqmyI9X6E4hUpK+VNKZM7uLnMcHo49AXvaxf6ryeMrWNmIVHXGVpBjnctjojwqtMve2rki3pkqCjsFKAL9QhxlfOoqnF0ovwj3B4S2ypCCid76wdu3w8TeSRpzH4rPiD+tFhNzzbZ7z1pdZZPEeE4eoiI6U2ts8/cJQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620128; c=relaxed/simple;
	bh=Vk9b2kG3gcfI2no+6grdIB3azydt/9VYwwKWqhPtfGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unpKF8bXwCknLvCwQu0nkOpKa0ZBxEH12ffxLFSm/rqIvjLWye351JTbo4/3IcDwRvmZN2IgP2HfNxCw2QN0fNCdnW4eaBZ8LkHch23ktFbPX7oEOo4i2mYg/fcEiOyTlTJU68kKmUYQQIKfTMoX78y6KtUBiabNXi9qbPcbk6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tSmIFejt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6DBC32786;
	Wed, 10 Jul 2024 14:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720620127;
	bh=Vk9b2kG3gcfI2no+6grdIB3azydt/9VYwwKWqhPtfGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tSmIFejtjeH7oRSYasreIrxIjw2X/f/EHS/XZJXRDf5pUqsHthV11iFlFF1M1LOOV
	 BZT31Oj+VKGAFqv5C9cXpv0fcwPTegjQzOiXP7zVfkF6S7ch12o4IKrNxU5aVGEw+C
	 yLF+OPKy+BXJz9YnRfU/NbZZdxfON8BFWLfwyssQ=
Date: Wed, 10 Jul 2024 16:02:04 +0200
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
Subject: Re: [PATCH v2 01/10] rust: pass module name to `Module::init`
Message-ID: <2024071046-gaining-gave-b38f@gregkh>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240618234025.15036-2-dakr@redhat.com>
 <2024062038-backroom-crunchy-d4c9@gregkh>
 <ZnRUXdMaFJydAn__@cassiopeiae>
 <2024062010-change-clubhouse-b16c@gregkh>
 <ZnSeAZu3IMA4fR8P@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnSeAZu3IMA4fR8P@cassiopeiae>

On Thu, Jun 20, 2024 at 11:24:17PM +0200, Danilo Krummrich wrote:
> On Thu, Jun 20, 2024 at 06:36:08PM +0200, Greg KH wrote:
> > On Thu, Jun 20, 2024 at 06:10:05PM +0200, Danilo Krummrich wrote:
> > > On Thu, Jun 20, 2024 at 04:19:48PM +0200, Greg KH wrote:
> > > > On Wed, Jun 19, 2024 at 01:39:47AM +0200, Danilo Krummrich wrote:
> > > > > In a subsequent patch we introduce the `Registration` abstraction used
> > > > > to register driver structures. Some subsystems require the module name on
> > > > > driver registration (e.g. PCI in __pci_register_driver()), hence pass
> > > > > the module name to `Module::init`.
> > > > 
> > > > I understand the need/want here, but it feels odd that you have to
> > > > change anything to do it.
> > > > 
> > > > > 
> > > > > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > > > > ---
> > > > >  rust/kernel/lib.rs           | 14 ++++++++++----
> > > > >  rust/kernel/net/phy.rs       |  2 +-
> > > > >  rust/macros/module.rs        |  3 ++-
> > > > >  samples/rust/rust_minimal.rs |  2 +-
> > > > >  samples/rust/rust_print.rs   |  2 +-
> > > > >  5 files changed, 15 insertions(+), 8 deletions(-)
> > > > > 
> > > > > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > > > > index a791702b4fee..5af00e072a58 100644
> > > > > --- a/rust/kernel/lib.rs
> > > > > +++ b/rust/kernel/lib.rs
> > > > > @@ -71,7 +71,7 @@ pub trait Module: Sized + Sync + Send {
> > > > >      /// should do.
> > > > >      ///
> > > > >      /// Equivalent to the `module_init` macro in the C API.
> > > > > -    fn init(module: &'static ThisModule) -> error::Result<Self>;
> > > > > +    fn init(name: &'static str::CStr, module: &'static ThisModule) -> error::Result<Self>;
> > > > 
> > > > Why can't the name come directly from the build system?  Why must it be
> > > > passed into the init function of the module "class"?  What is it going
> > > > to do with it?
> > > 
> > > The name does come from the build system, that's where `Module::init` gets it
> > > from.
> > > 
> > > > 
> > > > A PCI, or other bus, driver "knows" it's name already by virtue of the
> > > > build system, so it can pass that string into whatever function needs
> > > 
> > > Let's take pci_register_driver() as example.
> > > 
> > > ```
> > > #define pci_register_driver(driver)		\
> > > 	__pci_register_driver(driver, THIS_MODULE, KBUILD_MODNAME)
> > > ```
> > > 
> > > In C drivers this works because (1) it's a macro and (2) it's called directly
> > > from the driver code.
> > > 
> > > In Rust, for very good reasons, we have abstractions for C APIs, hence the
> > > actual call to __pci_register_driver() does not come from code within the
> > > module, but from the PCI Rust abstraction `Module::init` calls into instead.
> > 
> > I don't understand those reasons, sorry.
> 
> Ok, good you point this out. We should definitely discuss this point then and
> build some consensus around it.
> 
> I propose to focus on this point first and follow up with the discussion of the
> rest of the series afterwards.
> 
> Let me explain why I am convinced that it's very important to have abstractions
> in place in general and from the get-go.
> 
> In general, having abstractions for C APIs is the foundation of being able to
> make use of a lot of advantages Rust has to offer.
> 
> The most obvious one are all the safety aspects. For instance, with an
> abstraction we have to get exactly one piece of code right in terms of pointer
> validity, lifetimes, type safety, API semantics, etc. and in all other places
> (e.g. drivers) we get the compiler to check those things for us through the
> abstraction.
> 
> Now, the abstraction can be buggy or insufficient and hence there is no absolute
> safety guarantee. *But*, if we get this one thing right, there is nothing a
> driver can mess up by itself trying to do stupid things anymore.
> 
> If we just call the C code instead we have to get it right everywhere instead.

I too want a pony.  But unfortunatly you are shaving a yak here instead :)

I'm not saying to call C code from rust, I'm saying call rust code from
C.

Have a "normal" pci_driver structure with C functions that THEN call
into the rust code that you want to implement them, with a pointer to
the proper structure.  That gives you everything that you really want
here, EXCEPT you don't have to build the whole tower of drivers and
busses and the like.

> Now, you could approach this top-down instead and argue that we could at least
> benefit from Rust for the driver specific parts.
> 
> Unfortunately, this doesn't really work out either. Also driver specific code is
> typically (very) closely connected to kernel APIs. If you want to use the safety
> aspects of Rust for the driver specific parts you inevitably end up writing
> abstractions for the C APIs in your driver.
> 
> There are basically three options you can end up with:
> 
> (1) An abstraction for the C API within your driver that is actually generic
>     for every driver, and hence shouldn't be there.
> (2) Your driver specific code is full of raw pointers and `unsafe {}` calls,
>     which in the end just means that you ended up baking the abstraction into
>     your driver specific code.
> (3) You ignore everything, put everything in a huge `unsafe {}` block and
>     compile C code with the Rust compiler. (Admittedly, maybe slightly
>     overstated, but not that far off either.)
> 
> The latter is also the reason why it doesn't make sense to only have
> abstractions for some things, but not for other.
> 
> If an abstraction for B is based on A, but we don't start with A, then B ends up
> implementing (at least partially) the abstraction for A as well. For instance,
> if we don't implement `driver::Registration` then the PCI abstractions (and
> platform, usb, etc.) have to implement it.
> 
> It really comes down to the point that it just bubbles up. We really have to do
> this bottom-up, otherwise we just end up moving those abstractions up, layer by
> layer, where they don't belong to and we re-implement them over and over again.

I think we are talking past each other.

Here is an example .c file that you can use today for your "implement a
PCI driver in rust" wish in a mere 34 lines of .c code:

------------------------------------------------------------------------
// SPDX-License-Identifier: GPL-2.0-only
#include <linux/module.h>
#include <linux/pci.h>
#include "my_pci_rust_bindings.h"

#define PCI_DEVICE_ID_FOO		0x0f00
#define PCI_VENDOR_ID_FOO		0x0f00

static int probe(struct pci_dev *pdev, const struct pci_device_id *ent)
{
	return my_rust_probe(pdev);
}

static void remove(struct pci_dev *pdev)
{
	my_rust_remove(pdev);
}

static const struct pci_device_id pci_ids[] = {
	{PCI_DEVICE(PCI_VENDOR_ID_FOO, PCI_DEVICE_ID_FOO)},
	{}
};
MODULE_DEVICE_TABLE(pci, pci_ids);

static struct pci_driver my_rust_pci_driver = {
	.name = "my_pci_rust_driver",
	.id_table = pci_ids,
	.probe = probe,
	.remove = remove,
};
module_pci_driver(my_rust_pci_driver);

MODULE_DESCRIPTION("Driver for my fancy PCI device");
MODULE_LICENSE("GPL v2");
------------------------------------------------------------------------

Now, all you have to do is provide a my_rust_probe() and
my_rust_remove() call in your rust code, and handle the conversion of a
struct pci_dev to whatever you want to use (which you had to do anyway),
and you are set!

That .c code above is "obviously" correct, and much simpler and worlds
easier for all of us to understand instead of the huge .rs files that
this patch series was attempting to implement.

You have to draw the c/rust line somewhere, you all seem to be wanting
to draw that line at "no .c in my module at all!" and I'm saying "put 34
lines of .c in your module and you will save a LOT of headache now."

All of the "real" work you want to do for your driver is behind the
probe/remove callbacks (ok, add a suspend/resume as well, forgot that),
and stop worrying about all of the bindings and other mess to tie into
the driver model for a specific bus type and the lunacy that the device
id mess was.

In short, KEEP IT SIMPLE!

Then, after we are comfortable with stuff like the above, slowly think
about moving the line back a bit more, if you really even need to.  But
why would you need to?  Only reason I can think of is if you wanted to
write an entire bus in rust, and for right now, I would strongly suggest
anyone not attempt that.

The "joy" of writing a driver in rust is that a driver consumes from
EVERYWHERE in the kernel (as you well know.)  Having to write bindings
and mappings for EVERYTHING all at once, when all you really want to do
is implement the logic between probe/remove is rough, I'm sorry.  I'm
suggesting that you stop at the above line for now, which should make
your life easier as the .c code is obviously correct, and anything you
do in the rust side is your problem, not mine as a bus maintainer :)

> > Changing drivers later, to take advantage of code savings like this
> > macro can be done then, not just yet.  Let's get this understood and
> > right first, no need to be tricky or complex.
> > 
> > And, as I hinted at before, I don't think we should be doing this at all
> > just yet either.  I still think a small "C shim" layer to wrap the
> > struct pci driver up and pass the calls to the rust portion of the
> > module is better to start with, it both saves you time and energy so
> > that you can work on what you really want to do (i.e. a driver in rust)
> > and not have to worry about the c bindings as that's the "tricky" part
> > that is stopping you from getting your driver work done.
> 
> I strongly disagree here. As explained above, it just bubbles up, this approach
> would just make me end up having to write a lot of the code from the
> abstractions in the driver.

See above, you cut out all of the .rs files you submitted in this series
and can probably just add one to map a pci_device and away you go.

> What I actually want is to get to a solid foundation for Rust drivers in
> general, since I'm convinced that this provides a lot of value beyond the scope
> of a single driver.

I don't see what not needing the above 35+ lines of .c code provides a
value for at all, EXCEPT we now need to maintain a lot more code
overall.

> What do we pass to Rust probe() function? A raw struct pci_dev pointer or the
> proper PCI device abstraction?

See above.

> How do we implement I/O memory mappings for PCI bars without PCI / I/O
> abstraction?

Call the .c functions you have today.

> How do we perform (boundary checked) I/O memory reads / writes without `Io`
> abstraction?

Do you really need/want that?  If so, ok, but I think you are going to
run into big issues with dynamic ranges that I didn't see answered on
those patches, but I could be totally wrong.

Again, one step at a time please, not the whole yak.

> How do we handle the lifetime of resources without `Devres` abstraction?

We have this question on the .c side as well.  Please work with the
people who are working to solve that there as it hits everyone.

> How do we (properly) implement a DRM device registration abstraction without
> `Devres`?

No idea, drm is huge :)

That being said, I think you can implement it above as the lifetime of
your device lives between probe and remove.  After remove is gone, all
of your resources HAVE to be freed, so do that in your driver.

> Luckily we already got the `Firmware` and `Device` abstraction in place. :)

Baby steps :)

thanks,

greg k-h

