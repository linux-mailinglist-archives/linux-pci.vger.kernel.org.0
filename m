Return-Path: <linux-pci+bounces-24433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E556A6C768
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 04:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56E2189C03E
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 03:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AC74DA04;
	Sat, 22 Mar 2025 03:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oe++DZrt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46753BA53;
	Sat, 22 Mar 2025 03:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742613990; cv=none; b=G18ckH4oubsGG4BJMdADThpjOQGKJEqjjb6wEzElJkjnFV4FVJ/rV0FE4C6CkEq19oS8Tfh46WbJevd06mqzye5rEMsNBkIsezHtgfcEpzQB87ZSupobSLfAQIeE0pARuadW6icjVEHxRPwf1PY7G2ZyNoaPzPvt/sqV6Uu7Df0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742613990; c=relaxed/simple;
	bh=if14U/ufdLYygsU0gs1nFdR47QJncf2WgTd0oLmRFYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUrRN7JXKO0KP/b8N0Pbj9nSQS9gkB9ra4POY+wq0mh2xIICYRzZ2OztlL9IAuHgXzfVCdQg/QbG7uyBdcBhVdAV3kclh2gmGP88LaMNULnA0B2XmaidoLENM9omcWyoWx60bXBHk2Q9ffvNpkDTkGgnaGSWrB55zkr+xQCXzOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oe++DZrt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2C9C4CEDD;
	Sat, 22 Mar 2025 03:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742613989;
	bh=if14U/ufdLYygsU0gs1nFdR47QJncf2WgTd0oLmRFYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oe++DZrt0DezJ1ByuCthBTCM85FuZOF4E3ZQ0XBfo9qy/gCpnbUBhzTcHc33NcHBc
	 rLGUz8sbw2E7TaNmiRMiXRwFpGtYw1kQ/WpkPEHtlqrOy6yD1VjxamjLd9hFKEaA1S
	 FGNaLieHnCtNEpyeMux1DXbaqZnBvC8U7vTxcTaE=
Date: Fri, 21 Mar 2025 20:25:07 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] rust: pci: impl TryFrom<&Device> for &pci::Device
Message-ID: <2025032158-embezzle-life-8810@gregkh>
References: <20250321214826.140946-1-dakr@kernel.org>
 <20250321214826.140946-3-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321214826.140946-3-dakr@kernel.org>

On Fri, Mar 21, 2025 at 10:47:54PM +0100, Danilo Krummrich wrote:
> Implement TryFrom<&device::Device> for &Device.
> 
> This allows us to get a &pci::Device from a generic &Device in a safe
> way; the conversion fails if the device' bus type does not match with
> the PCI bus type.

In thinking about this some more, I am starting to not really like it at
all, more below...

> +impl TryFrom<&device::Device> for &Device {
> +    type Error = kernel::error::Error;
> +
> +    fn try_from(dev: &device::Device) -> Result<Self, Self::Error> {
> +        #[allow(unused_unsafe)]
> +        // SAFETY: rustc < 1.82 falsely treats this as unsafe, see:
> +        // https://blog.rust-lang.org/2024/10/17/Rust-1.82.0.html#safely-addressing-unsafe-statics
> +        if dev.bus_type_raw() != unsafe { addr_of!(bindings::pci_bus_type) } {
> +            return Err(EINVAL);
> +        }

For the record, and to write it down so it's just not a discussion in
person like I've had in the past about this topic, I figured I'd say
something about why we didn't do this in C.

When we wrote the driver model/core all those decades ago, we made the
explicit decision to NOT encode the device type in the device structure.
We did this to "force" the user to "know" the type before casting it
away to the real type, allowing it to be done in a way that would always
"just work" because an error could never occur.

This is not a normal "design pattern" for objects, even then (i.e.
gobject does not do this), and over the years I still think this was a
good decision.  It allowed us to keep the sysfs callbacks simpler in
that it saved us yet-another-function-call-deep, and it also allowed us
to do some "fun" pointer casting tricks for sysfs attributes (much to
CFI's nightmare many years later), and it kept drivers simple, which in
the end is the key.  It also forced driver authors from doing "tricks"
where they could just try to figure out the device type and then do
something with that for many many years until we had to give in and
allow this to happen due to multi-device-sharing subsystems.  And even
then, I think that was the wrong choice.

Yes, over time, many subsystems were forced to come up with ways of
determining the device type, look at dev_is_pci() and where it's used
all over the place (wait, why can't you just use that here too?)  But
those usages are the rare exception.  And I still think that was the
wrong choice.

What I don't want to see is this type of function to be the only way you
can get a pci device from a struct device in rust.  That's going to be
messy as that is going to be a very common occurance (maybe, I haven't
seen how you use this), and would force everyone to always test the
return value, adding complexity and additional work for everyone, just
because the few wants it.

So where/how are you going to use this?  Why can't you just store the
"real" reference to the pci device?  If you want to save off a generic
device reference, where did it come from?  Why can't you just explicitly
save off the correct type at the time you stored it?  Is this just
attempting to save a few pointers?  Is this going to be required to be
called as the only way to get from a device to a pci device in a rust
driver?

Along these lines, if you can convince me that this is something that we
really should be doing, in that we should always be checking every time
someone would want to call to_pci_dev(), that the return value is
checked, then why don't we also do this in C if it's going to be
something to assure people it is going to be correct?  I don't want to
see the rust and C sides get "out of sync" here for things that can be
kept in sync, as that reduces the mental load of all of us as we travers
across the boundry for the next 20+ years.

Note, it's almost 10x more common to just use to_pci_dev() on it's own
and not call dev_is_pci(), so that gives you a sense of just how much
work every individual driver would have to do for such a rare
requirement.

thanks,

greg k-h

