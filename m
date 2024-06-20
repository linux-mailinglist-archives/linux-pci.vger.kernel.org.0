Return-Path: <linux-pci+bounces-9030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E832910D2F
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 18:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE53D1C2085A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 16:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35A21B1514;
	Thu, 20 Jun 2024 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Su1JKTTH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645431AD9D4;
	Thu, 20 Jun 2024 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901372; cv=none; b=DbKt9m931mpErcg3YAY11Ro73bSPTKYaoYXdLbyiAP1D1tU+8Aq+530jKivjHg9/fiCxEFgzD1NibF/k9NcMPS4WbnHnG2y8KktCSIfpixW2HGBbBeNjuFGvKxBgR6VB8UJEi8OSpr17tEA/3NaTswCexlRTlH0EROSwzCC6Ypc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901372; c=relaxed/simple;
	bh=l1TvjLPrJTYofRPpCNcrodu+EIOZwX3eoQtBRAXBzr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnM8JQDfttUK9P2rI3MxEVuqiQXgo1HMrGMs5c6aKboCdmvrw1+yxT87v9yAXdfIu0MECVWcfbx7xotisawXBXWdOoMmyG0w28glf36sPYZ6FDcu1CPzDkPQys8t4Sd6cIwJhINZYSuKkpD9sYaYV4Wn0HAN2lG7CDEYWXywd7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Su1JKTTH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542A8C2BD10;
	Thu, 20 Jun 2024 16:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718901371;
	bh=l1TvjLPrJTYofRPpCNcrodu+EIOZwX3eoQtBRAXBzr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Su1JKTTHfki2+9lhXVN13HfNaqziBzw8iCUZZPhzC7CCNCpTe77hoZDb2jv43K9OQ
	 uDpBS6qabvcfqkJPF5mTcA0Fr8NAYE2GEbuN3qt7ripYPvcC991kbu/oOZLz5UePyw
	 krUEOXOd2dWc6Xlyzh939vw54hjkMks9vVXT/YJc=
Date: Thu, 20 Jun 2024 18:36:08 +0200
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
Message-ID: <2024062010-change-clubhouse-b16c@gregkh>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240618234025.15036-2-dakr@redhat.com>
 <2024062038-backroom-crunchy-d4c9@gregkh>
 <ZnRUXdMaFJydAn__@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnRUXdMaFJydAn__@cassiopeiae>

On Thu, Jun 20, 2024 at 06:10:05PM +0200, Danilo Krummrich wrote:
> On Thu, Jun 20, 2024 at 04:19:48PM +0200, Greg KH wrote:
> > On Wed, Jun 19, 2024 at 01:39:47AM +0200, Danilo Krummrich wrote:
> > > In a subsequent patch we introduce the `Registration` abstraction used
> > > to register driver structures. Some subsystems require the module name on
> > > driver registration (e.g. PCI in __pci_register_driver()), hence pass
> > > the module name to `Module::init`.
> > 
> > I understand the need/want here, but it feels odd that you have to
> > change anything to do it.
> > 
> > > 
> > > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > > ---
> > >  rust/kernel/lib.rs           | 14 ++++++++++----
> > >  rust/kernel/net/phy.rs       |  2 +-
> > >  rust/macros/module.rs        |  3 ++-
> > >  samples/rust/rust_minimal.rs |  2 +-
> > >  samples/rust/rust_print.rs   |  2 +-
> > >  5 files changed, 15 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > > index a791702b4fee..5af00e072a58 100644
> > > --- a/rust/kernel/lib.rs
> > > +++ b/rust/kernel/lib.rs
> > > @@ -71,7 +71,7 @@ pub trait Module: Sized + Sync + Send {
> > >      /// should do.
> > >      ///
> > >      /// Equivalent to the `module_init` macro in the C API.
> > > -    fn init(module: &'static ThisModule) -> error::Result<Self>;
> > > +    fn init(name: &'static str::CStr, module: &'static ThisModule) -> error::Result<Self>;
> > 
> > Why can't the name come directly from the build system?  Why must it be
> > passed into the init function of the module "class"?  What is it going
> > to do with it?
> 
> The name does come from the build system, that's where `Module::init` gets it
> from.
> 
> > 
> > A PCI, or other bus, driver "knows" it's name already by virtue of the
> > build system, so it can pass that string into whatever function needs
> 
> Let's take pci_register_driver() as example.
> 
> ```
> #define pci_register_driver(driver)		\
> 	__pci_register_driver(driver, THIS_MODULE, KBUILD_MODNAME)
> ```
> 
> In C drivers this works because (1) it's a macro and (2) it's called directly
> from the driver code.
> 
> In Rust, for very good reasons, we have abstractions for C APIs, hence the
> actual call to __pci_register_driver() does not come from code within the
> module, but from the PCI Rust abstraction `Module::init` calls into instead.

I don't understand those reasons, sorry.

> Consequently, we have to pass things through. This also isn't new, please note
> that the current code already does the same thing: `Module::init` (without this
> patch) is already declared as
> 
> `fn init(module: &'static ThisModule) -> error::Result<Self>`
> passing through `ThisModule` for the exact same reason.

Yeah, and I never quite understood that either :)

> Please also note that in the most common case (one driver per module) we don't
> see any of this anyway.

True, but someone has to review and most importantly, maintain, this
glue code.

> Just like the C macro module_pci_driver(), Rust drivers can use the
> `module_pci_driver!` macro.
> 
> Example from Nova:
> 
> ```
>     kernel::module_pci_driver! {
>         // The driver type that implements the corresponding probe() and
>         // remove() driver callbacks.
>         type: NovaDriver,
>         name: "Nova",
>         author: "Danilo Krummrich",
>         description: "Nova GPU driver",
>         license: "GPL v2",
>     }
> ```

As I said when you implemented this fun macro, don't do this yet.

We added these "helper" macros WAY late in the development cycle of the
driver model, AFTER we were sure we got other parts right.  There is no
need to attempt to implement all of what you can do in C today in Rust,
in fact, I would argue that we don't want to do that, just to make
things simpler to review the glue code, which is the most important part
here to get right!

Changing drivers later, to take advantage of code savings like this
macro can be done then, not just yet.  Let's get this understood and
right first, no need to be tricky or complex.

And, as I hinted at before, I don't think we should be doing this at all
just yet either.  I still think a small "C shim" layer to wrap the
struct pci driver up and pass the calls to the rust portion of the
module is better to start with, it both saves you time and energy so
that you can work on what you really want to do (i.e. a driver in rust)
and not have to worry about the c bindings as that's the "tricky" part
that is stopping you from getting your driver work done.

After all, it's not the pci driver model code that is usually the tricky
bits to verify in C, it's the whole rest of the mess.  Stick with a
small C file, with just the pci driver structure and device ids, and
then instantiate your rust stuff when probe() is called, and clean up
when release() is called.

I can provide an example if needed.

thanks,

greg k-h

