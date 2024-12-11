Return-Path: <linux-pci+bounces-18123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8369ECC19
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 13:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9D02850F3
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 12:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEF82210C0;
	Wed, 11 Dec 2024 12:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVkmv4vF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A43238E23;
	Wed, 11 Dec 2024 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920480; cv=none; b=aBBXjFNaaV3Gweq6Z6oniULA3uAIkP0qOZxjQe9ao3LxrMHwZgLeWqyUQS7Pk7qqpKL87CDw0WfwtlFq/Ov3nGMN+YrQEazv4zyo8gka/S7geMZgLRAIh2mqEvWbd43DKR+RbksqvWaUoVbQNxeiZibpPKP3G+1em1xNEJheezQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920480; c=relaxed/simple;
	bh=ulryPB7pzGBhA0b8mB5egtFHagiv/GS/PHdpk4cIb4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRED3ws5LNgLUxvcnilSiGEDBTDRsTvXjOXEh3dtKZfGFL6sdJmVBQpcZV/XYnZk50xNHfh/N5XCfbQiatp0HvY8baFGTrMbWqGJ390PLsZ0KN8+Tv/3CC1eU3DfMDvpyuzYhvF8ki2CgSTguwTmsogEb9qkVqQFlL5S79WYrKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVkmv4vF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CCAC4CED2;
	Wed, 11 Dec 2024 12:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733920479;
	bh=ulryPB7pzGBhA0b8mB5egtFHagiv/GS/PHdpk4cIb4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WVkmv4vFHehVM3ULff8r93aH+iezaodkWsAnbXBKlPlYpZkcPnUueEaaWNuAoc9m1
	 U0w4NnifFN/var1L2/UybnbQ46YjGk0SJtSuE4Q4xp/XC9jwnWEEC37LOe1S8TToOq
	 kXOIXpD/lPeTOk/PhgERZZS1XtQE6Trx/J1yP834623aPWo7RMdB5xiOVuGSjIS6P5
	 RLlZcjxjFaucY73h9ePrHZR8mn8xGBlXMCvPoMDTQka8EoY77Yj0sEB7hicHxfSlWo
	 013b1NjOuUx5sDi/CdDdUot+TyOV7VKd3VWZWh9QDJvErZLfwetigV/Z8OmT2dBw8w
	 9/A/bpy+KWwOQ==
Date: Wed, 11 Dec 2024 13:34:31 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, tmgross@umich.edu,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 01/16] rust: pass module name to `Module::init`
Message-ID: <Z1mG14DMoIzh6xtj@cassiopeiae>
References: <20241210224947.23804-1-dakr@kernel.org>
 <20241210224947.23804-2-dakr@kernel.org>
 <2024121112-gala-skincare-c85e@gregkh>
 <2024121111-acquire-jarring-71af@gregkh>
 <2024121128-mutt-twice-acda@gregkh>
 <2024121131-carnival-cash-8c5f@gregkh>
 <Z1mEAPlSXA9c282i@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1mEAPlSXA9c282i@cassiopeiae>

On Wed, Dec 11, 2024 at 01:22:33PM +0100, Danilo Krummrich wrote:
> On Wed, Dec 11, 2024 at 12:05:10PM +0100, Greg KH wrote:
> > On Wed, Dec 11, 2024 at 11:59:54AM +0100, Greg KH wrote:
> > > On Wed, Dec 11, 2024 at 11:48:23AM +0100, Greg KH wrote:
> > > > On Wed, Dec 11, 2024 at 11:45:20AM +0100, Greg KH wrote:
> > > > > On Tue, Dec 10, 2024 at 11:46:28PM +0100, Danilo Krummrich wrote:
> > > > > > In a subsequent patch we introduce the `Registration` abstraction used
> > > > > > to register driver structures. Some subsystems require the module name on
> > > > > > driver registration (e.g. PCI in __pci_register_driver()), hence pass
> > > > > > the module name to `Module::init`.
> > > > > 
> > > > > Nit, we don't need the NAME of the PCI driver (well, we do like it, but
> > > > > that's not the real thing), we want the pointer to the module structure
> > > > > in the register_driver call.
> > > > > 
> > > > > Does this provide for that?  I'm thinking it does, but it's not the
> > > > > "name" that is the issue here.
> > > > 
> > > > Wait, no, you really do want the name, don't you.  You refer to
> > > > "module.0" to get the module structure pointer (if I'm reading the code
> > > > right), but as you have that pointer already, why can't you just use
> > > > module->name there as well as you have a pointer to a valid module
> > > > structure that has the name already embedded in it.
> > > 
> > > In digging further, it's used by the pci code to call into lower layers,
> > > but why it's using a different string other than the module name string
> > > is beyond me.  Looks like this goes way back before git was around, and
> > > odds are it's my fault for something I wrote a long time ago.
> > > 
> > > I'll see if I can just change the driver core to not need a name at all,
> > > and pull it from the module which would make all of this go away in the
> > > end.  Odds are something will break but who knows...
> > 
> > Nope, things break, the "name" is there to handle built-in modules (as
> > the module pointer will be NULL.)
> > 
> > So what you really want is not the module->name (as I don't think that
> > will be set), but you want KBUILD_MODNAME which the build system sets.
> 
> That's correct, and the reason why I pass through this name argument.
> 
> Sorry I wasn't able to reply earlier to save you some time.
> 
> > You shouldn't need to pass the name through all of the subsystems here,
> > just rely on the build system instead.
> > 
> > Or does the Rust side not have KBUILD_MODNAME?
> 
> AFAIK, it doesn't (or didn't have at the time I wrote the patch).
> 
> @Miguel: Can we access KBUILD_MODNAME conveniently?

Actually, I now remember there was another reason why I pass it through in
`Module::init`.

Even if we had env!(KBUILD_MODNAME) already, I'd want to use it from the bus
abstraction code, e.g. rust/kernel/pci.rs. But since this is generic code, it
won't get the KBUILD_MODNAME from the module that is using the bus abstraction.

> 
> > 
> > thanks,
> > 
> > greg k-h

