Return-Path: <linux-pci+bounces-42173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00568C8C608
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 00:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2DD73AE585
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 23:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943B529BD85;
	Wed, 26 Nov 2025 23:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWxIZAIv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A815248F51;
	Wed, 26 Nov 2025 23:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764200765; cv=none; b=hOMMOoVHdvYRMjpIhHHdQCtiixj+TjTMEPq6vunWBTw1g/r5gby+GAgL6RsUY/fsPMzBiDFo+dBOk+RLIr6pTgJKQTLtn8NbZFo8Rk02i/3wcDM3aXiBz2Apg6Gskn/bIq/C9pUQafCTsTf22EpzLvRMgFm/jBQJm7BpTD8nWMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764200765; c=relaxed/simple;
	bh=jLSo+HaqFDdXCrl+AzMOfDRdPEoc0iJrUIlW7wVPTAo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jBON1T3Y6ihB6FzUsbOWSyY60B5Y7YGeG9l6AgKL4o+6uSYrdg+pFbR1k08NlO71nY4AxO05gLL3cQHsEW9/SATLUosWu3X6f/gnQSuWWmvm+DNoTDVfWW+IPqxOVK9H58k7yW5XqNoiHqmYfv+g82c+Syqfg22WqETP8DvHdFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWxIZAIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D66C4CEF7;
	Wed, 26 Nov 2025 23:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764200765;
	bh=jLSo+HaqFDdXCrl+AzMOfDRdPEoc0iJrUIlW7wVPTAo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HWxIZAIv7DqHXVOIWKg0XqGmcA/cw760bg7EOuLUqfbnON0a2r98gNBTz0B1B3sFn
	 q+QdMqL+0xR4iLicVYTxUdNcPAu1wUanrVk71GPSJ7pA+W7jtR9864FPLJgddNXb6e
	 u8EHh9Oc2OcD97pAWdQ0EkLCIw3nC2bu7G3Cp9/h4H3RdDFeXNE9MkzGl/iIIGG4Hl
	 +9GiB82Jgps53tHtwrewVL3erFApaNs5llhDIafDhise/G4foSILF/dhxtvKrN2a18
	 gbvz3V2UGpy7ug9xF2IVn8xTsavKE+q0KSWomVXN0jjWmkcOk+0YWbcxz5NbXBpdFj
	 BKQfu2uhCgqiA==
Date: Wed, 26 Nov 2025 17:46:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
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
Message-ID: <20251126234603.GA2832326@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSb3Qt6n55Fsl7IF@wunner.de>

On Wed, Nov 26, 2025 at 01:49:06PM +0100, Lukas Wunner wrote:
> On Tue, Nov 25, 2025 at 05:18:46PM -0600, Bjorn Helgaas wrote:
> > On Wed, Nov 19, 2025 at 09:50:01AM +0100, Lukas Wunner wrote:
> > > But there are two corner cases where the PCI core neglects to clear the
> > > flag before commencing the suspend sequence:
> > > 
> > > * If a driver has legacy PCI PM callbacks, pci_legacy_suspend() neglects
> > >   to clear the flag.  The (stale) flag is subsequently queried by
> > >   pci_legacy_suspend() itself and pci_legacy_suspend_late().
> > > 
> > > * If a device has no driver or its driver has no PCI PM callbacks,
> > >   pci_pm_freeze() neglects to clear the flag.  The (stale) flag is
> > >   subsequently queried by pci_pm_freeze_noirq().
> > > 
> > > The flag may be set prior to suspend if the device went through error
> > > recovery:  Drivers commonly invoke pci_restore_state() + pci_save_state()
> > > to restore Config Space after reset.
> > 
> > I guess the only point of pci_save_state() in this case is to set
> > state_saved again so a future pci_restore_state() will work, right?
> > 
> > The actual state being *saved* is pointless, assuming pci_save_state()
> > saves exactly the same data that pci_restore_state() restored.
> > 
> > And these are the pci_save_state() calls you removed with "treewide:
> > Drop pci_save_state() after pci_restore_state()".  Too bad we have to
> > document the behavior we're about to change, but that's what we need
> > to do.  It's just a little clutter to keep in mind for this release.
> 
> Yes.  All of your comments above are correct.
> 
> > > The flag may also be set if drivers call pci_save_state() on probe to
> > > allow for recovery from subsequent errors.
> > > 
> > > The result is that pci_legacy_suspend_late() and pci_pm_freeze_noirq()
> > > don't call pci_save_state() and so the state that will be restored on
> > > resume is the one recorded on last error recovery or on probe, not the one
> > > that the device had on suspend.  If the two states happen to be identical,
> > > there's no problem.
> > 
> > So IIUC the effect is that after this change and the "treewide"
> > change,
> > 
> >   - If the driver uses legacy PM, the state restored on resume will be
> >     the state from suspend instead of the state on probe.
> 
> Right.
> 
> >   - For devices with no driver or a driver without PM, if the device
> >     has already been runtime-suspended, we avoid a pointless
> >     pci_save_state(), so it's an optimization and not logically
> >     related to the legacy PM case.
> 
> It's slightly different:
> 
>   - For devices with no driver or a driver without PM, the state restored
>     on "thaw" and "restore" will be the state from "freeze" instead of the
>     state on probe.
> 
> So the same problem that we have for drivers using legacy PM, we also
> have for devices with no driver or a driver without (modern) PM callbacks,
> but only in the "freeze" codepath (for hibernation).
> 
> In the patch, I made the "pci_dev->state_saved = false" assignment
> conditional on !pm_runtime_suspended() in the "freeze" codepath.
> I didn't do the same in the legacy codepath because none of the
> drivers using legacy PM callbacks seem to be using runtime PM.

Maybe it's moot because we hope there will be no new users of PCI
legacy PM with runtime PM, but I don't think there's anything to
*prevent* that or to protect against out-of-tree drivers.

The implicit assumption that there are no such drivers makes it look
like there's something magic involving state_saved, legacy PM, and
runtime PM.  It might be worth doing the same in the legacy PM path
just for readability.

> The purpose of making it conditional on !pm_runtime_suspended()
> is just that we'd otherwise call pci_save_state() twice:  Once in
> pci_pm_runtime_suspend() and once more in pci_pm_freeze().
> That would be pointless.
> 
> In the commit message, I provided a rationale for the conditionality,
> but inadvertently caused confusion.
> 
> > I'm thinking of something like this for the merge commit and eventual
> > pull request; please correct me if this isn't right:
> > 
> >   Restore the suspend config state, not the state from probe or error
> >   recovery, for drivers using legacy PCI suspend.
> > 
> >   Avoid saving config state again for devices without driver PM if
> >   their state was already saved by runtime suspend.
> 
> I'd suggest instead (feel free to wordsmith as you see fit):
> 
>   Restore the suspend config state, not the state from probe or error
>   recovery, for drivers using legacy PCI suspend.   [ <- unmodified ]
> 
>   Same for devices with no driver or a driver without PM callbacks
>   when the system is hibernated.                   [ <- replacement ]

Stepping back, I guess that when drivers use generic PM, we already
save config state during suspend and restore that state during resume,
and do the same when entering/leaving hibernation.

And the point of this patch is to do the same when drivers lack PM or
use legacy PCI PM, or when devices have no driver?

Maybe third try is the charm?

  For drivers using PCI legacy suspend, save config state at suspend
  so that state, not any earlier state from enumeration, probe, or
  error recovery, will be restored when resuming.

  For devices with no driver or a driver that lacks PM, save config
  state at hibernate so that state, not any earlier state from
  enumeration, probe, or error recovery, will be restored when
  resuming.

IIUC, after "Ensure error recoverability", the PCI core will always
save the state during enumeration, so drivers shouldn't use
pci_save_state() at all unless they make config changes that they want
restored during error recovery?

Or, I guess (sigh) if they do their own power management?

> Mentioning the runtime PM conditionality in the high-level changelog
> is probably not worth it.
> 
> Was I able to clarify all questions?  Please ask again if not.
> 
> Also, in case the meaning of "freeze", "thaw", "restore" isn't clear,
> here's the order of a hibernation sequence (suspend to disk):
> 
>   pci_pm_prepare()
>   pci_pm_freeze()
>   pci_pm_freeze_noirq()
>   <system image is generated>
>   pci_pm_thaw_noirq()
>   pci_pm_thaw()
>   pci_pm_complete()
>   pci_pm_prepare()
>   pci_pm_poweroff()
>   pci_pm_poweroff_late()
>   pci_pm_poweroff_noirq()
>   <system is asleep, then restarted with boot kernel>
>   pci_pm_prepare()
>   pci_pm_freeze()
>   pci_pm_freeze_noirq()
>   <system image is restored, replacing the boot kernel>
>   pci_pm_restore_noirq()
>   pci_pm_restore()
>   pci_pm_complete()
> 
> Note that "freeze" happens twice in the whole sequence.

Thanks, this is extremely helpful.  Copied into my notes.  I guess
this is essentially condensed from
Documentation/driver-api/pm/devices.rst, but it's very helpful to see
the bare bones and your annotations.

Bjorn

