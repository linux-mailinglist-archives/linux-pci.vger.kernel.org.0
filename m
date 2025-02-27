Return-Path: <linux-pci+bounces-22598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB59A48BDC
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 23:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064E93B62B4
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 22:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2EA229B07;
	Thu, 27 Feb 2025 22:42:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1DC1B85DF;
	Thu, 27 Feb 2025 22:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740696178; cv=none; b=OgxUzVnKHASt+6xIEkJQI22WEQlDsh9Tms9vtZNFr7bbA6QVXVU553702fvf+XMU5dNBnkvkFLBdUjLMJxlYHJS1uHWO2f/sQwi6QYSW8CLxvX8o9/2+pyUanNxr0SL/NAtWrH/TT1E5LEOr3ya5FJeMJnd18sArzLzDNSXzeHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740696178; c=relaxed/simple;
	bh=bRN9W/jiiMdYoVHjdJLsd3qhbWtVbub56tSRtcv27LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJYQ6a4apGWqNYmxILe5hGg+cY77uJHnD09SJF+ml913QRzwsYmOcrZ1pEvffm50itkVsvJkDVayb1mGeQEeWjRBrZUliG3bxVP1qVuKJeVuDUxQSd8joF1PUGAysMpcrhNCoL9hEvANsdBT1lyAkAnPfSAFsBw7Xf/y1lOS/As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id B3B9330000873;
	Thu, 27 Feb 2025 23:42:46 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A2180448C26; Thu, 27 Feb 2025 23:42:46 +0100 (CET)
Date: Thu, 27 Feb 2025 23:42:46 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Greg KH <gregkh@linuxfoundation.org>
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
Message-ID: <Z8DqZlE5ccujbJ80@wunner.de>
References: <20250227030952.2319050-1-alistair@alistair23.me>
 <20250227030952.2319050-10-alistair@alistair23.me>
 <2025022717-dictate-cortex-5c05@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025022717-dictate-cortex-5c05@gregkh>

On Thu, Feb 27, 2025 at 03:16:40AM -0800, Greg KH wrote:
> On Thu, Feb 27, 2025 at 01:09:41PM +1000, Alistair Francis wrote:
> > The PCI core has just been amended to authenticate CMA-capable devices
> > on enumeration and store the result in an "authenticated" bit in struct
> > pci_dev->spdm_state.
> > 
> > Expose the bit to user space through an eponymous sysfs attribute.
> > 
> > Allow user space to trigger reauthentication (e.g. after it has updated
> > the CMA keyring) by writing to the sysfs attribute.
> > 
> > Implement the attribute in the SPDM library so that other bus types
> > besides PCI may take advantage of it.  They just need to add
> > spdm_attr_group to the attribute groups of their devices and amend the
> > dev_to_spdm_state() helper which retrieves the spdm_state for a given
> > device.
> > 
> > The helper may return an ERR_PTR if it couldn't be determined whether
> > SPDM is supported by the device.  The sysfs attribute is visible in that
> > case but returns an error on access.  This prevents downgrade attacks
> > where an attacker disturbs memory allocation or DOE communication
> > in order to create the appearance that SPDM is unsupported.
> 
> I don't like this "if it's present we still don't know if the device
> supports this", as that is not normally the "sysfs way" here.  Why must
> it be present in those situations?

That's explained above.

Unfortunately there is no (signed) bit in Config Space which tells us
whether authentication is supported by a PCI device.  Rather, it is
necessary to exchange several messages with the device through a
DOE mailbox in config space to determine that.  I'm worried that an
attacker deliberately "glitches" those DOE exchanges and thus creates
the appearance that the device does not support authentication.

Let's say the user's policy is to trust legacy devices which do not
support authentication, but require authentication for newer NVMe drives
from a certain vendor.  An attacker may manipulate an authentication-capable
NVMe drive from that vendor, whereupon it will fail authentication.
But the attacker can trick the user into trusting the device by glitching
the DOE exchanges.

Of course, this is an abnormal situation that users won't encounter
unless they're being attacked.  Normally the attribute is only present
if authentication is supported.

I disagree with your assessment that we have bigger problems.
For security protocols like this we have to be very careful
to prevent trivial circumvention.  We cannot just shrug this off
as unimportant.

The "authenticated" attribute tells user space whether the device
is authenticated.  User space needs to handle errors anyway when
reading the attribute.  Users will get an error if authentication
support could not be determined.  Simple.


> What is going to happen to suddenly
> allow it to come back to be "alive" and working while the device is
> still present in the system?

The device needs to be re-enumerated by the PCI core to retry
determining its authentication capability.  That's why the
sysfs documentation says the user may exercise the "remove"
and "rescan" attributes to retry authentication.


> I'd prefer it to be "if the file is there, this is supported by the
> device.  If the file is not there, it is not supported", as that makes
> things so much simpler for userspace (i.e. you don't want userspace to
> have to both test if the file is there AND read all entries just to see
> if the kernel knows what is going on or not.)

Huh?  Read all entries?  The attribute contains only 0 or 1!

Or you'll get an error reading it.


> Also, how will userspace know if the state changes from "unknown" to
> "now it might work, try it again"?

User space has to explicitly remove and rescan the device.
Otherwise its authentication capability remains unknown.

Again, this is in the abnormal situation when the user is being attacked.
There is no automatic resolution to this scenario, deliberately so.

The user needs to know that there may be an attack going on.
The user may then act on it at their own discretion.


> > Subject to further discussion, a future commit might add a user-defined
> > policy to forbid driver binding to devices which failed authentication,
> > similar to the "authorized" attribute for USB.
> 
> That user-defined policy belongs in userspace, just like USB has it.
> Why would the kernel need this?  Or do you mean that the kernel provides
> a default like USB does and then requires userspace to manually enable a
> device before binding a driver to the device is allowed?

The idea is to bring up PCI device authentication.
And as a first step, expose to user space whether authentication succeeded.

We can have a discussion what other functionality is desirable to make
this useful.  I am open to any ideas you might have.  The commit
message merely makes suggestions as to what might be interesting
going forward.


> > Alternatively, authentication success might be signaled to user space
> > through a uevent, whereupon it may bind a (blacklisted) driver.
> 
> How will that happen?

The SPDM library can be amended to signal a uevent when authentication
succeeds or fails and user space can then act on it.  I imagine systemd
or some other daemon might listen to such events and do interesting things,
such as binding a driver once authentication succeeds.


> > A uevent signaling authentication failure might similarly cause user
> > space to unbind or outright remove the potentially malicious device.
> 
> Again how?  Who will be sending nthose uevents?  Who will be listening
> to them?  What in the kernel is going to change to know to send those
> events?  Why is any of this needed at all?  :)

None of this is needed.  It's just a suggestion.

Maybe you have better ideas.  Be constructive!  Make suggestions!


> > +		If the kernel could not determine whether authentication is
> > +		supported because memory was low or communication with the
> > +		device was not working, the file is visible but accessing it
> > +		fails with error code ENOTTY.
> 
> Not good.  So this means that userspace can not trust that if the file
> is there it actually works, so it has to do more work to determine if it
> is working (as mentioned above).  Just either have the file if it works,
> or not if it does not please.

No no no.

Quoting Destiny's Child here. ;)


> > +		This prevents downgrade attacks where an attacker consumes
> > +		memory or disturbs communication in order to create the
> > +		appearance that a device does not support authentication.
> 
> If an attacker can consume kernel memory to cause this to happen you
> have bigger problems.  That's not the kernel's issue here at all.
> 
> And "disable communication" means "we just don't support it as the
> device doesn't say it does", so again, why does that matter?

Reacting to potential attacks sure is the kernel's business.


> > +		The reason why authentication support could not be determined
> > +		is apparent from "dmesg".  To re-probe authentication support
> > +		of PCI devices, exercise the "remove" and "rescan" attributes.
> 
> Don't make userspace parse kernel logs for this type of thing.  And
> asking userspace to rely on remove and recan is a mess, either show it
> works or not.

I'd say looking in dmesg to determine whether the user is being attacked
is perfectly fine, as is requiring the user to explicitly act on a
potential attack.


> > --- a/drivers/pci/cma.c
> > +++ b/drivers/pci/cma.c
> > @@ -171,8 +171,10 @@ void pci_cma_init(struct pci_dev *pdev)
> >  {
> >  	struct pci_doe_mb *doe;
> >  
> > -	if (IS_ERR(pci_cma_keyring))
> > +	if (IS_ERR(pci_cma_keyring)) {
> > +		pdev->spdm_state = ERR_PTR(-ENOTTY);
> 
> Why ENOTTY?

We use -ENOTTY as return value for unsupported reset methods in the
PCI core, see e.g. pcie_reset_flr(), pcie_af_flr(), pci_pm_reset(),
pci_parent_bus_reset(), pci_reset_hotplug_slot(), ...

We also use -ENOTTY in pci_bridge_wait_for_secondary_bus() and
pci_dev_wait().

It was used here to be consistent with those existing occurrences
in the PCI core.

If you'd prefer something else, please make a suggestion.


> > +static ssize_t authenticated_store(struct device *dev,
> > +				   struct device_attribute *attr,
> > +				   const char *buf, size_t count)
> > +{
> > +	void *spdm_state = dev_to_spdm_state(dev);
> > +	int rc;
> > +
> > +	if (IS_ERR_OR_NULL(spdm_state))
> > +		return PTR_ERR(spdm_state);
> > +
> > +	if (sysfs_streq(buf, "re")) {
> 
> I don't like sysfs files that when reading show a binary, but require a
> "magic string" to be written to them to have them do something else.
> that way lies madness.  What would you do if each sysfs file had a
> custom language that you had to look up for each one?  Be consistant
> here.  But again, I don't think you need a store function at all, either
> the device supports this, or it doesn't.

I'm not sure if you've even read the ABI documentation in full.

The store method is needed to reauthenticate the device,
e.g. after a new trusted root certificate was added to the
kernel's .cma keyring.

Originally I allowed any value to be written to the "authenticated"
attribute to trigger reauthentication.  I changed that to "re"
(actually any word that starts with "re") because I envision that
we may need additional verbs to force authentication with a specific
certificate slot or to force-trust a device despite missing its
root certificate in the .cma keyring.

Thanks,

Lukas

