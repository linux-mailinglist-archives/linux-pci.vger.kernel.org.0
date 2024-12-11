Return-Path: <linux-pci+bounces-18138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A3A9ECE93
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 15:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1005288429
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 14:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320A615B554;
	Wed, 11 Dec 2024 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntd0UbJa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA61938DE9;
	Wed, 11 Dec 2024 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927395; cv=none; b=et/Ott+mIsdjiOCHJJPzBRwDFxSemq7rLkSIXqjPoi54v8fg4YmMLvMvcRliwZ7qXUXNsm/OLV1F9fFGnYd3GCTG85jr8a5DKTyVy7HSN9c35UPSEFeQJH0fHiQtOV8UwS9vuxd8iI666KdO77XI//Bb+5i9CStu93WMa9wRg4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927395; c=relaxed/simple;
	bh=2Xk8uWMzIczoxMHUC2h5gjfThEIC8deVCG2F5mgdBhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZMPGWMTi+3eMVXer8yTuB661ssUGWN1brN2jq5e9xbV3JtVsYVJP8bRN1HV1+/P3s3w64bEKRAl1pQL5g809ccldsBivwArcLz1zSMCTTwbdNujYwedOdj2JD2LRZpUC42ObiMpe5xMLCX1MtCtL+z/3FNl5Cw7eo6KQeDBOfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntd0UbJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117C2C4CED2;
	Wed, 11 Dec 2024 14:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733927394;
	bh=2Xk8uWMzIczoxMHUC2h5gjfThEIC8deVCG2F5mgdBhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ntd0UbJau4aamE/mSy5+MxOy+ScxNY3aIPC9N+yvSldfQ0gd0sQeNKdG3pT9s/et/
	 Ayzy1nk4TMSsSZpMcCFJGKz1zLogNlzwaIJ5fHjUgGEY8ttFRt5kXG7+UlQtWUBsFa
	 dXYYK0wMKQ3JBaFz2vvGDnAvQYk3xuYhIxBXwIjeRglQX1/BdlSvPFl14CTRia77Qn
	 TJYQiqt4FuE0ZXVUblan0faGQQdBLOmPNXRYfhyJF15GBZVYy3kZxc9rC1jPSK4Bj/
	 K+y6VpLi/8iVDVY88JsUh95iqoyhGHBH+npoGlvwaLWp6mmgD+Oy32WS5bGJ91ws9W
	 wqdlIDwPCfSmg==
Date: Wed, 11 Dec 2024 15:29:46 +0100
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
Message-ID: <Z1mh2rPC3ZOjg-pO@cassiopeiae>
References: <20241210224947.23804-2-dakr@kernel.org>
 <2024121112-gala-skincare-c85e@gregkh>
 <2024121111-acquire-jarring-71af@gregkh>
 <2024121128-mutt-twice-acda@gregkh>
 <2024121131-carnival-cash-8c5f@gregkh>
 <Z1mEAPlSXA9c282i@cassiopeiae>
 <Z1mG14DMoIzh6xtj@cassiopeiae>
 <2024121109-ample-retrain-bde0@gregkh>
 <Z1mUG8ruFkPhVZwj@cassiopeiae>
 <CAH5fLgh3rwS1sFmrhx3zCaSBbAJfhJTV_kbyCVX6BhvnBZ+cQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgh3rwS1sFmrhx3zCaSBbAJfhJTV_kbyCVX6BhvnBZ+cQA@mail.gmail.com>

On Wed, Dec 11, 2024 at 02:34:54PM +0100, Alice Ryhl wrote:
> On Wed, Dec 11, 2024 at 2:31 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Wed, Dec 11, 2024 at 02:14:37PM +0100, Greg KH wrote:
> > > On Wed, Dec 11, 2024 at 01:34:31PM +0100, Danilo Krummrich wrote:
> > > > On Wed, Dec 11, 2024 at 01:22:33PM +0100, Danilo Krummrich wrote:
> > > > > On Wed, Dec 11, 2024 at 12:05:10PM +0100, Greg KH wrote:
> > > > > > On Wed, Dec 11, 2024 at 11:59:54AM +0100, Greg KH wrote:
> > > > > > > On Wed, Dec 11, 2024 at 11:48:23AM +0100, Greg KH wrote:
> > > > > > > > On Wed, Dec 11, 2024 at 11:45:20AM +0100, Greg KH wrote:
> > > > > > > > > On Tue, Dec 10, 2024 at 11:46:28PM +0100, Danilo Krummrich wrote:
> > > > > > > > > > In a subsequent patch we introduce the `Registration` abstraction used
> > > > > > > > > > to register driver structures. Some subsystems require the module name on
> > > > > > > > > > driver registration (e.g. PCI in __pci_register_driver()), hence pass
> > > > > > > > > > the module name to `Module::init`.
> > > > > > > > >
> > > > > > > > > Nit, we don't need the NAME of the PCI driver (well, we do like it, but
> > > > > > > > > that's not the real thing), we want the pointer to the module structure
> > > > > > > > > in the register_driver call.
> > > > > > > > >
> > > > > > > > > Does this provide for that?  I'm thinking it does, but it's not the
> > > > > > > > > "name" that is the issue here.
> > > > > > > >
> > > > > > > > Wait, no, you really do want the name, don't you.  You refer to
> > > > > > > > "module.0" to get the module structure pointer (if I'm reading the code
> > > > > > > > right), but as you have that pointer already, why can't you just use
> > > > > > > > module->name there as well as you have a pointer to a valid module
> > > > > > > > structure that has the name already embedded in it.
> > > > > > >
> > > > > > > In digging further, it's used by the pci code to call into lower layers,
> > > > > > > but why it's using a different string other than the module name string
> > > > > > > is beyond me.  Looks like this goes way back before git was around, and
> > > > > > > odds are it's my fault for something I wrote a long time ago.
> > > > > > >
> > > > > > > I'll see if I can just change the driver core to not need a name at all,
> > > > > > > and pull it from the module which would make all of this go away in the
> > > > > > > end.  Odds are something will break but who knows...
> > > > > >
> > > > > > Nope, things break, the "name" is there to handle built-in modules (as
> > > > > > the module pointer will be NULL.)
> > > > > >
> > > > > > So what you really want is not the module->name (as I don't think that
> > > > > > will be set), but you want KBUILD_MODNAME which the build system sets.
> > > > >
> > > > > That's correct, and the reason why I pass through this name argument.
> > > > >
> > > > > Sorry I wasn't able to reply earlier to save you some time.
> > > > >
> > > > > > You shouldn't need to pass the name through all of the subsystems here,
> > > > > > just rely on the build system instead.
> > > > > >
> > > > > > Or does the Rust side not have KBUILD_MODNAME?
> > > > >
> > > > > AFAIK, it doesn't (or didn't have at the time I wrote the patch).
> > > > >
> > > > > @Miguel: Can we access KBUILD_MODNAME conveniently?
> > > >
> > > > Actually, I now remember there was another reason why I pass it through in
> > > > `Module::init`.
> > > >
> > > > Even if we had env!(KBUILD_MODNAME) already, I'd want to use it from the bus
> > > > abstraction code, e.g. rust/kernel/pci.rs. But since this is generic code, it
> > > > won't get the KBUILD_MODNAME from the module that is using the bus abstraction.
> > >
> > > Rust can't do that in a macro somehow that all pci rust drivers can pull
> > > from?
> >
> > The problem is that register / unregister is encapsulated within methods of the
> > abstraction types. So the C macro trick (while generally possible) isn't
> > applicable.
> >
> > I think we could avoid having an additional `name` parameter in `Module::init`,
> > but it would still need to be the driver resolving `env!(KBUILD_MODNAME)`
> > passing it into the bus abstraction.
> >
> > However, similar to what Alice suggested in another thread, we could include
> > this step in the `module_*_driver!` macros.
> >
> > Modules that don't use this convenience macro would need to do it by hand
> > though. But that's probably not that big a deal.
> 
> I think we can do it in the core `module!` macro that everyone has to use.

How? The `module!` macro does not know about the registration instances within
the module structure.

> 
> Alice

