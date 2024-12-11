Return-Path: <linux-pci+bounces-18121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FF09ECBEE
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 13:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5BF2833FB
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 12:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FFB225A2E;
	Wed, 11 Dec 2024 12:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iad5o/Mx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EE11C1F10;
	Wed, 11 Dec 2024 12:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733919753; cv=none; b=Dl0W5F2h6zXAwjVv430QeD9zQol9Txy4hmavW196ndfaKKZeimFthYe4BeL0+hU9sfIIgZue/oSuTSDQYz11gjUTb3pshEtKsnGi1kunK95kCArB6O6csswzEhjcz0svrCh7wZE0j36hH5Hr5EM7juPaQGQDxwdvDz+D1GEySyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733919753; c=relaxed/simple;
	bh=SkINOBjUcEQO7aCkPmINK0GlIJlOrwRXcxwb11MfeX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmZLvQI1J0E/pH81echTxDFJ/6yLUbAn65aGqtMVD+pBtbloOSZ3rJ7/FAk1M81J36w6M7FkZjStUrkpzPw8R1o4ku26NEv1boN72B30Ddl+7aM5gnRpAOllyGtfLz2d7lIDdL04yg+Sbo1zbfgB/xO7gNJhpb11bgpHUzhzDHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iad5o/Mx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31563C4CED2;
	Wed, 11 Dec 2024 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733919752;
	bh=SkINOBjUcEQO7aCkPmINK0GlIJlOrwRXcxwb11MfeX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iad5o/MxKssJwW0lhPl/ii2SkpWyWYjqLQii33cdJD/PNMlptG8YcRSmaBsJV7+TM
	 aZOGeq5r1hrV43ZlYJS/T1xi4otiS8RH2wYPCO01yOOzY/j1grq0U6MlKx5Vtbm0HA
	 yZ14aPxYaoK18/5qbn1lagmGefvs5iOKAxRHlsb2yOeKrfGwJnb9S1bP7GmhS4Px7/
	 NPANgugIAwthGykCAA4uQq/oYYhWzNlVP4Iha4XMjPa53Joi//W38EcrxJxzrlpF3q
	 GHr38m17SAMxKovs4goVVkMBhfaDncSQPwQcdM3s2ZdfYIz2LqUK3K04TkNARvvAHO
	 rz8lZjO7r9yKw==
Date: Wed, 11 Dec 2024 13:22:24 +0100
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
Message-ID: <Z1mEAPlSXA9c282i@cassiopeiae>
References: <20241210224947.23804-1-dakr@kernel.org>
 <20241210224947.23804-2-dakr@kernel.org>
 <2024121112-gala-skincare-c85e@gregkh>
 <2024121111-acquire-jarring-71af@gregkh>
 <2024121128-mutt-twice-acda@gregkh>
 <2024121131-carnival-cash-8c5f@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024121131-carnival-cash-8c5f@gregkh>

On Wed, Dec 11, 2024 at 12:05:10PM +0100, Greg KH wrote:
> On Wed, Dec 11, 2024 at 11:59:54AM +0100, Greg KH wrote:
> > On Wed, Dec 11, 2024 at 11:48:23AM +0100, Greg KH wrote:
> > > On Wed, Dec 11, 2024 at 11:45:20AM +0100, Greg KH wrote:
> > > > On Tue, Dec 10, 2024 at 11:46:28PM +0100, Danilo Krummrich wrote:
> > > > > In a subsequent patch we introduce the `Registration` abstraction used
> > > > > to register driver structures. Some subsystems require the module name on
> > > > > driver registration (e.g. PCI in __pci_register_driver()), hence pass
> > > > > the module name to `Module::init`.
> > > > 
> > > > Nit, we don't need the NAME of the PCI driver (well, we do like it, but
> > > > that's not the real thing), we want the pointer to the module structure
> > > > in the register_driver call.
> > > > 
> > > > Does this provide for that?  I'm thinking it does, but it's not the
> > > > "name" that is the issue here.
> > > 
> > > Wait, no, you really do want the name, don't you.  You refer to
> > > "module.0" to get the module structure pointer (if I'm reading the code
> > > right), but as you have that pointer already, why can't you just use
> > > module->name there as well as you have a pointer to a valid module
> > > structure that has the name already embedded in it.
> > 
> > In digging further, it's used by the pci code to call into lower layers,
> > but why it's using a different string other than the module name string
> > is beyond me.  Looks like this goes way back before git was around, and
> > odds are it's my fault for something I wrote a long time ago.
> > 
> > I'll see if I can just change the driver core to not need a name at all,
> > and pull it from the module which would make all of this go away in the
> > end.  Odds are something will break but who knows...
> 
> Nope, things break, the "name" is there to handle built-in modules (as
> the module pointer will be NULL.)
> 
> So what you really want is not the module->name (as I don't think that
> will be set), but you want KBUILD_MODNAME which the build system sets.

That's correct, and the reason why I pass through this name argument.

Sorry I wasn't able to reply earlier to save you some time.

> You shouldn't need to pass the name through all of the subsystems here,
> just rely on the build system instead.
> 
> Or does the Rust side not have KBUILD_MODNAME?

AFAIK, it doesn't (or didn't have at the time I wrote the patch).

@Miguel: Can we access KBUILD_MODNAME conveniently?

> 
> thanks,
> 
> greg k-h

