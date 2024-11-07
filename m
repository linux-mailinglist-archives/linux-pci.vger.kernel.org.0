Return-Path: <linux-pci+bounces-16254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5349E9C0A46
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 16:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63101F22DED
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 15:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3799E212D2B;
	Thu,  7 Nov 2024 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asGIqap4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDD3CA6F;
	Thu,  7 Nov 2024 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730994118; cv=none; b=MKBKA8jINq9X58pKn90rm0a6OKs2ankuR/YvjiYjvw8EcBPPeTvuGYLjquO2kxZv2Zs3Tb5notXCgGn8dlpXWcrBtBYlWunY2WnSKHNK8Wrg90PuAL2vcJ1BTLYTyoqiCP4pUQKBSZJUCNk/sODmOuB5nnW6JoobWW7eKT9Lr8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730994118; c=relaxed/simple;
	bh=8l9PhwwSi50ZqEVFZ+8sMJQD5P5c9Uny8ifUxR/Yf9M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qiqSGvHISsdKmwjvXewthro65Ufzt5CKWrWsRyYzD8IYpIf/oBzK4bKGaUBj0gLnIupIOcAbhi/SqlDxt9lvANLNlcf2A3HfyEAUFNxTXV/NR7ubgKKAPeyyYPFV7wpSs/mXmBqqE7Uota0KoqnDmcAh5ZHsyMSyvtcTp91VuOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asGIqap4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B6BC4CECC;
	Thu,  7 Nov 2024 15:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730994117;
	bh=8l9PhwwSi50ZqEVFZ+8sMJQD5P5c9Uny8ifUxR/Yf9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=asGIqap4DxxNlkQU7EfMbhKYbBT7owg9EAXp0MA0dP4WGU0RVWtixT+PnrdEmhmwe
	 vVWlhpZpSdfvYG+SxVLO3cVVi/YqVGEFEV7MEKgRZnyRONAA+zOC689LaFIK7VgME0
	 4oy86+F6LQ5bbcDZhCMycex+mbH8fc11Z9OAdk/ItpqLCzckSOerfasxQoZhabn6Bp
	 XWIYjdAlr2KlDMj4LNnMocE43yVR3F2yENCaKw+5/qhP5aHN1sOEvDPRDxQ95l6D3K
	 sEXXFB9SdD/v1WEZ9lTiEYkQ+LigTXfW89dMHF7rBrMPQVhz3Du8L2O3ZKarnNOtQm
	 Wjk8AertTcf4g==
Date: Thu, 7 Nov 2024 09:41:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jian-Hong Pan <jhp@endlessos.org>
Cc: Johan Hovold <johan@kernel.org>,
	David Box <david.e.box@linux.intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@endlessos.org
Subject: Re: [PATCH v12 3/3] PCI/ASPM: Make pci_save_aspm_l1ss_state save
 both child and parent's L1SS configuration
Message-ID: <20241107154156.GA1615072@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPpJ_ecu077+7G=J4w_9LMqw4ZX5qt4H9EirOL-O3nN-peqtfg@mail.gmail.com>

On Thu, Nov 07, 2024 at 05:19:49PM +0800, Jian-Hong Pan wrote:
> Bjorn Helgaas <helgaas@kernel.org> 於 2024年11月6日 週三 上午6:59寫道：
> > On Tue, Oct 01, 2024 at 04:34:42PM +0800, Jian-Hong Pan wrote:
> > > PCI devices' parameters on the VMD bus have been programmed properly
> > > originally. But, cleared after pci_reset_bus() and have not been restored
> > > correctly. This leads the link's L1.2 between PCIe Root Port and child
> > > device gets wrong configs.
> > >
> > > Here is a failed example on ASUS B1400CEAE with enabled VMD. Both PCIe
> > > bridge and NVMe device should have the same LTR1.2_Threshold value.
> > > However, they are configured as different values in this case:
> > >
> > > 10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core Processor PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal decode])
> > >   ...
> > >   Capabilities: [200 v1] L1 PM Substates
> > >     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
> > >       PortCommonModeRestoreTime=45us PortTPowerOnTime=50us
> > >     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > >       T_CommonMode=0us LTR1.2_Threshold=0ns
> > >     L1SubCtl2: T_PwrOn=0us
> > >
> > > 10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD Blue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
> > >   ...
> > >   Capabilities: [900 v1] L1 PM Substates
> > >     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
> > >       PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
> > >     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > >       T_CommonMode=0us LTR1.2_Threshold=101376ns
> > >     L1SubCtl2: T_PwrOn=50us
> > >
> > > Here is VMD mapped PCI device tree:
> > >
> > > -+-[0000:00]-+-00.0  Intel Corporation Device 9a04
> > >  | ...
> > >  \-[10000:e0]-+-06.0-[e1]----00.0  Sandisk Corp WD Blue SN550 NVMe SSD
> > >               \-17.0  Intel Corporation Tiger Lake-LP SATA Controller
> > >
> > > When pci_reset_bus() resets the bus [e1] of the NVMe, it only saves and
> > > restores NVMe's state before and after reset. Then, when it restores the
> > > NVMe's state, ASPM code restores L1SS for both the parent bridge and the
> > > NVMe in pci_restore_aspm_l1ss_state(). The NVMe's L1SS is restored
> > > correctly. But, the parent bridge's L1SS is restored with a wrong value 0x0
> > > because the parent bridge's L1SS wasn't saved by pci_save_aspm_l1ss_state()
> > > before reset.
> >
> > There's nothing specific to VMD here, is there?  This whole log looks
> > like it should be made generic.  The VMD *example* is OK, but the
> > justification should not be VMD-specific.  This last paragraph seems
> > to be the kernel of the whole thing, and I don't think it's specific
> > to either VMD or NVMe.
> 
> It is a generic fix. Lets see how to modify the wording here.
> 
> > > So, if the PCI device has a parent, make pci_save_aspm_l1ss_state() save
> > > the parent's L1SS configuration, too. This is symmetric on
> > > pci_restore_aspm_l1ss_state().
> > >
> > > Link: https://lore.kernel.org/linux-pci/CAPpJ_eexU0gCHMbXw_z924WxXw0+B6SdS4eG9oGpEX1wmnMLkQ@mail.gmail.com/
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218394
> > > Fixes: 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability for suspend/resume")
> > > Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > > ---
> > > v9:
> > > - Drop the v8 fix about drivers/pci/pcie/aspm.c. Use this in VMD instead.
> > >
> > > v10:
> > > - Drop the v9 fix about drivers/pci/controller/vmd.c
> > > - Fix in PCIe ASPM to make it symmetric between pci_save_aspm_l1ss_state()
> > >   and pci_restore_aspm_l1ss_state()
> > >
> > > v11:
> > > - Introduce __pci_save_aspm_l1ss_state as a resusable helper function
> > >   which is same as the original pci_configure_aspm_l1ss
> > > - Make pci_save_aspm_l1ss_state invoke __pci_save_aspm_l1ss_state for
> > >   both child and parent devices
> > > - Smooth the commit message
> > >
> > > v12:
> > > - Update the commit message
> > >
> > >  drivers/pci/pcie/aspm.c | 20 +++++++++++++++++++-
> > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > index bd0a8a05647e..17cdf372f7e0 100644
> > > --- a/drivers/pci/pcie/aspm.c
> > > +++ b/drivers/pci/pcie/aspm.c
> > > @@ -79,7 +79,7 @@ void pci_configure_aspm_l1ss(struct pci_dev *pdev)
> > >                       ERR_PTR(rc));
> > >  }
> > >
> > > -void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> > > +static void __pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> > >  {
> > >       struct pci_cap_saved_state *save_state;
> > >       u16 l1ss = pdev->l1ss;
> > > @@ -101,6 +101,24 @@ void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> > >       pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, cap++);
> > >  }
> > >
> > > +void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> > > +{
> > > +     struct pci_dev *parent;
> > > +
> > > +     __pci_save_aspm_l1ss_state(pdev);
> >
> > Is there any point in saving the "pdev" state if there's no parent?
> 
> This is a tricky part.  If the code path comes from:
> pci_save_state()
>     pci_save_pcie_state()
>         pci_save_aspm_l1ss_state()
> 
> and the pci device is a PCIe bridge, then should the device save ASPM
> L1SS state?

This is a good question and is separate from the fundamental problem
being solved here.  If we zoom in and focus specifically on the case
where we restore garbage to the bridge L1SS config, I think this will
be more understandable.

Start by making the overall structure similar to
pci_restore_aspm_l1ss_state().  If the early exits end up being
slightly different because of this concern, that's fine, and we can
add a short comment about why they are different.

> 1. This code tries to save its ASPM L1SS state directly. Then, when
> the child device saves ASPM L1SS state, it does not need to save the
> PCIe bridge's ASPM L1SS state again.
> 
> 2 .However, if we shift this "__pci_save_aspm_l1ss_state(pdev);" after
> "if (!pdev->bus || !pdev->bus->self)" condition check, then it should
> save both the device and parent's ASPM L1SS state. Because, PCIe
> bridge does not have a parent device and will not save its ASPM L1SS
> state by itself.
> 
> Following the 2nd scenario, is it possible to only save & restore a
> PCIe bridge, and not touch children devices?  In this condition,
> pci_restore_aspm_l1ss_state() will not restore the PCIe bridge's ASPM
> L1SS state itself, because it does not have a parent. Only the child
> device can restore the PCIe bridge's ASPM L1SS state via
> pci_restore_aspm_l1ss_state(). So, lets trace who invoke
> pci_restore_aspm_l1ss_state():
> pci_restore_state()
>     "dev->state_saved" condition check
>     dev->state_saved()
>         pci_restore_aspm_l1ss_state()
> 
> The "dev->state_saved" condition check guards it. If the child device
> has not been saved, then it will not go to restoration. So, the parent
> device's ASPM L1SS state will not be restored by 0. => Okay
> 
> Consider that ASPM L1SS only works when both the link's parent and
> child devices are configured and powered correctly. The 2nd scenario
> seems to make more sense.
> 
> > > +     /*
> > > +      * To be symmetric on pci_restore_aspm_l1ss_state(), save parent's L1
> > > +      * substate configuration, if the parent has not saved state.
> > > +      */
> > > +     if (!pdev->bus || !pdev->bus->self)
> > > +             return;
> >
> > Is "pdev->bus == NULL" possible here even though it doesn't seem
> > possible in pci_restore_aspm_l1ss_state()?
> 
> After boot & test again and again, it seems the devices already have
> their bus at this point.
> 
> However, after I traced the code, I found two possible paths:
> 1. pcie_config_aspm_link() -> pci_save_aspm_l1ss_state():  Here is
> already the link.  So, has the bus.
> 2. pci_save_state() -> pci_save_pcie_state() ->
> pci_save_aspm_l1ss_state(): pci_save_state() is an exported function
> which can be invoked at any point. So, I am not sure about this part.
> And, that is why I make it check "pdev->bus == NULL" here.

Is there any case where we build a pci_dev that can have pdev->bus ==
NULL?  I don't think so.

> > > +     parent = pdev->bus->self;
> > > +     if (!parent->state_saved)
> > > +             __pci_save_aspm_l1ss_state(parent);
> > > +}
> >
> > I see the suggestion for a helper here, but I'm not convinced.
> > pci_save_aspm_l1ss_state() and pci_restore_aspm_l1ss_state() should
> > *look* similar, and a helper makes them less similar.
> >
> > I think you should go to some effort to follow the
> > pci_restore_aspm_l1ss_state() structure, as much as possible doing the
> > same declarations, checks, and lookups in the same order, e.g.:
> >
> >   struct pci_cap_saved_state *pl_save_state, *cl_save_state;
> >   struct pci_dev *parent = pdev->bus->self;
> >
> >   if (pcie_downstream_port(pdev) || !parent)
> >           return;
> >
> >   if (!pdev->l1ss || !parent->l1ss)
> >           return;
> >
> >   cl_save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
> >   pl_save_state = pci_find_saved_ext_cap(parent, PCI_EXT_CAP_ID_L1SS);
> >   if (!cl_save_state || !pl_save_state)
> >           return;
> >
> > Bjorn

