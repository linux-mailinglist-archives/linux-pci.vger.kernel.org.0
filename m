Return-Path: <linux-pci+bounces-7064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F2D8BB70E
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 00:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5044CB22155
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 22:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC27458ACC;
	Fri,  3 May 2024 22:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsnNZQLT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40BF250F8;
	Fri,  3 May 2024 22:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714775286; cv=none; b=rWtyrY9NdM1qJFfBi9NSZNetRjKTwwK2F/l47+HVO+0VhGRxo2uasKmWLN7+yvt/7AX3CUOCObDXHFoIavMOxmBUcGb0WdcIwDBZMRxuOWNLRE0acZQVs7rE0l0eMjkFIvBJfe+7SLxSX1rWugJ3KunnsFJ9/wNsIPWqFMwNJsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714775286; c=relaxed/simple;
	bh=O0uaKV28+bfcdftHvU+JWI3cAKEj5aCSXdnEQBFBSDM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kfyx7Crz6/qDFG/dO7Blz/IOLhceW1+wLj+2VM8u7PpxrLs1Co4E7x4QWmgGvs12saVNEUJXj8gk2iTf1nnW90OCxUzxB7MCd7wbvAhJnoZhl3qG6b3E+t4k5JVI5SGXsu5lEXGAlED+W5lGDKtGOgTcaGtrRIZj6C0tl2ENWWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsnNZQLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF668C2BBFC;
	Fri,  3 May 2024 22:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714775286;
	bh=O0uaKV28+bfcdftHvU+JWI3cAKEj5aCSXdnEQBFBSDM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NsnNZQLT28HBGBYZy1Iw6xEbTnCHdv+cFuf2qTEz7QXyo9455RwVSV0lwyTvqmoHo
	 CDNSjfYx9DZtDvrZeS7oRQ0mjyxNotUm2uFyPhPoUswmaAvtXTxDfM8H8VUJVQgWpS
	 KJRk0Jai/c3bOe1CylBrToTvf5kXQdS66huFLvSeYElbnFbdLREK1A6XHGgeOTIjfG
	 EoEXMJxK6aMuZ1jz9rsBPrErUkoY3I4hgunsBiuAQfhqNq1obcJ0YUfZoUtjkjZ4pN
	 urYS6QxdkLnYSenC4GIc4o58lcDWEk8Y+iSSPGi89a1iXY+RXP/SuPCuN0X/ELx03l
	 vyghy6TYdidjQ==
Date: Fri, 3 May 2024 17:28:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: Jian-Hong Pan <jhp@endlessos.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
Subject: Re: [PATCH v5 4/4] PCI/ASPM: Fix L1.2 parameters when enable link
 state
Message-ID: <20240503222803.GA1608065@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <876d19b7702dc16010b56bce049e2ab60bf68e3b.camel@linux.intel.com>

[+cc Francisco]

On Fri, May 03, 2024 at 12:15:49PM -0700, David E. Box wrote:
> On Fri, 2024-05-03 at 17:45 +0800, Jian-Hong Pan wrote:
> > David E. Box <david.e.box@linux.intel.com> 於 2024年5月1日 週三 上午2:26寫道：
> > > On Tue, 2024-04-30 at 15:46 +0800, Jian-Hong Pan wrote:
> > > > David E. Box <david.e.box@linux.intel.com> 於 2024年4月27日 週六 上午8:03寫道：
> > > > > On Wed, 2024-04-24 at 19:02 +0800, Jian-Hong Pan wrote:
> > > > > > Currently, when enable link's L1.2 features with
> > > > > > __pci_enable_link_state(),
> > > > > > it configs the link directly without ensuring related L1.2 parameters,
> > > > > > such
> > > > > > as T_POWER_ON, Common_Mode_Restore_Time, and LTR_L1.2_THRESHOLD have
> > > > > > been
> > > > > > programmed.
> > > > > > 
> > > > > > This leads the link's L1.2 between PCIe Root Port and child device
> > > > > > gets
> > > > > > wrong configs when a caller tries to enabled it.
> > > > > > 
> > > > > > Here is a failed example on ASUS B1400CEAE with enabled VMD:
> > > > > > 
> > > > > > 10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Processor
> > > > > > PCIe
> > > > > > Controller (rev 01) (prog-if 00 [Normal decode])
> > > > > >     ...
> > > > > >     Capabilities: [200 v1] L1 PM Substates
> > > > > >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> > > > > > L1_PM_Substates+
> > > > > >                   PortCommonModeRestoreTime=45us PortTPowerOnTime=50us
> > > > > >         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > > > > >                    T_CommonMode=45us LTR1.2_Threshold=101376ns
> > > > > >         L1SubCtl2: T_PwrOn=50us
> > > > > > 
> > > > > > 10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue
> > > > > > SN550
> > > > > > NVMe
> > > > > > SSD (rev 01) (prog-if 02 [NVM Express])
> > > > > >     ...
> > > > > >     Capabilities: [900 v1] L1 PM Substates
> > > > > >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > > > > > L1_PM_Substates+
> > > > > >                   PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
> > > > > >         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > > > > >                    T_CommonMode=0us LTR1.2_Threshold=0ns
> > > > > >         L1SubCtl2: T_PwrOn=10us
> > > > > > 
> > > > > > According to "PCIe r6.0, sec 5.5.4", before enabling ASPM L1.2 on the
> > > > > > PCIe
> > > > > > Root Port and the child NVMe, they should be programmed with the same
> > > > > > LTR1.2_Threshold value. However, they have different values in this
> > > > > > case.
> > > > > > 
> > > > > > Invoke aspm_calc_l12_info() to program the L1.2 parameters properly
> > > > > > before
> > > > > > enable L1.2 bits of L1 PM Substates Control Register in
> > > > > > __pci_enable_link_state().
> > > > > > 
> > > > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=218394
> > > > > > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > > > > > ---
> > > > > > v2:
> > > > > > - Prepare the PCIe LTR parameters before enable L1 Substates
> > > > > > 
> > > > > > v3:
> > > > > > - Only enable supported features for the L1 Substates part
> > > > > > 
> > > > > > v4:
> > > > > > - Focus on fixing L1.2 parameters, instead of re-initializing whole
> > > > > > L1SS
> > > > > > 
> > > > > > v5:
> > > > > > - Fix typo and commit message
> > > > > > - Split introducing aspm_get_l1ss_cap() to "PCI/ASPM: Introduce
> > > > > >   aspm_get_l1ss_cap()"
> > > > > > 
> > > > > >  drivers/pci/pcie/aspm.c | 12 ++++++++++++
> > > > > >  1 file changed, 12 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > > > > index c55ac11faa73..553327dee991 100644
> > > > > > --- a/drivers/pci/pcie/aspm.c
> > > > > > +++ b/drivers/pci/pcie/aspm.c
> > > > > > @@ -1402,6 +1402,8 @@ EXPORT_SYMBOL(pci_disable_link_state);
> > > > > >  static int __pci_enable_link_state(struct pci_dev *pdev, int state,
> > > > > > bool
> > > > > > locked)
> > > > > >  {
> > > > > >         struct pcie_link_state *link = pcie_aspm_get_link(pdev);
> > > > > > +       struct pci_dev *child = link->downstream, *parent = link-
> > > > > > >pdev;
> > > > > > +       u32 parent_l1ss_cap, child_l1ss_cap;
> > > > > > 
> > > > > >         if (!link)
> > > > > >                 return -EINVAL;
> > > > > > @@ -1433,6 +1435,16 @@ static int __pci_enable_link_state(struct
> > > > > > pci_dev
> > > > > > *pdev, int state, bool locked)
> > > > > >                 link->aspm_default |= ASPM_STATE_L1_1_PCIPM |
> > > > > > ASPM_STATE_L1;
> > > > > >         if (state & PCIE_LINK_STATE_L1_2_PCIPM)
> > > > > >                 link->aspm_default |= ASPM_STATE_L1_2_PCIPM |
> > > > > > ASPM_STATE_L1;
> > > > > > +       /*
> > > > > > +        * Ensure L1.2 parameters: Common_Mode_Restore_Times,
> > > > > > T_POWER_ON
> > > > > > and
> > > > > > +        * LTR_L1.2_THRESHOLD are programmed properly before enable
> > > > > > bits
> > > > > > for
> > > > > > +        * L1.2, per PCIe r6.0, sec 5.5.4.
> > > > > > +        */
> > > > > > +       if (state & link->aspm_capable & ASPM_STATE_L1_2_MASK) {
> > > > > 
> > > > > This is still mixing PCIE_LINK_STATE flags with ASPM_STATE flags.

FWIW, Ilpo has removed the ASPM_STATE flags, so eventually this would
have to be updated to apply on the current pci/aspm branch.  We're at
rc6 already, so likely this will end up being v6.11 material so you'll
be able to rebase on v6.10-rc1 when it comes out.

> > > > Thanks for your review, but I notice some description in PCIe spec,
> > > > 5.5.4 L1 PM Substates Configuration:
> > > > "Prior to setting either or both of the enable bits for L1.2, the
> > > > values for TPOWER_ON, Common_Mode_Restore_Time, and, if the ASPM L1.2
> > > > Enable bit is to be Set, the LTR_L1.2_THRESHOLD (both Value and Scale
> > > > fields) must be programmed." => I think this includes both "ASPM L1.2
> > > > Enable" and "PCI-PM L1.2 Enable" bits.
> > > 
> > > That's fine. While the spec clearly calls out the ASPM L1.2 Enable bit here,
> > > I
> > > see no harm in including PCI-PM L1.2 in that check. This is what the code
> > > already does in aspm_l1ss_init().
> > > 
> > > The issue is the mixed used of two different types of flags that don't have
> > > the
> > > same meaning. 'state' contains PCIE_LINK_STATE flags which are part of the
> > > caller API to the pci_<enabled/disable>_link_state() functions. The
> > > ASPM_STATE
> > > flags are used internally to aspm.c to track all states and their meaningful
> > > combinations such as ASPM_STATE_L1_2_MASK which includes ASPM L1.2 and PCI-
> > > PM
> > > L1.2. You should not do bit operations between them.
> > > 
> > > Also, you should not require that the timings be calculated only if L1_2 is
> > > enabled. You should calculate the timings as long as it's capable. This is
> > > also
> > > what aspm_l1ss_init() does.
> > > 
> > > The confusion might be over the fact that you are having
> > > __pci_enable_link_state() call aspm_calc_l12_info(). This should have been
> > > handled during initialization of the link in aspm_l1ss_init() and I'm not
> > > sure
> > > why it didn't. Maybe it's because, for VMD, ASPM default state would have
> > > started out all disabled and this somehow led to aspm_l1ss_init() not
> > > getting
> > > called. But looking through the code I don't see it. It would be great if
> > > you
> > > can confirm why they weren't calculated before.
> > 
> > I debug it again.  If I delete the pci_reset_bus() in vmd controller like:
> > 
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > index 87b7856f375a..39bfda4350bf 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -930,25 +930,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd,
> > unsigned long features)
> >         pci_scan_child_bus(vmd->bus);
> >         vmd_domain_reset(vmd);
> > 
> > -       /* When Intel VMD is enabled, the OS does not discover the Root Ports
> > -        * owned by Intel VMD within the MMCFG space. pci_reset_bus() applies
> > -        * a reset to the parent of the PCI device supplied as argument. This
> > -        * is why we pass a child device, so the reset can be triggered at
> > -        * the Intel bridge level and propagated to all the children in the
> > -        * hierarchy.
> > -        */
> > -       list_for_each_entry(child, &vmd->bus->children, node) {
> > -               if (!list_empty(&child->devices)) {
> > -                       dev = list_first_entry(&child->devices,
> > -                                              struct pci_dev, bus_list);
> > -                       ret = pci_reset_bus(dev);
> 
> Hi Nirmal. It's not clear to me from the comment why there's a need to do a bus
> reset. It looks like it is causing misconfiguration of the ASPM L1.2 timings
> which would have been done above in pci_scan_child_bus(). Jian-Hong discovered
> that without the above reset code, the timings are correct.

I don't understand that comment either.  If we don't enumerate the
Root Ports below VMD, it sounds like something is wrong, and reset
doesn't seem like the right fix.

The reset was added by 0a584655ef89 ("PCI: vmd: Fix secondary bus
reset for Intel bridges") for guest reboots.  Maybe Francisco can shed
more light on it.

> This patch recalculates the timings during the call to pci_enable_link_state()
> which is called during pci_bus_walk() below. Originally I thought the
> recalculation might have been needed by all callers to pci_enabled_link_state()
> since it changes the default BIOS configuration. But it looks like the reset is
> the cause and only the VMD driver would need the recalculation as a result. I
> don't see qcom doing a reset.
> 
> Jian-Hong, given this (and assuming the reset is needed) I would not call
> aspm_calc_l12_info() from pci_enable_link_state() but instead try redoing the
> whole ASPM initialization right after the resets are done, maybe by calling
> pci_scan_child_bus() again. What do you think Bjorn?

I would expect pci_reset_bus() to save and restore config space, but
if we don't enumerate all the devices correctly, I suppose we wouldn't
do that for devices we don't know about.

> > -                       if (ret)
> > -                               pci_warn(dev, "can't reset device: %d\n",
> > ret);
> > -
> > -                       break;
> > -               }
> > -       }
> > -
> >         pci_assign_unassigned_bus_resources(vmd->bus);
> > 
> >         pci_walk_bus(vmd->bus, vmd_pm_enable_quirk, &features);
> > 
> > Although PCI-PM_L1.2 is disabled, both PCI bridge and the NVMe's
> > LTR1.2_Threshold are configured as 101376ns:
> > 
> > 10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core
> > Processor PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal
> > decode])
> > ...
> >   Capabilities: [200 v1] L1 PM Substates
> >   L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
> >     PortCommonModeRestoreTime=45us PortTPowerOnTime=50us
> >   L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >      T_CommonMode=45us LTR1.2_Threshold=101376ns
> >   L1SubCtl2: T_PwrOn=50us
> > 
> > 10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD
> > Blue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
> > ...
> >   Capabilities: [900 v1] L1 PM Substates
> >   L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
> >     PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
> >   L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >      T_CommonMode=0us LTR1.2_Threshold=101376ns
> >   L1SubCtl2: T_PwrOn=50us
> > 
> > Then, I apply the patch "PCI: vmd: Set PCI devices to D0 before enable
> > PCI PM's L1 substates".  Both PCI bridge and the NVMe's PCI-PM_L1.2 is
> > enabled and LTR1.2_Threshold is configured as 101376ns.
> > 
> > 10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core
> > Processor PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal
> > decode])
> > ...
> >   Capabilities: [200 v1] L1 PM Substates
> >   L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
> >     PortCommonModeRestoreTime=45us PortTPowerOnTime=50us
> >   L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >      T_CommonMode=45us LTR1.2_Threshold=101376ns
> >   L1SubCtl2: T_PwrOn=50us
> > 
> > 10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD
> > Blue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
> > ...
> >   Capabilities: [900 v1] L1 PM Substates
> >   L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
> >     PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
> >   L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >      T_CommonMode=0us LTR1.2_Threshold=101376ns
> >   L1SubCtl2: T_PwrOn=50us
> > 
> > I do not know VMD very much.  However, from the test result, it looks
> > like LTR1.2_Threshold has been configured properly originally.  But,
> > LTR1.2_Threshold is misconfigured by 'pci_reset_bus()'.
> > ...
> > > > > 'state' should not even matter.
> > > > > The timings should always be calculated and programmed as long
> > > > > as L1_2 is capable. That way the timings are ready even if L1_2 isn't
> > > > > being
> > > > > enabled now (in case the user enables it later).
> > > > > 
> > > > > > +               parent_l1ss_cap = aspm_get_l1ss_cap(parent);
> > > > > > +               child_l1ss_cap = aspm_get_l1ss_cap(child);
> > > > > > +               aspm_calc_l12_info(link, parent_l1ss_cap,
> > > > > > child_l1ss_cap);
> > > > > > +       }
> > > > > >         pcie_config_aspm_link(link, policy_to_aspm_state(link));
> > > > > > 
> > > > > >         link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
> > > > > 
> > > 
> 

