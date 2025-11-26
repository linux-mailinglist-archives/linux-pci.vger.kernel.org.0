Return-Path: <linux-pci+bounces-42112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC9DC89DC3
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 13:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90C1D4E3E85
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 12:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F32326D77;
	Wed, 26 Nov 2025 12:49:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B2F1DBB3A;
	Wed, 26 Nov 2025 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764161358; cv=none; b=dojw2FWAbYfOPalqaqQFVPlZ8ZxktLZpIcTTmCQD8XFDopo/Nmeh21I15vkHZUWXkozoO9OEQ2DmqXBPIOvIiDciLs0xUlUl3hbCDyBTS6ckvhW+uo5a0iSpBeMx+LYr4GAa/vSEVdnxktxdh0GXCARuHlT0astY+zcqJh6jODM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764161358; c=relaxed/simple;
	bh=vC1+W7/sn5EyGnqDGVHwUKcbOEY7S2fXuXfE40ZvZuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwQbvdLDvDG3f6XKNCq7LWycbY05rboQvKWwy9J4srR9/U7ghF4GFBkTI+AETaCFy1Xrn2Fz7gkM0KSZ2y5y4toDXouyoh3206rSW9kPi/UGc4pS/SUh+sqab8eYVPc05CgHWIJupVSFTCh/kSu5ftrl7NLNYN1gzFnHbjCyi9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id DD2972C02BBD;
	Wed, 26 Nov 2025 13:49:06 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9F6761D658; Wed, 26 Nov 2025 13:49:06 +0100 (CET)
Date: Wed, 26 Nov 2025 13:49:06 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Riana Tauro <riana.tauro@intel.com>,
	"Sean C. Dardis" <sean.c.dardis@intel.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Benjamin Block <bblock@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Alek Du <alek.du@intel.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI/PM: Reinstate clearing state_saved in legacy
 and !pm codepaths
Message-ID: <aSb3Qt6n55Fsl7IF@wunner.de>
References: <094f2aad64418710daf0940112abe5a0afdc6bce.1763483367.git.lukas@wunner.de>
 <20251125231846.GA2767905@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125231846.GA2767905@bhelgaas>

On Tue, Nov 25, 2025 at 05:18:46PM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 19, 2025 at 09:50:01AM +0100, Lukas Wunner wrote:
> > But there are two corner cases where the PCI core neglects to clear the
> > flag before commencing the suspend sequence:
> > 
> > * If a driver has legacy PCI PM callbacks, pci_legacy_suspend() neglects
> >   to clear the flag.  The (stale) flag is subsequently queried by
> >   pci_legacy_suspend() itself and pci_legacy_suspend_late().
> > 
> > * If a device has no driver or its driver has no PCI PM callbacks,
> >   pci_pm_freeze() neglects to clear the flag.  The (stale) flag is
> >   subsequently queried by pci_pm_freeze_noirq().
> > 
> > The flag may be set prior to suspend if the device went through error
> > recovery:  Drivers commonly invoke pci_restore_state() + pci_save_state()
> > to restore Config Space after reset.
> 
> I guess the only point of pci_save_state() in this case is to set
> state_saved again so a future pci_restore_state() will work, right?
> 
> The actual state being *saved* is pointless, assuming pci_save_state()
> saves exactly the same data that pci_restore_state() restored.
> 
> And these are the pci_save_state() calls you removed with "treewide:
> Drop pci_save_state() after pci_restore_state()".  Too bad we have to
> document the behavior we're about to change, but that's what we need
> to do.  It's just a little clutter to keep in mind for this release.

Yes.  All of your comments above are correct.

> > The flag may also be set if drivers call pci_save_state() on probe to
> > allow for recovery from subsequent errors.
> > 
> > The result is that pci_legacy_suspend_late() and pci_pm_freeze_noirq()
> > don't call pci_save_state() and so the state that will be restored on
> > resume is the one recorded on last error recovery or on probe, not the one
> > that the device had on suspend.  If the two states happen to be identical,
> > there's no problem.
> 
> So IIUC the effect is that after this change and the "treewide"
> change,
> 
>   - If the driver uses legacy PM, the state restored on resume will be
>     the state from suspend instead of the state on probe.

Right.

> 
>   - For devices with no driver or a driver without PM, if the device
>     has already been runtime-suspended, we avoid a pointless
>     pci_save_state(), so it's an optimization and not logically
>     related to the legacy PM case.

It's slightly different:

  - For devices with no driver or a driver without PM, the state restored
    on "thaw" and "restore" will be the state from "freeze" instead of the
    state on probe.

So the same problem that we have for drivers using legacy PM, we also
have for devices with no driver or a driver without (modern) PM callbacks,
but only in the "freeze" codepath (for hibernation).

In the patch, I made the "pci_dev->state_saved = false" assignment
conditional on !pm_runtime_suspended() in the "freeze" codepath.
I didn't do the same in the legacy codepath because none of the
drivers using legacy PM callbacks seem to be using runtime PM.

The purpose of making it conditional on !pm_runtime_suspended()
is just that we'd otherwise call pci_save_state() twice:  Once in
pci_pm_runtime_suspend() and once more in pci_pm_freeze().
That would be pointless.

In the commit message, I provided a rationale for the conditionality,
but inadvertently caused confusion.

> I'm thinking of something like this for the merge commit and eventual
> pull request; please correct me if this isn't right:
> 
>   Restore the suspend config state, not the state from probe or error
>   recovery, for drivers using legacy PCI suspend.
> 
>   Avoid saving config state again for devices without driver PM if
>   their state was already saved by runtime suspend.

I'd suggest instead (feel free to wordsmith as you see fit):

  Restore the suspend config state, not the state from probe or error
  recovery, for drivers using legacy PCI suspend.   [ <- unmodified ]

  Same for devices with no driver or a driver without PM callbacks
  when the system is hibernated.                   [ <- replacement ]

Mentioning the runtime PM conditionality in the high-level changelog
is probably not worth it.

Was I able to clarify all questions?  Please ask again if not.

Also, in case the meaning of "freeze", "thaw", "restore" isn't clear,
here's the order of a hibernation sequence (suspend to disk):

  pci_pm_prepare()
  pci_pm_freeze()
  pci_pm_freeze_noirq()
  <system image is generated>
  pci_pm_thaw_noirq()
  pci_pm_thaw()
  pci_pm_complete()
  pci_pm_prepare()
  pci_pm_poweroff()
  pci_pm_poweroff_late()
  pci_pm_poweroff_noirq()
  <system is asleep, then restarted with boot kernel>
  pci_pm_prepare()
  pci_pm_freeze()
  pci_pm_freeze_noirq()
  <system image is restored, replacing the boot kernel>
  pci_pm_restore_noirq()
  pci_pm_restore()
  pci_pm_complete()

Note that "freeze" happens twice in the whole sequence.

Thanks,

Lukas

