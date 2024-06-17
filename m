Return-Path: <linux-pci+bounces-8897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD23B90BFBB
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 01:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C09282349
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 23:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF935194C94;
	Mon, 17 Jun 2024 23:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmHCl3qr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80D6163A97;
	Mon, 17 Jun 2024 23:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718666323; cv=none; b=MiCVo+lKY4yEz/DMRlUqHlCwu1sg/uUJkZvNpsFf8AI7AVjxyhyhJKjgbkhISMGnCFoF2dl6yE1OjckIATo/tmMElwaVl5lwQSaUiMmFx2548tfzImcpWp+qUdatSynaanqPUXorxuFTiO9GBQeGn9tAggoUjhT4mRUZ+g5Fjlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718666323; c=relaxed/simple;
	bh=OP+bYZ7lqGXeuYHiHDI8bcK2qAwONZp4ir5STUjqMVk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tKLe2153Pn1xmCTp46VVB6wTsER2L2/FIeLRa31RDKED9nIFBS9nB4ZaHcUD/X7vJgJqL9+brXQgf/gj9yke4ZLKHRrRLT97jBni4SOroKvg1V3IeOYDn51lw1yBg85rKzOrb6fNYmh8f2O/1mV1PTPiHksakbjNzuLMwiV7Bo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmHCl3qr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106E3C2BD10;
	Mon, 17 Jun 2024 23:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718666323;
	bh=OP+bYZ7lqGXeuYHiHDI8bcK2qAwONZp4ir5STUjqMVk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nmHCl3qrAZcW2t9eK7zvS6mq4UTdtfPninSLKL+XNI6oeLLyWd2jn0oWN6EVSAj6c
	 O7+vHwlBpmsv3dwTsnjd7LtFq9Jfu07yw6SohgJAT6dUKrrvlwmkT4qNTOVCcOpBAt
	 SCN+l/kFcGPCSH/mREW3UisnAInjzwTZGywtVa3Sc5h+evdbM5iWm2D/BOy6WHd7x+
	 XcKCdtySJoAROV61pZVinYe23Tmg8WH0Bzx/HmtgugKmVabRkEZu8yETek10OtfF7g
	 sF8FwkUKUQU1CTd134yyQDqsWFGjTZCdruW0RegxWQuh9h0vEK/PHQxjD9waWhCoq2
	 jZUCKDJUn+6BQ==
Date: Mon, 17 Jun 2024 18:18:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Lukas Wunner <lukas@wunner.de>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Bowman Terry <terry.bowman@amd.com>,
	Hagan Billy <billy.hagan@amd.com>,
	Simon Guinot <simon.guinot@seagate.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v2] PCI: pciehp: Clear LBMS on hot-remove to prevent link
 speed reduction
Message-ID: <20240617231841.GA1232294@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4241291f-7e83-c878-6bff-59649d630410@amd.com>

On Mon, Jun 17, 2024 at 03:51:57PM -0700, Smita Koralahalli wrote:
> Hi Bjorn,
> 
> On 6/17/2024 1:09 PM, Bjorn Helgaas wrote:
> > On Thu, May 16, 2024 at 08:47:48PM +0000, Smita Koralahalli wrote:
> > > Clear Link Bandwidth Management Status (LBMS) if set, on a hot-remove
> > > event.
> > > 
> > > The hot-remove event could result in target link speed reduction if LBMS
> > > is set, due to a delay in Presence Detect State Change (PDSC) happening
> > > after a Data Link Layer State Change event (DLLSC).
> > > 
> > > In reality, PDSC and DLLSC events rarely come in simultaneously. Delay in
> > > PDSC can sometimes be too late and the slot could have already been
> > > powered down just by a DLLSC event. And the delayed PDSC could falsely be
> > > interpreted as an interrupt raised to turn the slot on. This false process
> > > of powering the slot on, without a link forces the kernel to retrain the
> > > link if LBMS is set, to a lower speed to restablish the link thereby
> > > bringing down the link speeds [2].
> > 
> > Not sure we need PDSC and DLLSC details to justify clearing LBMS if it
> > has no meaning for an empty slot?
> 
> I'm trying to also answer your below question here..
> 
> >I guess the slot is empty, so retraining
> > is meaningless and will always fail.  Maybe avoiding it avoids a
> > delay?  Is the benefit that we get rid of the message and a delay?"
> 
> The benefit of this patch is to "avoid link speed drops" on a hot remove
> event if LBMS is set and DLLLA is clear. But I'm not trying to solve delay
> issues here..
> 
> I included the PDSC and DLLSC details as they are the cause for link speed
> drops on a remove event. On an empty slot, DLLLA is cleared and LBMS may or
> may not be set. And, we see cases of link speed drops here, if PDSC happens
> on an empty slot.
> 
> We know for the fact that slot becomes empty if either of the events PDSC or
> DLLSC occur. Also, either of them do not wait for the other to bring down
> the device and mark the slot as "empty". That is the reason I was also
> thinking of waiting on both events PDSC and DLLSC to bring down the device
> as I mentioned in my comments in V1. We could eliminate link speed drops by
> taking this approach as well. But then we had to address cases where PDSC is
> hardwired to zero.
> 
> On our AMD systems, we expect to see both events on an hot-remove event.
> But, mostly we see DLLSC happening first, which does the job of marking the
> slot empty. Now, if the PDSC event is delayed way too much and if it occurs
> after the slot becomes empty, kernel misinterprets PDSC as the signal to
> re-initialize the slot and this is the sequence of steps the kernel takes:
> 
> pciehp_handle_presence_or_link_change()
>   pciehp_enable_slot()
>     __pciehp_enable_slot()
>         board_added
>           pciehp_check_link_status()
>             pcie_wait_for_link()
>               pcie_wait_for_link_delay()
>                 pcie_failed_link_retrain()
> 
> while doing so, it hits the case of DLLLA clear and LBMS set and brings down
> the speeds.

So I guess LBMS currently remains set after a device has been removed,
so the slot is empty, and later when a device is hot-added, *that*
device sees a lower-than expected link speed?

> The issue of PDSC and DLLSC never occurring simultaneously was a known thing
> from before and it wasn't breaking anything functionally as the kernel would
> just exit with the message: "No link" at pciehp_check_link_status().
> 
> However, Commit a89c82249c37 ("PCI: Work around PCIe link training
> failures") introduced link speed downgrades to re-establish links if LBMS is
> set, and DLLLA is clear. This caused the devices to operate at 2.5GT/s after
> they were plugged-in which were previously operating at higher speeds before
> hot-remove.
> 
> > > According to PCIe r6.2 sec 7.5.3.8 [1], it is derived that, LBMS cannot
> > > be set for an unconnected link and if set, it serves the purpose of
> > > indicating that there is actually a device down an inactive link.
> > 
> > I see that r6.2 added an implementation note about DLLSC, but I'm not
> > a hardware person and can't follow the implication about a device
> > present down an inactive link.
> > 
> > I guess it must be related to the fact that LBMS indicates either
> > completion of link retraining or a change in link speed or width
> > (which would imply presence of a downstream device).  But in both
> > cases I assume the link would be active.
> > 
> > But IIUC LBMS is set by hardware but never cleared by hardware, so if
> > we remove a device and power off the slot, it doesn't seem like LBMS
> > could be telling us anything useful (what could we do in response to
> > LBMS when the slot is empty?), so it makes sense to me to clear it.
> > 
> > It seems like pciehp_unconfigure_device() does sort of PCI core and
> > driver-related things and possibly could be something shared by all
> > hotplug drivers, while remove_board() does things more specific to the
> > hotplug model (pciehp, shpchp, etc).
> > 
> >  From that perspective, clearing LBMS might fit better in
> > remove_board().  In that case, I wonder whether it should be done
> > after turning off slot power?  This patch clears is *before* turning
> > off the power, so I wonder if hardware could possibly set it again
> > before the poweroff?
> 
> Yeah by talking to HW people I realized that HW could interfere possibly
> anytime to set LBMS when the slot power is on. Will change it to include in
> remove_board().
> 
> > > However, hardware could have already set LBMS when the device was
> > > connected to the port i.e when the state was DL_Up or DL_Active. Some
> > > hardwares would have even attempted retrain going into recovery mode,
> > > just before transitioning to DL_Down.
> > > 
> > > Thus the set LBMS is never cleared and might force software to cause link
> > > speed drops when there is no link [2].
> > > 
> > > Dmesg before:
> > > 	pcieport 0000:20:01.1: pciehp: Slot(59): Link Down
> > > 	pcieport 0000:20:01.1: pciehp: Slot(59): Card present
> > > 	pcieport 0000:20:01.1: broken device, retraining non-functional downstream link at 2.5GT/s
> > > 	pcieport 0000:20:01.1: retraining failed
> > > 	pcieport 0000:20:01.1: pciehp: Slot(59): No link
> > > 
> > > Dmesg after:
> > > 	pcieport 0000:20:01.1: pciehp: Slot(59): Link Down
> > > 	pcieport 0000:20:01.1: pciehp: Slot(59): Card present
> > > 	pcieport 0000:20:01.1: pciehp: Slot(59): No link
> > 
> > I'm a little confused about the problem being solved here.  Obviously
> > the message is extraneous.  I guess the slot is empty, so retraining
> > is meaningless and will always fail.  Maybe avoiding it avoids a
> > delay?  Is the benefit that we get rid of the message and a delay?
> > 
> > > [1] PCI Express Base Specification Revision 6.2, Jan 25 2024.
> > >      https://members.pcisig.com/wg/PCI-SIG/document/20590
> > > [2] Commit a89c82249c37 ("PCI: Work around PCIe link training failures")
> > > 
> > > Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
> > 
> > Lukas asked about this; did you confirm that it is related?  Asking
> > because the Fixes tag may cause this to be backported along with
> > a89c82249c37.
> 
> Yeah, without this patch we won't see link speed drops.
> 
> Thanks,
> Smita
> 
> > 
> > > Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> > > ---
> > > Link to v1:
> > > https://lore.kernel.org/all/20240424033339.250385-1-Smita.KoralahalliChannabasappa@amd.com/
> > > 
> > > v2:
> > > 	Cleared LBMS unconditionally. (Ilpo)
> > > 	Added Fixes Tag. (Lukas)
> > > ---
> > >   drivers/pci/hotplug/pciehp_pci.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
> > > index ad12515a4a12..dae73a8932ef 100644
> > > --- a/drivers/pci/hotplug/pciehp_pci.c
> > > +++ b/drivers/pci/hotplug/pciehp_pci.c
> > > @@ -134,4 +134,7 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
> > >   	}
> > >   	pci_unlock_rescan_remove();
> > > +
> > > +	pcie_capability_write_word(ctrl->pcie->port, PCI_EXP_LNKSTA,
> > > +				   PCI_EXP_LNKSTA_LBMS);
> > >   }
> > > -- 
> > > 2.17.1
> > > 

