Return-Path: <linux-pci+bounces-18128-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA029ECCEF
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 14:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB48188AAB3
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 13:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30149229138;
	Wed, 11 Dec 2024 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LwSrtw23"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68B0226186;
	Wed, 11 Dec 2024 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733922916; cv=none; b=df6xqetgaZx71kFzd1DL8E8cYF+OLAmRA62NT6pfaxxripQ+BIOmaXcbxw4umRk3BT6R9XGILENCV3bvdkCUWa5I16eibhPK6YSy12GWsQs3uswMh8kOrXuX2kd5Sc3ZjLVl2Nygn+u2wrf185YPonQLD7sK+st3KzsixiTOsNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733922916; c=relaxed/simple;
	bh=IfWJJWrkHUieFv0YCu1Ku2mdZQjH8pVYpe8Efo+32Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0NSpk7hJqqeA4rC/f+ktL6X8XmSeJCqXMgvAWTBoIt/6Vp/DQjMEUHCOluS/N2SwjZ7HgRgzwSpnJX7bnAv7t5pS5dZfR0/+qTo4ZCm+kVFNFMOc37r0qPTLscCkxDGfTPhgoSR23MEgpGFKbqKqZXoKrHU8JenGpkBYya1BGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LwSrtw23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D81C4CED2;
	Wed, 11 Dec 2024 13:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733922915;
	bh=IfWJJWrkHUieFv0YCu1Ku2mdZQjH8pVYpe8Efo+32Cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LwSrtw23YolMvTdE8Y20anTQx0v0u2ZZVMVUMW6MCzdH2cRY5E2U+LZ9V3S80TwY+
	 BeSGRCaVgSxe25dqPoNRM6DKefmewOuXyc3nB4ggnmP1087dizfF3uKHtcQ6FLaXTZ
	 KvIkQNwfUz4FLjOknrRadzJop9pV/l0neRgeFjfM=
Date: Wed, 11 Dec 2024 14:14:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
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
Message-ID: <2024121109-ample-retrain-bde0@gregkh>
References: <20241210224947.23804-1-dakr@kernel.org>
 <20241210224947.23804-2-dakr@kernel.org>
 <2024121112-gala-skincare-c85e@gregkh>
 <2024121111-acquire-jarring-71af@gregkh>
 <2024121128-mutt-twice-acda@gregkh>
 <2024121131-carnival-cash-8c5f@gregkh>
 <Z1mEAPlSXA9c282i@cassiopeiae>
 <Z1mG14DMoIzh6xtj@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1mG14DMoIzh6xtj@cassiopeiae>

On Wed, Dec 11, 2024 at 01:34:31PM +0100, Danilo Krummrich wrote:
> On Wed, Dec 11, 2024 at 01:22:33PM +0100, Danilo Krummrich wrote:
> > On Wed, Dec 11, 2024 at 12:05:10PM +0100, Greg KH wrote:
> > > On Wed, Dec 11, 2024 at 11:59:54AM +0100, Greg KH wrote:
> > > > On Wed, Dec 11, 2024 at 11:48:23AM +0100, Greg KH wrote:
> > > > > On Wed, Dec 11, 2024 at 11:45:20AM +0100, Greg KH wrote:
> > > > > > On Tue, Dec 10, 2024 at 11:46:28PM +0100, Danilo Krummrich wrote:
> > > > > > > In a subsequent patch we introduce the `Registration` abstraction used
> > > > > > > to register driver structures. Some subsystems require the module name on
> > > > > > > driver registration (e.g. PCI in __pci_register_driver()), hence pass
> > > > > > > the module name to `Module::init`.
> > > > > > 
> > > > > > Nit, we don't need the NAME of the PCI driver (well, we do like it, but
> > > > > > that's not the real thing), we want the pointer to the module structure
> > > > > > in the register_driver call.
> > > > > > 
> > > > > > Does this provide for that?  I'm thinking it does, but it's not the
> > > > > > "name" that is the issue here.
> > > > > 
> > > > > Wait, no, you really do want the name, don't you.  You refer to
> > > > > "module.0" to get the module structure pointer (if I'm reading the code
> > > > > right), but as you have that pointer already, why can't you just use
> > > > > module->name there as well as you have a pointer to a valid module
> > > > > structure that has the name already embedded in it.
> > > > 
> > > > In digging further, it's used by the pci code to call into lower layers,
> > > > but why it's using a different string other than the module name string
> > > > is beyond me.  Looks like this goes way back before git was around, and
> > > > odds are it's my fault for something I wrote a long time ago.
> > > > 
> > > > I'll see if I can just change the driver core to not need a name at all,
> > > > and pull it from the module which would make all of this go away in the
> > > > end.  Odds are something will break but who knows...
> > > 
> > > Nope, things break, the "name" is there to handle built-in modules (as
> > > the module pointer will be NULL.)
> > > 
> > > So what you really want is not the module->name (as I don't think that
> > > will be set), but you want KBUILD_MODNAME which the build system sets.
> > 
> > That's correct, and the reason why I pass through this name argument.
> > 
> > Sorry I wasn't able to reply earlier to save you some time.
> > 
> > > You shouldn't need to pass the name through all of the subsystems here,
> > > just rely on the build system instead.
> > > 
> > > Or does the Rust side not have KBUILD_MODNAME?
> > 
> > AFAIK, it doesn't (or didn't have at the time I wrote the patch).
> > 
> > @Miguel: Can we access KBUILD_MODNAME conveniently?
> 
> Actually, I now remember there was another reason why I pass it through in
> `Module::init`.
> 
> Even if we had env!(KBUILD_MODNAME) already, I'd want to use it from the bus
> abstraction code, e.g. rust/kernel/pci.rs. But since this is generic code, it
> won't get the KBUILD_MODNAME from the module that is using the bus abstraction.

Rust can't do that in a macro somehow that all pci rust drivers can pull
from?

thanks,

greg k-h

