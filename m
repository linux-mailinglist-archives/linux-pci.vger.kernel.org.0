Return-Path: <linux-pci+bounces-9988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC8792B4F2
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 12:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B161C208A5
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 10:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA79914EC61;
	Tue,  9 Jul 2024 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RA66jmkW"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A9C12C7F9
	for <linux-pci@vger.kernel.org>; Tue,  9 Jul 2024 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520141; cv=none; b=KvmipF3g6WqIDllTMlLKvusn9nEwEAGuEZ9GCtgN1ehIty7YfZxer+UdHMiDsWop6FzOPWlpNOweS9cC+3OuQDblBW7TKR6cppbVd9pDoy8pDUfvsBQjib+SNy3lHwbJyv4Z5QjAoKKTb5TaMJ3rsztsKmAxod+qEon+6qjmFG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520141; c=relaxed/simple;
	bh=W6+npMvjOev0trZ/YakeBsyrVuLcjlbQuplVB6oJDLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PR3nkcFhELXULCAVxT1b+AzFCmH8FV+R2RDkFcTnQhPXivcxefwuybXuEqxZ4aZ6flVj6qcHNeTL9W7IPeloAVX989We3eLTeWUFyXmKlE+6OqMMQnwnhmjjkC8ClQR0yDzI/UpYx649xARxAYsG7GLT+vaOuz6w7Di1RJ9Viuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RA66jmkW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720520138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0LI2aiTo8SDPbgwOywHY37YXWVm6ke5JwTsOKYTO7s=;
	b=RA66jmkW/evKQw9tcCLSkozGpww+dSfPYSwkSBh/2ypTDl0i7md/fURuWtL05HuuVhBJJD
	K+3zLph5y4KJfjQspLHSdkHiuGGjI2HpSOVkyjyyQwr0ZRdlbTF7IUS/CkzctKSCuyVrrk
	PlXPRlqu3V8uTLSAfGbWqqY6sVPaECo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-RbVKN8cqOreKpZeN-9OL7A-1; Tue, 09 Jul 2024 06:15:36 -0400
X-MC-Unique: RbVKN8cqOreKpZeN-9OL7A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-426703ac975so4356165e9.0
        for <linux-pci@vger.kernel.org>; Tue, 09 Jul 2024 03:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720520135; x=1721124935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0LI2aiTo8SDPbgwOywHY37YXWVm6ke5JwTsOKYTO7s=;
        b=iwsUw5wiXA5EqufdIe8PQ3FqBIrihWUhxEu7q+FdHD2JMCgz0ObvJwv0OQyNDuvpbY
         9U/NMH3mBNQuAzlQAljHU+7EKRiUiHqbNfJrkO4ErJ2xlxvQrBIdJpL6w5gwic8/PLnm
         SRjJCQY0PhAjLis9xiimNgLsEslBLQnlye3JP4/hnzkMwXEkBi4K/DGaTid7tBJszZO9
         MYz2QLU2npXe5vD6jYha9N53UMf601aiOGwwBa/LPxsgn5pl4oMY6dvnOuRuyMSNhTN0
         ZpPIehe4wkT+mpF01NQr+vCdv2V0t9JWOEWm4BOnApQHdX23H7WZKO/CeNhz06dU8loM
         YUuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOasFZz0JHMccgtYq1TUsAOl3xqW1/v1mPZ4YTo/7MLurMRvf95Xb0xzQDR1rimyD/mTqJHlAptYVGZxgcSNCD3yMiK6iCmnr7
X-Gm-Message-State: AOJu0YwhNFcczNmnMPbNUetmRvMp4JDd3/qxCQR5ToV9gyEavUcPE2sI
	DIFApcJeM7t6GDkkiMybS1x59D7yE/aMih6/t6PeWoon0u7gREZpA5lVigUG9I7Feqji+1eYjJO
	UTUu3UAKHTvLOyPxx8XtZ7hVGKc+MthJ3fxjAzWv8KJpmTZEpmnEpFhpLVA==
X-Received: by 2002:a05:600c:12c5:b0:424:7871:2e9e with SMTP id 5b1f17b1804b1-426722d4ac2mr13267695e9.6.1720520135515;
        Tue, 09 Jul 2024 03:15:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ5U/jFQWevQZpnHxNvHI789HGlPw9htIpqg38lT8vTSEmBTaidxwWELmF+uEaYUa8NvwnQQ==
X-Received: by 2002:a05:600c:12c5:b0:424:7871:2e9e with SMTP id 5b1f17b1804b1-426722d4ac2mr13267285e9.6.1720520135058;
        Tue, 09 Jul 2024 03:15:35 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f7420cesm33763395e9.46.2024.07.09.03.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 03:15:34 -0700 (PDT)
Date: Tue, 9 Jul 2024 12:15:32 +0200
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
Subject: Re: [PATCH v2 01/10] rust: pass module name to `Module::init`
Message-ID: <Zo0NxOJUEO-gvxVr@pollux>
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

Just another kind reminder on this one. :)

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
> 
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
> 
> > 
> > > Consequently, we have to pass things through. This also isn't new, please note
> > > that the current code already does the same thing: `Module::init` (without this
> > > patch) is already declared as
> > > 
> > > `fn init(module: &'static ThisModule) -> error::Result<Self>`
> > > passing through `ThisModule` for the exact same reason.
> > 
> > Yeah, and I never quite understood that either :)
> 
> Since commit 247b365dc8dc ("rust: add `kernel` crate") shows me your RB for
> that, am I good to assume that this one isn't a blocker?
> 
> > 
> > > Please also note that in the most common case (one driver per module) we don't
> > > see any of this anyway.
> > 
> > True, but someone has to review and most importantly, maintain, this
> > glue code.
> > 
> > > Just like the C macro module_pci_driver(), Rust drivers can use the
> > > `module_pci_driver!` macro.
> > > 
> > > Example from Nova:
> > > 
> > > ```
> > >     kernel::module_pci_driver! {
> > >         // The driver type that implements the corresponding probe() and
> > >         // remove() driver callbacks.
> > >         type: NovaDriver,
> > >         name: "Nova",
> > >         author: "Danilo Krummrich",
> > >         description: "Nova GPU driver",
> > >         license: "GPL v2",
> > >     }
> > > ```
> > 
> > As I said when you implemented this fun macro, don't do this yet.
> > 
> > We added these "helper" macros WAY late in the development cycle of the
> > driver model, AFTER we were sure we got other parts right.  There is no
> > need to attempt to implement all of what you can do in C today in Rust,
> > in fact, I would argue that we don't want to do that, just to make
> > things simpler to review the glue code, which is the most important part
> > here to get right!
> 
> We're not reinventing the wheel here, we stick to the architecture the kernel
> already has.
> 
> However, I understand that not starting with this macro directly makes it easier
> for you to see what's going on. I can introduce the macro in a separate patch to
> make it more obvious what's going on.
> 
> > 
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
> 
> However, it would indeed safe me time and energy to do just that. But that isn't
> really what I want. I also don't want to write a driver in Rust *only*.
> 
> And I also don't really think that you want people, who commit to work hard to
> get things right, to just take the shortcut and create some random mess buried
> in a driver. :)
> 
> What I actually want is to get to a solid foundation for Rust drivers in
> general, since I'm convinced that this provides a lot of value beyond the scope
> of a single driver.
> 
> Since you've brought the topic up a few times, I am also willing to maintain
> those abstractions if this is a concern. Maybe one day the corresponding
> maintainers are comfortable enough and this isn't needed anymore, but at least
> until then, I'm happy to help out.
> 
> > 
> > After all, it's not the pci driver model code that is usually the tricky
> > bits to verify in C, it's the whole rest of the mess.  Stick with a
> > small C file, with just the pci driver structure and device ids, and
> > then instantiate your rust stuff when probe() is called, and clean up
> > when release() is called.
> 
> Again, this really bubbles up.
> 
> What do we pass to Rust probe() function? A raw struct pci_dev pointer or the
> proper PCI device abstraction?
> 
> How do we implement I/O memory mappings for PCI bars without PCI / I/O
> abstraction?
> 
> How do we perform (boundary checked) I/O memory reads / writes without `Io`
> abstraction?
> 
> How do we handle the lifetime of resources without `Devres` abstraction?
> 
> How do we (properly) implement a DRM device registration abstraction without
> `Devres`?
> 
> Luckily we already got the `Firmware` and `Device` abstraction in place. :)
> 
> > 
> > I can provide an example if needed.
> 
> If you do so, please don't stop at the probe() boundary, please continue to the
> point where the Nova stub driver is. It really does just enough to show / proove
> that the abstractions tie together nicely. But it should be enough to see that
> you end up with either (1), (2) or (3) from above.
> 
> > 
> > thanks,
> > 
> > greg k-h
> > 


