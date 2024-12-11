Return-Path: <linux-pci+bounces-18155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C19D59ED074
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 16:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CBC9188220A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 15:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97CF1D619D;
	Wed, 11 Dec 2024 15:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZFW0GL8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D2E24634E;
	Wed, 11 Dec 2024 15:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932403; cv=none; b=S7JilSw025y/UqiNjg02se65Qw6Pd2kAYcM9nGO17PZTg02jHrpylkSJ5ksDuTPFZSnpQBH4YZfm2YZ6xAxeRyAitmLroSlE+6LPCIfZ9uuv5MTt3IgnavnbglAqxi4cfwnRgrVYrbBv21zqm1qaoZPiP4RKIEWhXPGIqRHxRwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932403; c=relaxed/simple;
	bh=Xf9pkpj+OOoGDWyTa83q1js4ws59KtaknEJy5HUnyhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyrKdd1gW50TqWiQRHgslENEt02DeL0eDDlrzfwYv2+fTgTgiZytPoZcsU2gcEPZrYgqYADbK3qjimNaI4pI1/mloKZcMt8poUlV/OyKXeXPBhX1qop0LuDktaUOi9H7FgH8IQ6/3K9HhzB2KSdrh6ZADtEsyMRnfzORW/E8mDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZFW0GL8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D569C4CED2;
	Wed, 11 Dec 2024 15:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733932403;
	bh=Xf9pkpj+OOoGDWyTa83q1js4ws59KtaknEJy5HUnyhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XZFW0GL8G5zvIXKQT3lApChzuGj//5rn2C1mTsf2UtvH09UtHdhQDxYbWWWJZZJEU
	 p1r7QSjwpevPZ3VU2rhoCL7b04G+QkoZ8tKDyP8r7nkuRusoIpxTlANaanpDYrYyst
	 UND8aEHqiKWNlpSTMz1f03ShpwAXj4ex3OAfd3ciN0+7pxW+Fq5vcrNLdxY1NPykvi
	 VY2ukeWcvjkf2vs7xpoTfBEdPtlJLFgG6eBE8O/4HOErnOrexiOc9DYw7YnS3KVOfm
	 CHar9teWFRD5pOLhKbrfgJMLNkus9AaVIuzG6jpY2CgBJtXnXYzQ+uV8mmbOqek9sE
	 WIqeVMuZj/RCg==
Date: Wed, 11 Dec 2024 16:53:14 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
	bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, tmgross@umich.edu, a.hindborg@samsung.com,
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	robh@kernel.org, daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 01/16] rust: pass module name to `Module::init`
Message-ID: <Z1m1amdXlRvbB8rg@cassiopeiae>
References: <2024121109-ample-retrain-bde0@gregkh>
 <Z1mUG8ruFkPhVZwj@cassiopeiae>
 <CAH5fLgh3rwS1sFmrhx3zCaSBbAJfhJTV_kbyCVX6BhvnBZ+cQA@mail.gmail.com>
 <Z1mh2rPC3ZOjg-pO@cassiopeiae>
 <CAH5fLgjg82x5EiWa1BTC7DpbhteBm5Or8XtpLAL0hQz+huXMCw@mail.gmail.com>
 <Z1mnFoap_AnPPNfu@cassiopeiae>
 <CAH5fLgiyGjhpVDNkRHtYhk7jY0oJZmPYx3TJRnBvpt1H+-6Y-g@mail.gmail.com>
 <Z1mpvRDnlZN9Mc5o@cassiopeiae>
 <CAH5fLghuM-mNF3CvwWLAwg5F-Kyrjeu_J+zJFrZ1=yqGL85eeA@mail.gmail.com>
 <Z1mxepQse0m66x1v@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1mxepQse0m66x1v@cassiopeiae>

On Wed, Dec 11, 2024 at 04:36:35PM +0100, Danilo Krummrich wrote:
> On Wed, Dec 11, 2024 at 04:15:19PM +0100, Alice Ryhl wrote:
> > On Wed, Dec 11, 2024 at 4:03 PM Danilo Krummrich <dakr@kernel.org> wrote:
> > >
> > > On Wed, Dec 11, 2024 at 03:55:47PM +0100, Alice Ryhl wrote:
> > > > On Wed, Dec 11, 2024 at 3:52 PM Danilo Krummrich <dakr@kernel.org> wrote:
> > > > >
> > > > > On Wed, Dec 11, 2024 at 03:45:53PM +0100, Alice Ryhl wrote:
> > > > > > On Wed, Dec 11, 2024 at 3:29 PM Danilo Krummrich <dakr@kernel.org> wrote:
> > > > > > >
> > > > > > > On Wed, Dec 11, 2024 at 02:34:54PM +0100, Alice Ryhl wrote:
> > > > > > > > On Wed, Dec 11, 2024 at 2:31 PM Danilo Krummrich <dakr@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Dec 11, 2024 at 02:14:37PM +0100, Greg KH wrote:
> > > > > > > > > > On Wed, Dec 11, 2024 at 01:34:31PM +0100, Danilo Krummrich wrote:
> > > > > > > > > > > On Wed, Dec 11, 2024 at 01:22:33PM +0100, Danilo Krummrich wrote:
> > > > > > > > > > > > On Wed, Dec 11, 2024 at 12:05:10PM +0100, Greg KH wrote:
> > > > > > > > > > > > > On Wed, Dec 11, 2024 at 11:59:54AM +0100, Greg KH wrote:
> > > > > > > > > > > > > > On Wed, Dec 11, 2024 at 11:48:23AM +0100, Greg KH wrote:
> > > > > > > > > > > > > > > On Wed, Dec 11, 2024 at 11:45:20AM +0100, Greg KH wrote:
> > > > > > > > > > > > > > > > On Tue, Dec 10, 2024 at 11:46:28PM +0100, Danilo Krummrich wrote:
> > > > > > > > > > > > > > > > > In a subsequent patch we introduce the `Registration` abstraction used
> > > > > > > > > > > > > > > > > to register driver structures. Some subsystems require the module name on
> > > > > > > > > > > > > > > > > driver registration (e.g. PCI in __pci_register_driver()), hence pass
> > > > > > > > > > > > > > > > > the module name to `Module::init`.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Nit, we don't need the NAME of the PCI driver (well, we do like it, but
> > > > > > > > > > > > > > > > that's not the real thing), we want the pointer to the module structure
> > > > > > > > > > > > > > > > in the register_driver call.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Does this provide for that?  I'm thinking it does, but it's not the
> > > > > > > > > > > > > > > > "name" that is the issue here.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Wait, no, you really do want the name, don't you.  You refer to
> > > > > > > > > > > > > > > "module.0" to get the module structure pointer (if I'm reading the code
> > > > > > > > > > > > > > > right), but as you have that pointer already, why can't you just use
> > > > > > > > > > > > > > > module->name there as well as you have a pointer to a valid module
> > > > > > > > > > > > > > > structure that has the name already embedded in it.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > In digging further, it's used by the pci code to call into lower layers,
> > > > > > > > > > > > > > but why it's using a different string other than the module name string
> > > > > > > > > > > > > > is beyond me.  Looks like this goes way back before git was around, and
> > > > > > > > > > > > > > odds are it's my fault for something I wrote a long time ago.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I'll see if I can just change the driver core to not need a name at all,
> > > > > > > > > > > > > > and pull it from the module which would make all of this go away in the
> > > > > > > > > > > > > > end.  Odds are something will break but who knows...
> > > > > > > > > > > > >
> > > > > > > > > > > > > Nope, things break, the "name" is there to handle built-in modules (as
> > > > > > > > > > > > > the module pointer will be NULL.)
> > > > > > > > > > > > >
> > > > > > > > > > > > > So what you really want is not the module->name (as I don't think that
> > > > > > > > > > > > > will be set), but you want KBUILD_MODNAME which the build system sets.
> > > > > > > > > > > >
> > > > > > > > > > > > That's correct, and the reason why I pass through this name argument.
> > > > > > > > > > > >
> > > > > > > > > > > > Sorry I wasn't able to reply earlier to save you some time.
> > > > > > > > > > > >
> > > > > > > > > > > > > You shouldn't need to pass the name through all of the subsystems here,
> > > > > > > > > > > > > just rely on the build system instead.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Or does the Rust side not have KBUILD_MODNAME?
> > > > > > > > > > > >
> > > > > > > > > > > > AFAIK, it doesn't (or didn't have at the time I wrote the patch).
> > > > > > > > > > > >
> > > > > > > > > > > > @Miguel: Can we access KBUILD_MODNAME conveniently?
> > > > > > > > > > >
> > > > > > > > > > > Actually, I now remember there was another reason why I pass it through in
> > > > > > > > > > > `Module::init`.
> > > > > > > > > > >
> > > > > > > > > > > Even if we had env!(KBUILD_MODNAME) already, I'd want to use it from the bus
> > > > > > > > > > > abstraction code, e.g. rust/kernel/pci.rs. But since this is generic code, it
> > > > > > > > > > > won't get the KBUILD_MODNAME from the module that is using the bus abstraction.
> > > > > > > > > >
> > > > > > > > > > Rust can't do that in a macro somehow that all pci rust drivers can pull
> > > > > > > > > > from?
> > > > > > > > >
> > > > > > > > > The problem is that register / unregister is encapsulated within methods of the
> > > > > > > > > abstraction types. So the C macro trick (while generally possible) isn't
> > > > > > > > > applicable.
> > > > > > > > >
> > > > > > > > > I think we could avoid having an additional `name` parameter in `Module::init`,
> > > > > > > > > but it would still need to be the driver resolving `env!(KBUILD_MODNAME)`
> > > > > > > > > passing it into the bus abstraction.
> > > > > > > > >
> > > > > > > > > However, similar to what Alice suggested in another thread, we could include
> > > > > > > > > this step in the `module_*_driver!` macros.
> > > > > > > > >
> > > > > > > > > Modules that don't use this convenience macro would need to do it by hand
> > > > > > > > > though. But that's probably not that big a deal.
> > > > > > > >
> > > > > > > > I think we can do it in the core `module!` macro that everyone has to use.
> > > > > > >
> > > > > > > How? The `module!` macro does not know about the registration instances within
> > > > > > > the module structure.
> > > > > >
> > > > > > You could have the module! macro emit something along these lines:
> > > > > >
> > > > > > impl ModuleName for {type_} {
> > > > > >     const NAME: &'static CStr = c_str!(env!("KBUILD_MODNAME"));
> > > > > > }
> > > > > >
> > > > > > Then you can do `<Self as ModuleName>::NAME` to obtain the name elsewhere.
> > > > >
> > > > > Where {type_} would need to be the driver's `Driver` structure?
> > > > >
> > > > > We'd then need to define the bus adapter as:
> > > > >
> > > > > `pub struct Adapter<T: Driver + ModuleName>(T)`
> > > > >
> > > > > But the question stands I guess, how would the module macro know {type_}?
> > > >
> > > > If you look at the macro implementation in rust/macros/module.rs you
> > > > will find many uses of {type_} throughout the expansion. It's whatever
> > > > is passed to the macro using the `type:` argument.
> > >
> > > Oh, I see. So, this means that module / driver author would still need to create
> > > the "connection" by listing the correspong driver types in the module! macro,
> > > right?
> > 
> > I'm not sure what you mean. I'm *not* suggesting any changes to the
> > interface of module! or module_*_driver!.
> 
> Huh! Seems like we're talking past each other than. Maybe we can briefly
> discuss it in today's call?

I think I figured out the confusion.

The {type_} in the module macro is the thing that implements the `Module` or
`InPlaceModule` trait. However, that's *not* the driver type that is embedded in
the bus adapter.

For instance, what we have is:

```
struct MyDriver;

struct MyModule {
   _driver: Registration<pci::Adapter<MyDriver>,
};

impl pci::Driver for MyDriver { ... }

impl InPlaceModule for MyModule { ... }

module! {
   type: MyModule,
   ...
}
```

This means `module!` would generate:

`impl ModuleName for MyModule { ... }`

But this doesn't help, because `pci::Adapter` doesn't know about `MyModule`, but
only about `MyDriver`.

Do I miss anything?

> 
> > 
> > > If so, I think it'd be better to do it in the `module_*_driver!` macro and let
> > > people implement the trait by hand for modules with multiple drivers (which
> > > should be pretty rare).
> > >
> > > The reason is that I think that otherwise we're probably encoding too much
> > > semantics into the `module!` macro that isn't obvious and people need to
> > > understand.
> > >
> > > >
> > > >
> > > > Alice

