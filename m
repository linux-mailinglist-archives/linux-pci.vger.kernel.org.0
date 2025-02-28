Return-Path: <linux-pci+bounces-22608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E490AA48E0E
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 02:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD85D7A62E9
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 01:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF3235963;
	Fri, 28 Feb 2025 01:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T7pRl/DJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480FE276D11;
	Fri, 28 Feb 2025 01:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740706864; cv=none; b=PBcZiW8ydf1Dj/idS40O4aePRiQLjxyThbUEyMGWN9qXwgw/Q4d5LV5BG+1X1x5xqfK2oJyD6uOgIJlKy/kQJTohnIc977biy/07t4mC7ccLg4RVMVrUHuSWMfgBWIa8BBRvNsw5jah3oybXnzNVBa5wr3HqYiCzeqbTirSy2QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740706864; c=relaxed/simple;
	bh=7Ao72ZSN+JGWeghAFVfYDlkSLS7LdTHxr30TmAU4vkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Llm/sjm8Mfn86U2t+Ia2snHWt0UWzAPYdO+SvabRRTbRSoLJttnFwzi7LPmyYdJu5SkIckVwy+9KPc8Vpg7snIvLu/xD7x8A4nadFGctk0ON1DUMNXqNqwRl6fYH95K3IiXXgMhWeBtyuCieO8K20vUl5XsL5riXYksKbt1cTyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T7pRl/DJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F866C4CEDD;
	Fri, 28 Feb 2025 01:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740706863;
	bh=7Ao72ZSN+JGWeghAFVfYDlkSLS7LdTHxr30TmAU4vkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T7pRl/DJsxzZ+ib93e1hwB+ZcGmQj5mXqTI0GIxi5+XlzEApYSXVY23640qOhXeGY
	 rq0Qj+AMH41PDhmGEVOpmEF45FppD7OSb6Xrcc7BIvb7G9A6sn+9onL4JbeZ7vfSF+
	 y8L8HwlNFWbr48lq+OW8NbT/jKdWKvfa67N4RSXM=
Date: Thu, 27 Feb 2025 17:39:53 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Alistair Francis <alistair@alistair23.me>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com, Jonathan.Cameron@huawei.com,
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org,
	boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
	wilfred.mallawa@wdc.com, aliceryhl@google.com, ojeda@kernel.org,
	alistair23@gmail.com, a.hindborg@kernel.org, tmgross@umich.edu,
	gary@garyguo.net, alex.gaynor@gmail.com, benno.lossin@proton.me,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [RFC v2 09/20] PCI/CMA: Expose in sysfs whether devices are
 authenticated
Message-ID: <2025022748-flock-verbalize-b66a@gregkh>
References: <20250227030952.2319050-1-alistair@alistair23.me>
 <20250227030952.2319050-10-alistair@alistair23.me>
 <2025022717-dictate-cortex-5c05@gregkh>
 <Z8DqZlE5ccujbJ80@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8DqZlE5ccujbJ80@wunner.de>

On Thu, Feb 27, 2025 at 11:42:46PM +0100, Lukas Wunner wrote:
> On Thu, Feb 27, 2025 at 03:16:40AM -0800, Greg KH wrote:
> > On Thu, Feb 27, 2025 at 01:09:41PM +1000, Alistair Francis wrote:
> > > The PCI core has just been amended to authenticate CMA-capable devices
> > > on enumeration and store the result in an "authenticated" bit in struct
> > > pci_dev->spdm_state.
> > > 
> > > Expose the bit to user space through an eponymous sysfs attribute.
> > > 
> > > Allow user space to trigger reauthentication (e.g. after it has updated
> > > the CMA keyring) by writing to the sysfs attribute.
> > > 
> > > Implement the attribute in the SPDM library so that other bus types
> > > besides PCI may take advantage of it.  They just need to add
> > > spdm_attr_group to the attribute groups of their devices and amend the
> > > dev_to_spdm_state() helper which retrieves the spdm_state for a given
> > > device.
> > > 
> > > The helper may return an ERR_PTR if it couldn't be determined whether
> > > SPDM is supported by the device.  The sysfs attribute is visible in that
> > > case but returns an error on access.  This prevents downgrade attacks
> > > where an attacker disturbs memory allocation or DOE communication
> > > in order to create the appearance that SPDM is unsupported.
> > 
> > I don't like this "if it's present we still don't know if the device
> > supports this", as that is not normally the "sysfs way" here.  Why must
> > it be present in those situations?
> 
> That's explained above.

Not really, you just say "downgrade attacks", which is not something
that we need to worry about, right?  If so, I think this bit is the
least of our worries.

> Unfortunately there is no (signed) bit in Config Space which tells us
> whether authentication is supported by a PCI device.  Rather, it is
> necessary to exchange several messages with the device through a
> DOE mailbox in config space to determine that.  I'm worried that an
> attacker deliberately "glitches" those DOE exchanges and thus creates
> the appearance that the device does not support authentication.

That's a hardware glitch, and if that happens, then it will show a 0 and
that's the same as not being present at all, right?  Otherwise you just
pound on the file to try to see if the glitch was not real?  That's not
going to go over well.

> Let's say the user's policy is to trust legacy devices which do not
> support authentication, but require authentication for newer NVMe drives
> from a certain vendor.  An attacker may manipulate an authentication-capable
> NVMe drive from that vendor, whereupon it will fail authentication.
> But the attacker can trick the user into trusting the device by glitching
> the DOE exchanges.

Again, are we now claiming that Linux needs to support "hardware
glitching"?  Is that required somewhere?  I think if the DOE exchanges
fail, we just trust the device as we have to trust something, right?

> Of course, this is an abnormal situation that users won't encounter
> unless they're being attacked.  Normally the attribute is only present
> if authentication is supported.
> 
> I disagree with your assessment that we have bigger problems.
> For security protocols like this we have to be very careful
> to prevent trivial circumvention.  We cannot just shrug this off
> as unimportant.

hardware glitching is not trivial.  Let's only worry about that if the
hardware people somehow require it, and if so, we can push back and say
"stop making us fix your broken designs" :)

> The "authenticated" attribute tells user space whether the device
> is authenticated.  User space needs to handle errors anyway when
> reading the attribute.  Users will get an error if authentication
> support could not be determined.  Simple.

No, if it's not determined, it shouldn't be present.

> > What is going to happen to suddenly
> > allow it to come back to be "alive" and working while the device is
> > still present in the system?
> 
> The device needs to be re-enumerated by the PCI core to retry
> determining its authentication capability.  That's why the
> sysfs documentation says the user may exercise the "remove"
> and "rescan" attributes to retry authentication.

But how does it know that?  remove and recan is a huge sledgehammer, and
an amazing one if it even works on most hardware.  Don't make it part of
any normal process please.

> > I'd prefer it to be "if the file is there, this is supported by the
> > device.  If the file is not there, it is not supported", as that makes
> > things so much simpler for userspace (i.e. you don't want userspace to
> > have to both test if the file is there AND read all entries just to see
> > if the kernel knows what is going on or not.)
> 
> Huh?  Read all entries?  The attribute contains only 0 or 1!
> 
> Or you'll get an error reading it.

It's the error, don't do that.  If an error is going to happen, then
don't have the file there.  That's the way sysfs works, it's not a
"let's add all possible files and then make userspace open them all and
see if an error happens to determine what really is present for this
device" model.  It's a "if a file is there, that attribute is there and
we can read it".

> > > Alternatively, authentication success might be signaled to user space
> > > through a uevent, whereupon it may bind a (blacklisted) driver.
> > 
> > How will that happen?
> 
> The SPDM library can be amended to signal a uevent when authentication
> succeeds or fails and user space can then act on it.  I imagine systemd
> or some other daemon might listen to such events and do interesting things,
> such as binding a driver once authentication succeeds.

That's a new user/kernel api and should be designed ONLY if you actually
need it and have a user.  Otherwise let's just wait for later for that.

> Maybe you have better ideas.  Be constructive!  Make suggestions!

Again, have the file there only if this is something that the hardware
supports.  Don't fail a read just because the hardware does not seem to
support it, but it might sometime in the future if you just happen to
unplug/plug it back in.

> > > +		This prevents downgrade attacks where an attacker consumes
> > > +		memory or disturbs communication in order to create the
> > > +		appearance that a device does not support authentication.
> > 
> > If an attacker can consume kernel memory to cause this to happen you
> > have bigger problems.  That's not the kernel's issue here at all.
> > 
> > And "disable communication" means "we just don't support it as the
> > device doesn't say it does", so again, why does that matter?
> 
> Reacting to potential attacks sure is the kernel's business.

Reacting to real, software attacks is the kernel's business.  Reacting
to possible hardware issues that are just theoretical is not.

> > > +		The reason why authentication support could not be determined
> > > +		is apparent from "dmesg".  To re-probe authentication support
> > > +		of PCI devices, exercise the "remove" and "rescan" attributes.
> > 
> > Don't make userspace parse kernel logs for this type of thing.  And
> > asking userspace to rely on remove and recan is a mess, either show it
> > works or not.
> 
> I'd say looking in dmesg to determine whether the user is being attacked
> is perfectly fine, as is requiring the user to explicitly act on a
> potential attack.
> 
> 
> > > --- a/drivers/pci/cma.c
> > > +++ b/drivers/pci/cma.c
> > > @@ -171,8 +171,10 @@ void pci_cma_init(struct pci_dev *pdev)
> > >  {
> > >  	struct pci_doe_mb *doe;
> > >  
> > > -	if (IS_ERR(pci_cma_keyring))
> > > +	if (IS_ERR(pci_cma_keyring)) {
> > > +		pdev->spdm_state = ERR_PTR(-ENOTTY);
> > 
> > Why ENOTTY?
> 
> We use -ENOTTY as return value for unsupported reset methods in the
> PCI core, see e.g. pcie_reset_flr(), pcie_af_flr(), pci_pm_reset(),
> pci_parent_bus_reset(), pci_reset_hotplug_slot(), ...
> 
> We also use -ENOTTY in pci_bridge_wait_for_secondary_bus() and
> pci_dev_wait().
> 
> It was used here to be consistent with those existing occurrences
> in the PCI core.
> 
> If you'd prefer something else, please make a suggestion.

Ah, didn't realize that was a pci thing, ok, nevermind.

> > > +static ssize_t authenticated_store(struct device *dev,
> > > +				   struct device_attribute *attr,
> > > +				   const char *buf, size_t count)
> > > +{
> > > +	void *spdm_state = dev_to_spdm_state(dev);
> > > +	int rc;
> > > +
> > > +	if (IS_ERR_OR_NULL(spdm_state))
> > > +		return PTR_ERR(spdm_state);
> > > +
> > > +	if (sysfs_streq(buf, "re")) {
> > 
> > I don't like sysfs files that when reading show a binary, but require a
> > "magic string" to be written to them to have them do something else.
> > that way lies madness.  What would you do if each sysfs file had a
> > custom language that you had to look up for each one?  Be consistant
> > here.  But again, I don't think you need a store function at all, either
> > the device supports this, or it doesn't.
> 
> I'm not sure if you've even read the ABI documentation in full.
> 
> The store method is needed to reauthenticate the device,
> e.g. after a new trusted root certificate was added to the
> kernel's .cma keyring.

Why not have a different file called "reauthentication" that only allows
a write to it of a 1/Y/y to do the reauthentication.  sysfs is a "one
file per thing" interface, not a "parse a command and do something but
when read from return a different value" interface.

Let's keep it dirt simple please.

thanks,

greg k-h

