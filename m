Return-Path: <linux-pci+bounces-12315-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E670A961821
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 21:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A940B2231F
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 19:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF1B1D2F5E;
	Tue, 27 Aug 2024 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVXWTM4u"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4E5132132;
	Tue, 27 Aug 2024 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724787855; cv=none; b=FlUwrIaRDEMoV5bs2uFAeVVXPypGOkaxdAVGsyNMRjFWBioH3c3MnE3UDKJ3BYedPMrJNs9+oGDZd6QHUvxcPAXLtxiH68V1DhyzlE8phzij61ATJumzoZBBTqV9H9Q92vDw3OvCRfWhsZVW8A1KuAOIO9C7kuL4T4X2z21oTHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724787855; c=relaxed/simple;
	bh=cWcqou7ktN+DCizj7qq+pkUDcuFVknbvf6n2uiD2GNE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KcVmg1NAobmRj93A7QgikQRG/Z048o/BbBxv2nB6Nzr5r4SrkYlmiTwLtD9iYAC8aq1fxzUwYOAgw2lZxOfCzphyuZjgh4x1aoYaR5xdlFxsDO6YAt/Km7/G9UQ0E31rpNUXQejEE8EVhFzMWliCtwnN37+nNxTeysBgCBy4LIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVXWTM4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58737C4DE02;
	Tue, 27 Aug 2024 19:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724787854;
	bh=cWcqou7ktN+DCizj7qq+pkUDcuFVknbvf6n2uiD2GNE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FVXWTM4u9sZttTcUE+5fzLJWeHh+0hh9XefscDDXkwF19uJgVsH0qQIqVzOX/zrI8
	 4tjVXH6JD7RkSpe8ijrhQURQntHnrzeG0aYbS5sE7skHIdMg00Nb+j5HsOIMSR2K0m
	 pvNh6aL8fqVR3B5jgl9KtisTuXDEOd7XP77zbntZkEwsyFbAoM7DGzHAN+kzE6C/mv
	 8C4P7YpUlsNDzHtgIB4Qy+nipzbzvK+UBMciZYt8sjY7F90azJjbIWLLX5hWapNYsU
	 ZTGcZAa1SxNpbPEgAlMtufN7zUJaGRXpbDXeaClQgqvu+kTR2AUSSw9+QN9r7eGQo2
	 dNFqB9kIg05uw==
Date: Tue, 27 Aug 2024 14:44:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Mario Limonciello <superm1@kernel.org>, Gary Li <Gary.Li@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	Daniel Drake <drake@endlessos.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Duc Dang <ducdang@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 2/5] PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in
 pci_dev_wait()
Message-ID: <20240827194412.GA526339@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f43d44f2-004d-4b67-8db9-2f474c3e6d30@amd.com>

[+cc Rafael for ACPI power transition from D3cold to D0 delay]

On Mon, Aug 26, 2024 at 02:16:34PM -0500, Mario Limonciello wrote:
> On 8/23/2024 14:54, Bjorn Helgaas wrote:
> > On Fri, Aug 23, 2024 at 10:40:20AM -0500, Mario Limonciello wrote:
> > > If a dock is plugged in at the same time as autosuspend delay
> > > then this can cause malfunctions in the USB4 stack. This happens
> > > because the device is still in D3cold at the time that the PCI
> > > core handed control back to the USB4 stack.
> ...

> > > A device that has gone through a reset may return a value in
> > > PCI_COMMAND but that doesn't mean it's finished transitioning to
> > > D0.  For devices that support power management explicitly check
> > > PCI_PM_CTRL on everything but system resume to ensure the
> > > transition happened.
> ...

> > > Devices that don't support power management and system resume
> > > will continue to use PCI_COMMAND.

> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -1309,21 +1309,33 @@ static int pci_dev_wait(struct pci_dev *dev, enum pci_reset_type reset_type, int
> > >   	 * the read (except when CRS SV is enabled and the read was for the
> > >   	 * Vendor ID; in that case it synthesizes 0x0001 data).
> > >   	 *
> > > -	 * Wait for the device to return a non-CRS completion.  Read the
> > > -	 * Command register instead of Vendor ID so we don't have to
> > > -	 * contend with the CRS SV value.
> > > +	 * Wait for the device to return a non-CRS completion.  On devices
> > > +	 * that support PM control and on waits that aren't part of system
> > > +	 * resume read the PM control register to ensure the device has
> > > +	 * transitioned to D0.  On devices that don't support PM control,
> > > +	 * or during system resume read the command register to instead of
> > > +	 * Vendor ID so we don't have to contend with the CRS SV value.
> > >   	 */
> > >   	for (;;) {
> > > -		u32 id;
> > > -
> > >   		if (pci_dev_is_disconnected(dev)) {
> > >   			pci_dbg(dev, "disconnected; not waiting\n");
> > >   			return -ENOTTY;
> > >   		}
> > > -		pci_read_config_dword(dev, PCI_COMMAND, &id);
> > > -		if (!PCI_POSSIBLE_ERROR(id))
> > > -			break;
> > > +		if (dev->pm_cap && reset_type != PCI_DEV_WAIT_RESUME) {
> > > +			u16 pmcsr;
> > > +
> > > +			pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> > > +			if (!PCI_POSSIBLE_ERROR(pmcsr) &&
> > > +			    (pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D0)
> > > +				break;
> > > +		} else {
> > > +			u32 id;
> > > +
> > > +			pci_read_config_dword(dev, PCI_COMMAND, &id);
> > > +			if (!PCI_POSSIBLE_ERROR(id))
> > > +				break;
> > > +		}
> > 
> > What is the rationale behind using PCI_PM_CTRL in some cases and
> > PCI_COMMAND in others?
> 
> We saw a deadlock during resume from suspend when PCI_PM_CTRL was used for
> all cases that supported dev->pm_cap.
> 
> > Is there some spec language we can cite for
> > this?
> 
> Perhaps it being a "cold reset" during resume?
> 
> > IIUC, pci_dev_wait() waits for a device to be ready after a reset
> > (FLR, D3hot->D0 transition for devices where No_Soft_Reset is clear,
> > DPC) and after power-up from D3cold (pci_pm_bridge_power_up_actions()).
> > I think device readiness in all of these cases is covered by PCIe
> > r6.0, sec 6.6.1.
> ...

> > If the Root Port above the device supports Configuration RRS
> > Software Visibility, I think we probably should use that here
> > instead of either PCI_COMMAND or PCI_PM_CTRL.
> 
> I did check and in this case the root port the USB4 routers are
> connected to support this.
> 
> How do you think this should be done instead?
> 
> > SR-IOV VFs don't implement Vendor ID, which might complicate this
> > a little.  But it niggles in my mind that there may be some other
> > problem beyond that.  Maybe Alex remembers.
> > 
> > Anyway, if we meet the requirements of sec 6.6.1, the device
> > should be ready to respond to config requests, and I assume that
> > also means the device is in D0.
> 
> Within that section there is a quote to point out:
> 
> "
> To allow components to perform internal initialization, system
> software must wait a specified minimum period following exit from a
> Conventional Reset of one or more devices before it is permitted to
> issue Configuration Requests to those devices
> "
> 
> In pci_power_up() I don't really see any hardcoded delays
> specifically for this case of leaving D3cold. The PCI PM spec
> specifies that it will take "Full context restore or boot latency".
> I don't think it's reasonable to have NO delay.

I agree, leaving D3cold means "applying power to the device", and PCIe
r6.0, sec 6.6.1, says that's a Fundamental Reset:

  A Fundamental Reset must occur following the application of power to
  the component. This is called a Cold Reset.

So we need a delay similar to what we do in
pci_bridge_wait_for_secondary_bus().  I don't know whether that is
supposed to happen somewhere on the ACPI side or in the PCI side, but
my inclination would be the PCI side because the delay isn't really
platform-specific, it's specified by the PCI specs, and the OS needs
to manage the RRS Software Visibility retries and features like
Readiness Notifications.

pci_set_low_power_state() contains corresponding delays for putting
devices in D1, D2, and D3hot.

Maybe the D3cold -> D0 delays should be in
platform_pci_set_power_state()?  I think pci_power_up() is the only
caller that sets the state to D0, and it assumes the device is
Configuration Ready when platform_pci_set_power_state() returns:

  pci_power_up
    platform_pci_set_power_state
    pci_read_config_word(PCI_PM_CTRL)

So I think we need basically the same delays and pci_dev_wait() stuff
in this path.

Bjorn

